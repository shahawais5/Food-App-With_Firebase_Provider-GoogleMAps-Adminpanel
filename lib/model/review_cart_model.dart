class ReviewCartModel {
  late String cartID;
  late String cartImage;
  late String cartName;
  late int cartPrice;
  late int cartQuantity;
  var cartUnit;
  ReviewCartModel(
      {required this.cartID,
      required this.cartImage,
      required this.cartName,
      required this.cartPrice,
        required this.cartUnit,
        required this.cartQuantity
      });
}
