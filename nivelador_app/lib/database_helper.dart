// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// import 'bussiness_logic.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper.internal();
//   factory DatabaseHelper() => _instance;

//   DatabaseHelper.internal();

//   Database? _db;

//   Future<Database?> get db async {
//     if (_db != null) {
//       return _db;
//     }
//     _db = await initDb();
//     return _db;
//   }

//   Future<Database> initDb() async {
//     final databasePath = await getDatabasesPath();
//     final path = join(databasePath, 'your_database_name.db');

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (Database db, int newVersion) async {
//         // Create tables here
//         await db.execute('''
//           CREATE TABLE IF NOT EXISTS teams (
//             id INTEGER PRIMARY KEY,
//             name TEXT
//           )
//         ''');

//         await db.execute('''
//           CREATE TABLE IF NOT EXISTS players (
//             id INTEGER PRIMARY KEY,
//             name TEXT,
//             defense INTEGER,
//             attack INTEGER,
//             service INTEGER,
//             team_id INTEGER,
//             FOREIGN KEY (team_id) REFERENCES teams (id)
//           )
//         ''');
//       },
//     );
//   }

//   Future<int> insertPlayer(Player player) async {
//   final dbClient = await db;
//   return await dbClient!.insert('players', player.toMap());
//   }

// Future<List<Player>> getPlayers() async {
//   final dbClient = await db;
//   final List<Map<String, dynamic>> maps = await dbClient!.query('players');
//   return List.generate(maps.length, (i) {
//     return Player(
//       id: maps[i]['id'],
//       name: maps[i]['name'],
//       defense: maps[i]['defense'],
//       attack: maps[i]['attack'],
//       service: maps[i]['service'],
//       teamId: maps[i]['team_id'],
//     );
//   });
// }

// }
