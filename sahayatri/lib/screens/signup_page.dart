import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/bottom_login_text.dart';
import 'package:sahayatri/Components/resuable_field.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/services/auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome! Sign Up',
                          style: kWelcomeTextStyle,
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        kLoginImage,
                        SizedBox(
                          height: 3.0,
                        ),
                        ReusableField(
                          fontIcon: Icons.portrait_outlined,
                          hint: 'User Name',
                          fieldName: _userNameController,
                          additionalValidation: true,
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        ReusableField(
                          fontIcon: Icons.mail_outline,
                          hint: 'Email',
                          fieldName: _emailController,
                          additionalValidation: true,
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        ReusableField(
                          fontIcon: Icons.phone_outlined,
                          hint: 'Phone Number',
                          fieldName: _phoneController,
                          additionalValidation: true,
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        ReusableField(
                          fontIcon: Icons.lock_outline,
                          hint: 'Password',
                          obscure: true,
                          fieldName: _passwordController,
                          additionalValidation: true,
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        ReusableField(
                          fontIcon: Icons.lock_outline,
                          hint: 'Confirm Password',
                          obscure: true,
                          fieldName: _confirmPasswordController,
                          additionalValidation: true,
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            Map userDetails = {
                              'name': _userNameController.text,
                              'email': _emailController.text,
                              'phone_no': _phoneController.text,
                              'password': _passwordController.text,
                            };
                            if (_formKey.currentState!.validate()) {
                              Provider.of<Auth>(
                                context,
                                listen: false,
                              ).signup(
                                userDetails: userDetails,
                              );
                            }
                            // Navigator.pushNamed(context, 'driverMainPage');
                          },
                          icon: Icon(Icons.login),
                          label: Text('Sign Up'),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        kDivider,
                        SizedBox(
                          height: 3.0,
                        ),
                        BottomLoginText(
                          mainText: 'Already have an account?  ',
                          linkText: 'Log In',
                          onPressed: () {
                            Navigator.pushNamed(context, 'login');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
