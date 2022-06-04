import 'package:flutter/material.dart';
import 'package:janajal/services/auth_service.dart';
import 'package:janajal/services/social_auth.dart';
import 'package:janajal/ui/helping_widget/custom_textfield.dart';
import 'package:janajal/ui/helping_widget/round_button.dart';
import 'package:janajal/ui/screens/login_screen/widget.dart';
import 'package:janajal/ui/screens/main_widget.dart';
import 'package:janajal/ui/screens/signup_screen/signup_screen.dart';
import 'package:janajal/utils/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String emailError = '';
  String passwordError = '';
  String otpErrorText = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                Image.asset(
                  'assets/images/jjwowlogo.png',
                  width: 200,
                ),
                SizedBox(
                  height: size.width * 0.12,
                ),
                CustomTextField(
                  errorText: emailError,
                  text: 'Email/Phone',
                  controller: emailController,
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                CustomTextField(
                  errorText: passwordError,
                  isObscure: true,
                  text: 'Password',
                  controller: passController,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundButton(
                        onPress: () {
                          emailError =
                              Validator.validateUsename(emailController.text);
                          passwordError =
                              Validator.validatePass(passController.text);
                          setState(() {});
                          if (emailError.isEmpty && passwordError.isEmpty) {
                            AuthServices.authenticateUser(context,
                                emailController.text, passController.text);
                          }
                        },
                        color: Colors.blue.shade900,
                        text: 'Login'),
                    RoundButton(
                      onPress: () async {
                        emailError =
                            Validator.validateUsename(emailController.text);
                        if (emailError.length == 0) {
                          emailError = '';
                          setState(() {});
                          Map<String, dynamic>? loginResp =
                              await AuthServices.loginViaOtp(
                                  context, emailController.text);
                          print(loginResp);
                          if (loginResp != null) {
                            showOtpBottomSheet(context, emailController.text,
                                loginResp['password'], loginResp['OTP']);
                          }
                        } else {
                          setState(() {});
                        }
                      },
                      color: Colors.white,
                      text: 'Login Via OTP',
                      textColor: Colors.blue.shade900,
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.05,
                ),
                const Text(
                  '-OR-',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: size.width * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      elevation: 10,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      onPressed: () {
                        SocialAuth.getGoogleAuth(context);
                        // AuthServices.getPassword(
                        //     'himanshu.rai@dangalgames.com', context);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      color: Colors.white,
                      child: Image.asset(
                        'assets/images/icons/google_icon.png',
                        width: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      elevation: 10,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      onPressed: () {
                        SocialAuth.getFacebookUserDetails(context);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      color: Colors.white,
                      child: Image.asset(
                        'assets/images/icons/facebook_icon.png',
                        width: 30,
                      ),
                    )
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Dont't have an account? ",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return SignupScreen();
                        }));
                      },
                      child: Text(
                        "Sign Up!",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue.shade600,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
