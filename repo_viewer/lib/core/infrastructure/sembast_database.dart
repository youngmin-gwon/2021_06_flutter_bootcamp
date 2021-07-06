import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastDatabase {
  late Database _instance;
  Database get instace => _instance;

  bool _hasBeenInitialized = false;

  Future<void> init() async {
    if (_hasBeenInitialized) return;
    _hasBeenInitialized = true;
    final dbDirectory = await getApplicationDocumentsDirectory();
    dbDirectory.create(recursive: true);
    //! recursive: app/data/something 일 때, 각각의 dir이 모두 생성됨
    final dbPath = join(dbDirectory.path, "db.sembast");
    _instance = await databaseFactoryIo.openDatabase(dbPath);
  }
}
