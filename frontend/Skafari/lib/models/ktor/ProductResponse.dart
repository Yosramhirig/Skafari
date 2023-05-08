class ProductResponse {
  ProductResponse({
      required this.barcode,});

  ProductResponse.fromJson(dynamic json) {
    barcode = json['barcode'];
  }
  String barcode = '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['barcode'] = barcode;
    return map;
  }

}