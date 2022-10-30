import 'package:mongo_dart/mongo_dart.dart';

class DBConnection {
  static DBConnection _instance = DBConnection();
//
  final String _getConnectionString =
      "mongodb://localhost:27017/mongo_dart-blog";

  var _db;

  static getInstance() {
    if (_instance == null) {
      _instance = DBConnection();
    }
    return _instance;
  }

  Future<Db> getConnection() async {
    if (_db == null) {
      try {
        _db = await Db(_getConnectionString);
        await _db.open();
      } catch (e) {
        print(e);
      }
    }
    return _db;
  }

  closeConnection() {
    _db.close();
  }
}
