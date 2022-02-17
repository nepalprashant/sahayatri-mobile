import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReusableField extends StatelessWidget {
  const ReusableField({
    Key? key,
    required this.fontIcon,
    required this.hint,
    this.obscure,
    required this.fieldName,
  }) : super(key: key);

  final IconData fontIcon;
  final String hint;
  final bool? obscure;
  final TextEditingController fieldName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 45.0, vertical: 4.0),
      padding: EdgeInsets.symmetric(
        vertical: 2.0,
        horizontal: 25.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.lightBlue.shade100,
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: fieldName,
        validator: (value) => value!.isEmpty ? 'Please! enter ' + hint : null,
        obscureText: obscure ?? false,
        decoration: InputDecoration(
          icon: Icon(fontIcon),
          hintText: hint,
          border: InputBorder.none,
        ),
        inputFormatters: [
          // TextInputFormatter(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"));
          // if(fieldName.text == '_emailController') {

          // }
        ],
      ),
    );
  }
}
