import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:janajal/services/auth_service.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/helping_widget/custom_textfield.dart';
import 'package:janajal/ui/helping_widget/round_button.dart';
import 'package:janajal/utils/janajal.dart';
import 'package:janajal/utils/validator.dart';

class LoginWidgets {
  static Widget textField(String text, {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Material(
        shadowColor: Colors.lightBlue.shade100,
        borderRadius: BorderRadius.circular(40),
        elevation: 10,
        child: TextField(
          enabled: enabled,
          cursorHeight: 20,
          style: const TextStyle(
              fontWeight: FontWeight.w700, fontSize: 15, color: Colors.grey),
          decoration: InputDecoration(
              enabled: enabled,
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(40)),
              focusedBorder: InputBorder.none,
              hintText: text,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.grey.shade400),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(40))),
        ),
      ),
    );
  }
}

void showOtpBottomSheet(
    BuildContext context, String username, String password, int otp,
    {String mobile = '', bool isLogin = true}) {
  showModalBottomSheet(
      context: context,
      enableDrag: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: OtpWidget(
            username: username,
            password: password,
            otp: otp,
            mobile: mobile,
            isLogin: isLogin,
          ),
        );
      });
}

class OtpWidget extends StatefulWidget {
  final String password;
  final String username;
  final int otp;
  final String mobile;
  final bool isLogin;

  OtpWidget({
    Key? key,
    required this.username,
    required this.password,
    required this.otp,
    this.isLogin = true,
    this.mobile = '',
  }) : super(key: key);

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  TextEditingController _otpController = TextEditingController();
  String otpError = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      elevation: 20,
      color: Janajal.primaryColor,
      child: Container(
        height: size.height * 0.3,
        width: size.width,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.2, vertical: 20),
          child: Column(
            children: [
              CustomTextField(
                elevation: 0,
                errorText: otpError,
                textInputType: TextInputType.number,
                maxLength: 4,
                controller: _otpController,
                text: "Enter OTP",
              ),
              SizedBox(
                height: 20,
              ),
              RoundButton(
                onPress: () async {
                  otpError =
                      Validator.validateOtp(context, _otpController.text);
                  if (otpError.isEmpty) {
                    if (widget.otp == int.parse(_otpController.text)) {
                      widget.isLogin
                          ? await AuthServices.authenticateUser(
                              context, widget.username, widget.password)
                          : await AuthServices.verifyMobileOtp(
                              context,
                              widget.mobile,
                              _otpController.text.trim(),
                            );
                    } else {
                      CustomDialogs.showToast('Invalid Otp');
                    }
                  } else {
                    setState(() {});
                  }
                },
                color: Colors.white,
                text: 'Submit',
                textColor: Janajal.primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
