
class CryptoCoin {
  final int id;
  final String name;
  final String asset;

//<editor-fold desc="Data Methods">

  const CryptoCoin({
    required this.id,
    required this.name,
    required this.asset,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CryptoCoin &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          asset == other.asset);

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ asset.hashCode;

  @override
  String toString() {
    return 'CryptoCoin{ id: $id, name: $name, asset: $asset,}';
  }

  CryptoCoin copyWith({
    int? id,
    String? name,
    String? asset,
  }) {
    return CryptoCoin(
      id: id ?? this.id,
      name: name ?? this.name,
      asset: asset ?? this.asset,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'asset': asset,
    };
  }

  factory CryptoCoin.fromMap(Map<String, dynamic> map) {
    return CryptoCoin(
      id: map['id'] as int,
      name: map['name'] as String,
      asset: map['asset'] as String,
    );
  }

//</editor-fold>
}
