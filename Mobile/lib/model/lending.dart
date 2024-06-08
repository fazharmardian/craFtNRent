class Lending {
  final String itemName;
  final String itemBrand;
  final String rentDate;
  final String returnDate;
  final String status;

  Lending(
      {required this.itemName,
      required this.itemBrand,
      required this.rentDate,
      required this.returnDate,
      required this.status,
      });

  factory Lending.fromJson(Map<String, dynamic> json) {
    return Lending(
      itemName: json['item_name'],
      itemBrand: json['item_brand'],
      rentDate: json['return_date'],
      returnDate: json['actual_return_date'],
      status: json['status'],
    );
  }
}
