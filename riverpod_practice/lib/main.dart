import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/state.dart';

void main() => runApp(
      ProviderScope(
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GestureDetector(
            onTap: () => FocusManager.instance.rootScope.requestFocus(),
            child: const HomePage()),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "TODOS",
            style: Theme.of(context).textTheme.headline3?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
          actions: const [_Menu()],
          bottom: const TabBar(
            tabs: [
              Text(
                "List",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                "Completed",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(children: [
            Column(
              children: [
                const AddTodoPanel(),
                const SizedBox(height: 20),
                Expanded(child: Consumer(
                  builder: (context, ref, child) {
                    return ListView(children: [
                      ...ref.watch(todosProvider).map((todo) => ProviderScope(
                            overrides: [_currentTodo.overrideWithValue(todo)],
                            child: const TodoItem(),
                          ))
                    ]);
                  },
                ))
              ],
            ),
            Consumer(builder: (context, ref, child) {
              return ListView(
                children: [
                  ...ref.watch(completeTodos).map(
                        (todo) => ProviderScope(
                            overrides: [_currentTodo.overrideWithValue(todo)],
                            child: const TodoItem()),
                      )
                ],
              );
            }),
          ]),
        ),
      ),
    );
  }
}

final _currentTodo = Provider<Todo>((ref) => throw UnimplementedError());

class TodoItem extends StatefulWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;

  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, selecet) {
        final todo = ref.watch(_currentTodo);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red),
            onDismissed: (_) =>
                ref.read(todosProvider.notifier).remove(todo.id),
            child: FocusScope(
              child: Focus(
                onFocusChange: (isFocus) {
                  if (!isFocus) {
                    setState(() {
                      hasFocus = false;
                    });
                    ref.read(todosProvider.notifier).edit(
                          todo.id,
                          _textEditingController.text,
                        );
                  } else {
                    _textEditingController.text = todo.description;
                    _textEditingController.selection =
                        TextSelection.fromPosition(
                      TextPosition(
                        offset: _textEditingController.text.length,
                      ),
                    );
                  }
                },
                child: ListTile(
                  onTap: () {
                    setState(() {
                      hasFocus = true;
                    });
                    _focusNode.requestFocus();
                  },
                  title: hasFocus
                      ? TextField(
                          controller: _textEditingController,
                          focusNode: _focusNode,
                        )
                      : Text(todo.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: todo.completed,
                        onChanged: (_) =>
                            ref.read(todosProvider.notifier).toggle(todo.id),
                      ),
                      IconButton(
                          onPressed: () =>
                              ref.read(todosProvider.notifier).remove(todo.id),
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AddTodoPanel extends ConsumerStatefulWidget {
  const AddTodoPanel({Key? key}) : super(key: key);

  @override
  _AddTodoPanelState createState() => _AddTodoPanelState();
}

class _AddTodoPanelState extends ConsumerState<AddTodoPanel> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onSubmit([String? value]) {
    ref.read(todosProvider.notifier).add(_textEditingController.value.text);
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(hintText: "New Todo"),
              onSubmitted: _onSubmit,
            ),
          ),
          IconButton(
            onPressed: _onSubmit,
            icon: const Icon(Icons.check),
          )
        ],
      ),
    );
  }
}

enum _MenuOptions { deleteOnComplete }

class _Menu extends ConsumerWidget {
  const _Menu({Key? key}) : super(key: key);

  Future<void> onSeleceted(WidgetRef ref, _MenuOptions result) async {
    if (result == _MenuOptions.deleteOnComplete) {
      final currentSettings = ref.read(settingsProvider).state.deleteOnComplete;
      ref.read(settingsProvider).state =
          Settings(deleteOnComplete: !currentSettings);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCheck = ref.watch(settingsProvider).state.deleteOnComplete;
    return PopupMenuButton<_MenuOptions>(
      onSelected: (result) => onSeleceted(ref, result),
      icon: const Icon(Icons.menu),
      itemBuilder: (context) => <PopupMenuEntry<_MenuOptions>>[
        PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.deleteOnComplete,
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Text("Delete on complete"),
            Checkbox(value: isCheck, onChanged: null)
          ]),
        )
      ],
    );
  }
}
