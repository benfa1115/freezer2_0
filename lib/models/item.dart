// lib/models/item.dart
class Item {
  final int? id;
  final String name;
  final double qty;
  final String unit;
  final int? categoryId;
  final int? locationId;
  final DateTime? expiryAt;
  final String? note;
  final String? barcode;
  final bool archived;
  final DateTime updatedAt;

  Item({
    this.id,
    required this.name,
    this.qty = 1,
    this.unit = 'pcs',
    this.categoryId,
    this.locationId,
    this.expiryAt,
    this.note,
    this.barcode,
    this.archived = false,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  Map<String, Object?> toMap() => {
    'id': id,
    'name': name,
    'qty': qty,
    'unit': unit,
    'categoryId': categoryId,
    'locationId': locationId,
    'expiryAt': expiryAt?.millisecondsSinceEpoch,
    'note': note,
    'barcode': barcode,
    'archived': archived ? 1 : 0,
    'updatedAt': updatedAt.millisecondsSinceEpoch,
  };

  factory Item.fromMap(Map<String, Object?> m) => Item(
    id: m['id'] as int?,
    name: m['name'] as String,
    qty: (m['qty'] as num).toDouble(),
    unit: m['unit'] as String,
    categoryId: m['categoryId'] as int?,
    locationId: m['locationId'] as int?,
    expiryAt: m['expiryAt'] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(m['expiryAt'] as int),
    note: m['note'] as String?,
    barcode: m['barcode'] as String?,
    archived: (m['archived'] as int? ?? 0) == 1,
    updatedAt: DateTime.fromMillisecondsSinceEpoch(m['updatedAt'] as int),
  );
}
