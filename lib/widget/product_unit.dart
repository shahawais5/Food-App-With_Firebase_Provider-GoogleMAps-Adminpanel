import 'package:flutter/material.dart';

class ProductUnit extends StatelessWidget {
  final Function() onTap;
   final  String title;
  ProductUnit({required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap:onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 5),
        height: 30,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
                child: Text(
              title,
              style: TextStyle(fontSize: 10),
            )),
            Expanded(
              child: Icon(
                Icons.arrow_drop_down,
                color: Color(0xffd0b84c),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
