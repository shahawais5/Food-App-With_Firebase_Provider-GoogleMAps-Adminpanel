import 'package:flutter/material.dart';
import 'package:food_delivery_app/model/product_model.dart';
import 'package:food_delivery_app/widget/count.dart';
import 'package:food_delivery_app/widget/product_unit.dart';
import '../../config_color/colors.dart';


class SingleProduct extends StatefulWidget {
  final String productImage;
  final String productName;
  final String productID;
  final ProductModel productUnit;
  final int productPrice;
  final Function onTap;
  const SingleProduct(
      {Key? key,
      required this.onTap,
      required this.productUnit,
      required this.productImage,
      required this.productID,
      required this.productPrice,
      required this.productName})
      : super(key: key);

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  var unitData;
  var firstValue;

  @override
  Widget build(BuildContext context) {
    widget.productUnit.productUnit.firstWhere((element) {
      setState(() {
        firstValue = element;
      });
      return true;
    });
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 230,
            width: 165,
            decoration: BoxDecoration(
              color: const Color(0xffd9dad9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.onTap();
                  },
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(5),
                    width: double.infinity,
                    child: Image.network(
                      widget.productImage,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productName,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$/${widget.productPrice} ${unitData == null ? firstValue : unitData}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              ProductUnit(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: widget
                                              .productUnit.productUnit
                                              .map<Widget>((data) {
                                            print(data);
                                            return Column(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    setState(() {
                                                      unitData = data;
                                                      print(unitData);
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    data,
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                        );
                                      });
                                },
                                title: unitData == null ? firstValue : unitData,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Counter(
                                productImage: widget.productImage,
                                productName: widget.productName,
                                productPrice: widget.productPrice,
                                productID: widget.productID,
                                productUnit:
                                    unitData == null ? firstValue : unitData,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
