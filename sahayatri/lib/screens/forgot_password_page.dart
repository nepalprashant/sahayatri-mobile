import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/bottom_login_text.dart';
import 'package:sahayatri/Components/flash_bar.dart';
import 'package:sahayatri/Components/loading_dialog.dart';
import 'package:sahayatri/Components/resuable_field.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Services/forgot_password.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<ForgotPassword>(
      builder: (context, password, child) {
        return Stack(
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
                          'Reset Password!',
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
                          additionalValidation: true,
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            Map email = {
                              'email': _emailController.text,
                            };
                            //only send request if the provided information are valid
                            if (_formKey.currentState!.validate()) {
                              Provider.of<ForgotPassword>(context,
                                      listen: false)
                                  .forgotPassword(email: email);
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  Future.delayed(const Duration(seconds: 5),
                                      () {
                                    //displaying in case of connection error
                                    (password.isConnectionError)
                                        ? displayFlash(
                                            context: context,
                                            text:
                                                'Can\'t connect to the server!',
                                            color: kDangerColor,
                                            icon: Icons.wifi_off_rounded)
                                        : displayFlash(
                                            context: context,
                                            text:
                                                'Reset link forwarded to your email.',
                                            color: kDangerColor,
                                            icon: Icons
                                                .mark_email_unread_rounded);
                                    Navigator.pop(ctx);
                                  });
                                  return LoadingDialog(
                                      text:
                                          'Hold tight! Submitting your Request.');
                                },
                                barrierDismissible: false,
                              );
                            }
                          },
                          icon: Icon(Icons.login),
                          label: Text('Submit'),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        kDivider,
                        SizedBox(
                          height: 10.0,
                        ),
                        BottomLoginText(
                          mainText: 'Already have an account?  ',
                          linkText: 'Log In',
                          displayIcon: false,
                          onPressed: () {
                            Navigator.popAndPushNamed(context, 'login');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    ));
  }
}
