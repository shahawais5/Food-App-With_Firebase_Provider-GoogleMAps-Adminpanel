import 'package:flutter/material.dart';
import 'package:food_delivery_app/config_color/colors.dart';
import 'package:food_delivery_app/providers/review_cart_provider.dart';
import 'package:food_delivery_app/screens/check_out/add_delivery_address/add_delivery_address.dart';
import 'package:food_delivery_app/screens/check_out/payment_summary/my_google_pay.dart';
import 'package:food_delivery_app/screens/check_out/payment_summary/order_item.dart';
import 'package:provider/provider.dart';

class PaymentSummary extends StatefulWidget {
  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
}

enum Payment {
  Online,
  CashOn,
}

class _PaymentSummaryState extends State<PaymentSummary> {
  Payment _payMethod = Payment.Online;
  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();

    double discount = 20;
    double shipingCharge = 5;
    double totalprice = reviewCartProvider.getTotalPrice()+shipingCharge;
    double discountValue;
    discountValue = (totalprice * discount/ 100) ;
    double total=totalprice-discount;
    if (totalprice > 300) {
       discountValue = (totalprice * discount) / 100;
      total = totalprice - discountValue;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Summary',
        ),
        backgroundColor: primaryColor,
      ),
      bottomNavigationBar: ListTile(
          title: Text('Total Amount'),
          subtitle: Text(
            '\$ ${total}',
            style: TextStyle(color: Colors.green[900]),
          ),
          trailing: Container(
            width: 150,
            child: MaterialButton(
              onPressed: () {
                _payMethod== Payment.Online?Navigator.push(context, MaterialPageRoute(builder: (context)=>GooglePay())):Container();
              },
              child: Text(
                'Place Order',
                style: TextStyle(
                  color: textColor,
                ),
              ),
              color: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          )),
      body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text('Shah G!'),
                      subtitle: Text('Taxila wah Cantt'),
                    ),
                    Divider(),
                    ExpansionTile(
                        children:
                            reviewCartProvider.getreviewcartDataList.map((e) {
                          return OrderItem(
                            e: e,
                          );
                        }).toList(),
                        title: Text(
                            'Order Items${reviewCartProvider.reviewCartDataList.length}')),
                    Divider(),
                    ListTile(
                      minVerticalPadding: 5,
                      leading: Text(
                        'SubTotal',
                        style: TextStyle(color: textColor),
                      ),
                      trailing: Text('\$${totalprice}'),
                    ),
                    ListTile(
                      minVerticalPadding: 5,
                      leading: Text('Shipping Charge'),
                      trailing: Text('\$$shipingCharge'),
                    ),
                    ListTile(
                      minVerticalPadding: 5,
                      leading: Text('Cupen Discount'),
                      trailing: Text('\$${discountValue}'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Text('Payment Options'),
                    ),
                    RadioListTile(
                        value: Payment.Online,
                        groupValue: _payMethod,
                        secondary: Icon(
                          Icons.payment_sharp,
                          color: primaryColor,
                        ),
                        title: Text('Pay Online'),
                        onChanged: (onChanged) {
                          setState(() {
                            _payMethod = onChanged!;
                          });
                        }),
                    RadioListTile(
                        value: Payment.CashOn,
                        secondary: Icon(
                          Icons.payment_sharp,
                          color: primaryColor,
                        ),
                        groupValue: _payMethod,
                        title: Text('Cash On Delvery'),
                        onChanged: (onChanged) {
                          setState(() {
                            _payMethod = onChanged!;
                          });
                        }),
                  ],
                );
              })),
    );
  }
}
