import 'package:pay/pay.dart';
import 'package:flutter/material.dart';
class GooglePay extends StatefulWidget {
  const GooglePay({Key? key}) : super(key: key);

  @override
  State<GooglePay> createState() => _GooglePayState();
}

class _GooglePayState extends State<GooglePay> {

  var _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];

// In your Widget build() method



// In your Stateless Widget class or State
  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server or PSP
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.black
            ),
            child:GooglePayButton(
              paymentConfigurationAsset: 'sample_payment_configuration.json',
              paymentItems: _paymentItems,
              margin: EdgeInsets.only(top: 15),
              //style: GooglePayButtonStyle.black,
              type: GooglePayButtonType.pay,
              onPaymentResult: onGooglePayResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          ),
        ),
      ],
    );

  }
}

