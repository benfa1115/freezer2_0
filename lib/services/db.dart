// lib/services/db.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseService {
  DatabaseService._();
  static final DatabaseService instance = DatabaseService._();

  static const _dbName = 'myfreezer.db';
  static const _dbVersion = 1;

  Database? _db;
  Database get db {
    final d = _db;
    if (d == null) {
      throw StateError(
        'Database not initialized. Call DatabaseService.instance.init() first.',
      );
    }
    return d;
  }

  Future<void> init() async {
    final dbDir = await getDatabasesPath();
    final path = p.join(dbDir, _dbName);

    _db = await openDatabase(
      path,
      version: _dbVersion,
      onConfigure: (d) async {
        await d.execute('PRAGMA foreign_keys = ON;');
      },
      onCreate: (d, version) async {
        // --- Tables ---
        await d.execute('''
          CREATE TABLE households(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
          );
        ''');

        await d.execute('''
          CREATE TABLE categories(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
          );
        ''');

        await d.execute('''
          CREATE TABLE locations(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
          );
        ''');

        await d.execute('''
          CREATE TABLE items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            qty REAL NOT NULL DEFAULT 1,
            unit TEXT NOT NULL DEFAULT 'pcs',
            categoryId INTEGER,
            locationId INTEGER,
            expiryAt INTEGER,              -- millis since epoch (nullable)
            note TEXT,
            barcode TEXT,
            archived INTEGER NOT NULL DEFAULT 0,
            updatedAt INTEGER NOT NULL,
            FOREIGN KEY(categoryId) REFERENCES categories(id) ON DELETE SET NULL,
            FOREIGN KEY(locationId) REFERENCES locations(id) ON DELETE SET NULL
          );
        ''');

        await d.execute('CREATE INDEX idx_items_name ON items(name);');
        await d.execute('CREATE INDEX idx_items_expiry ON items(expiryAt);');
        await d.execute('CREATE INDEX idx_items_arch ON items(archived);');

        // --- Seed ---
        final now = DateTime.now().millisecondsSinceEpoch;
        await d.insert('households', {'name': 'My Freezer'});
        await d.insert('categories', {'name': 'Meat'});
        await d.insert('categories', {'name': 'Vegetables'});
        await d.insert('categories', {'name': 'Fruit'});
        await d.insert('locations', {'name': 'Freezer - Drawer 1'});
        await d.insert('locations', {'name': 'Freezer - Drawer 2'});

        await d.insert('items', {
          'name': 'Chicken breast',
          'qty': 2,
          'unit': 'pcs',
          'categoryId': 1,
          'locationId': 1,
          'expiryAt': null,
          'note': 'Sample item (you can delete me)',
          'barcode': null,
          'archived': 0,
          'updatedAt': now,
        });
      },
      onUpgrade: (d, oldV, newV) async {
        // Put migrations here when bumping _dbVersion
      },
    );
  }
}
