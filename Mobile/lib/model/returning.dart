class Returning {
  final String rentId;
  final String userId;
  final String itemId;
  final String itemImage;
  final String itemName;
  final String itemBrand;
  final String total;
  final String rentDate;
  final String returnDate;
  final String status;

  Returning({
    required this.rentId,
    required this.userId,
    required this.itemId,
    required this.itemImage,
    required this.itemName,
    required this.itemBrand,
    required this.total,
    required this.rentDate,
    required this.returnDate,
    required this.status,
  });

  factory Returning.fromJson(Map<String, dynamic> json) {
    return Returning(
      rentId: json['id'] ?? '',
      userId: json['id_user'] ?? '',
      itemId: json['id_item'] ?? '',
      itemImage: json['item_image'] ?? '',
      itemName: json['item_name'] ?? '',
      itemBrand: json['item_brand'] ?? '',
      total: json['total_request'] ?? '',
      rentDate: json['lend_date'] ?? '',
      returnDate: json['return_date'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
