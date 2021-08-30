import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:repo_viewer/core/presentation/toasts.dart';
import 'package:repo_viewer/gitub/core/presentation/no_results_display.dart';
import 'package:repo_viewer/gitub/repos/core/application/paginated_repos_notifier.dart';
import 'package:repo_viewer/gitub/repos/core/presentation/repo_tile.dart';

import 'failure_repo_tile.dart';
import 'loading_repo_tile.dart';

class PaginatedReposListView extends StatefulWidget {
  final StateNotifierProvider<PaginatedReposNotifier, PaginatedReposState>
      paginatedReposNotifierProvider;
  final void Function(WidgetRef ref) getNextPage;
  final String noResultsMessage;

  const PaginatedReposListView({
    Key? key,
    required this.paginatedReposNotifierProvider,
    required this.getNextPage,
    required this.noResultsMessage,
  }) : super(key: key);

  @override
  _PaginatedReposListViewState createState() => _PaginatedReposListViewState();
}

class _PaginatedReposListViewState extends State<PaginatedReposListView> {
  bool canLoadNextPage = false;
  bool hasAlreadyNoConnectionToast = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(widget.paginatedReposNotifierProvider);

        ref.listen<PaginatedReposState>(widget.paginatedReposNotifierProvider,
            (state) {
          state.map(
            initial: (_) => canLoadNextPage = true,
            loadInProgress: (_) => canLoadNextPage = false,
            loadSuccess: (_) {
              if (!_.repos.isFresh && hasAlreadyNoConnectionToast) {
                hasAlreadyNoConnectionToast = true;
                showNoConnectionToast(
                    "You're not online. Some information may be outdated",
                    context);
              }
              canLoadNextPage = _.isNextPageAvailable;
            },
            loadFailure: (_) => canLoadNextPage = true,
          );
        });

        return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              final metrics = notification.metrics;
              final limit =
                  metrics.maxScrollExtent - metrics.viewportDimension / 3;

              if (canLoadNextPage && metrics.pixels >= limit) {
                canLoadNextPage = false;
                widget.getNextPage(ref);
              }

              // when it return true, scroll cannot go further down or up
              //* (in most case) return false
              return false;
            },
            child: state.maybeWhen(
                    loadSuccess: (repos, _) => repos.entity.isEmpty,
                    orElse: () => false)
                ? NoResultsDisplay(message: widget.noResultsMessage)
                : _PaginatedListView(state: state));
      },
    );
  }
}

class _PaginatedListView extends StatelessWidget {
  const _PaginatedListView({
    Key? key,
    required this.state,
  }) : super(key: key);

  final PaginatedReposState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.map(
        initial: (_) => 0,
        loadInProgress: (_) => _.repos.entity.length + _.itemsPerPage,
        loadSuccess: (_) => _.repos.entity.length,
        loadFailure: (_) => _.repos.entity.length + 1,
      ),
      itemBuilder: (context, index) {
        return state.map(
          initial: (_) => RepoTile(repo: _.repos.entity[index]),
          loadInProgress: (_) {
            if (index < _.repos.entity.length) {
              return RepoTile(
                repo: _.repos.entity[index],
              );
            } else {
              return const LoadingRepoTile();
            }
          },
          loadSuccess: (_) => RepoTile(
            repo: _.repos.entity[index],
          ),
          loadFailure: (_) {
            if (index < _.repos.entity.length) {
              return RepoTile(
                repo: _.repos.entity[index],
              );
            } else {
              return FailureRepoTile(
                failure: _.failure,
              );
            }
          },
        );
      },
    );
  }
}
