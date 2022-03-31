import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/bottom_login_text.dart';
import 'package:sahayatri/Components/resuable_field.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome! Log In',
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
                        fontIcon: Icons.mail_outline,
                        hint: 'Email',
                        fieldName: _emailController,
                        autoValidateMode: true,
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      ReusableField(
                        fontIcon: Icons.lock_outline,
                        hint: 'Password',
                        obscure: true,
                        fieldName: _passwordController,
                        autoValidateMode: true,
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      FloatingActionButton.extended(
                        onPressed: () {
                          Map loginCredentials = {
                            'email': _emailController.text,
                            'password': _passwordController.text,
                            'device_name': 'android',
                          };
                          //only send request if the provided information are valid
                          if (_formKey.currentState!.validate()) {
                            Provider.of<Auth>(
                              context,
                              listen: false,
                            ).login(
                              credentials: loginCredentials,
                            );
                            Navigator.pushReplacementNamed(
                                context, 'gatewayPage');
                          }
                        },
                        icon: Icon(Icons.login),
                        label: Text('Log In'),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      kDivider,
                      SizedBox(
                        height: 3.0,
                      ),
                      BottomLoginText(
                        mainText: 'Don\'t have an account?  ',
                        linkText: 'Sign Up',
                        onPressed: () {
                          Navigator.popAndPushNamed(context, 'signup');
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      BottomLoginText(
                        mainText: 'Change Password?  ',
                        linkText: 'Forgot Password ',
                        displayIcon: false,
                        onPressed: () {
                          Navigator.popAndPushNamed(context, 'forgotPassword');
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
    );
  }
}
