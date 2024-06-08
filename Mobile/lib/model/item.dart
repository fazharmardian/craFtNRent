class Item {
  final String id;
  final String name;
  final String image;
  final String brand;
  final String type;
  final String stock;

  Item({
    required this.id,
    required this.name,
    required this.image,
    required this.brand,
    required this.type,
    required this.stock,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      brand: json['brand'],
      type: json['type'],
      stock: json['stock'],
    );
  }
}
