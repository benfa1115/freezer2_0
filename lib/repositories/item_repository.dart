// lib/repositories/item_repository.dart
import 'package:sqflite/sqflite.dart';
import '../services/db.dart';
import '../models/item.dart';

class ItemRepository {
  final Database _db = DatabaseService.instance.db;

  Future<int> create(Item item) async {
    return _db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Item>> listActive({String? search}) async {
    final where = <String>['archived = 0'];
    final args = <Object?>[];

    if (search != null && search.trim().isNotEmpty) {
      where.add('name LIKE ?');
      args.add('%${search.trim()}%');
    }

    // 32503680000000 = year 3000 (to sort null expiry last)
    final maps = await _db.query(
      'items',
      where: where.join(' AND '),
      whereArgs: args,
      orderBy: 'COALESCE(expiryAt, 32503680000000) ASC, name ASC',
    );
    return maps.map(Item.fromMap).toList();
  }
}
