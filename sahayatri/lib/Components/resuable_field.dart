import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahayatri/Helper_Classes/validation_helper.dart';
late String passwordToConfirm;

class ReusableField extends StatelessWidget {
 const ReusableField({
    Key? key,
    required this.fontIcon,
    required this.hint,
    this.obscure,
    required this.fieldName,
    this.additionalValidation,
    this.autoValidateMode,
  }) : super(key: key);

  final IconData fontIcon;
  final String hint;
  final bool? obscure;
  final TextEditingController fieldName;
  final bool? additionalValidation;
  final bool? autoValidateMode;

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
        autovalidateMode: (autoValidateMode ?? false)
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        controller: fieldName,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Required *';
          } else if (additionalValidation ?? false) {
            switch (hint) {
              case 'User Name':
                {
                  return validateUsername(value);
                }
              case 'Email':
                {
                  return validateEmail(value);
                }
              case 'Phone Number':
                {
                  return validatePhone(value);
                }
              case 'Password':
                {
                  passwordToConfirm = value;
                  return validatePassword(value);
                }
              case 'Confirm Password':
                {
                  return validateConfirmPassword(passwordToConfirm, value);
                }
            }
          }
          return null;
        },
        obscureText: obscure ?? false,
        decoration: InputDecoration(
          icon: Icon(fontIcon),
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
