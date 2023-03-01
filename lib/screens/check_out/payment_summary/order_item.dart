import 'package:flutter/material.dart';
import 'package:food_delivery_app/model/review_cart_model.dart';


class OrderItem extends StatelessWidget {
final ReviewCartModel e;
OrderItem({required this.e});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(e.cartImage),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(e.cartName),
          Text(e.cartUnit),
          Text("\$${e.cartPrice.toString()}")
        ],
      ),
      subtitle: Text("Quantity: ${e.cartQuantity.toString()}"),
    );
  }
}
