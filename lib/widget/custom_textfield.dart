import 'package:flutter/material.dart';

class CustemTxtField extends StatelessWidget {
  final TextEditingController controller;
  final String labtext;
  final TextInputType keyboardType;
  CustemTxtField({required this.keyboardType,required this.labtext,required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: labtext
      ),
    );
  }
}
