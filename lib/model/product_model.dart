class ProductModel {
  String productName;
  String productID;
  String productImage;
  int productPrice;
  List<dynamic>productUnit;
  ProductModel(
      {required this.productName,
        required this.productImage,
        required this.productUnit,
        required this.productID,
        required this.productPrice,
      });
}
