import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:janajal/services/auth_service.dart';
import 'package:janajal/services/social_auth.dart';
import 'package:janajal/ui/helping_widget/custom_dropdown.dart';
import 'package:janajal/ui/helping_widget/custom_textfield.dart';
import 'package:janajal/ui/helping_widget/round_button.dart';
import 'package:janajal/ui/screens/login_screen/widget.dart';
import 'package:janajal/utils/validator.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  String? gender = null;

  String firstNameError = '';
  String lastNameError = '';
  String genderError = '';
  String mobileError = '';
  String emailError = '';
  String passwordError = '';
  String addressError = '';
  String pincodeError = '';

  validateForm() async {
    emailError = Validator.validateEmail(emailController.text.trim());
    passwordError = Validator.validatePass(passwordController.text.trim());
    mobileError = Validator.validateMobile(mobileController.text.trim());
    firstNameError = Validator.validateName(firstNameController.text.trim());
    pincodeError = Validator.validatePincode(pincodeController.text.trim());
    emailError =
        await Validator.checkEmailExist(emailController.text.trim(), context);
    mobileError =
        await Validator.checkMobileExist(mobileController.text.trim(), context);
    if (gender == null) {
      genderError = 'Please Select a gender';
    } else {
      genderError = '';
    }

    setState(() {});
    if (emailError.isEmpty &&
        passwordError.isEmpty &&
        mobileError.isEmpty &&
        firstNameError.isEmpty &&
        pincodeError.isEmpty &&
        genderError.isEmpty) {
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/backgroundOne.png',
                ),
                fit: BoxFit.fill)),
        width: size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                        elevation: 2,
                        minWidth: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        color: Colors.white,
                        child: const Icon(Icons.arrow_back_ios_new_rounded)),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      width: 50,
                    )
                  ],
                ),
                SizedBox(
                  height: size.width * 0.12,
                ),
                Row(
                  children: [
                    Flexible(
                        child: CustomTextField(
                      text: 'First Name*',
                      controller: firstNameController,
                      errorText: firstNameError,
                      textInputType: TextInputType.name,
                    )),
                    Flexible(
                        child: CustomTextField(
                      text: 'Last Name',
                      controller: lastNameController,
                      errorText: lastNameError,
                      textInputType: TextInputType.name,
                    )),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Text(
                            'Select Gender',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.grey.shade400),
                          ),
                          items: ['Male', 'Female', 'Others']
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          color: Colors.grey.shade500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value as String;
                            });
                          },
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                          ),
                          buttonPadding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey.shade50),
                          buttonElevation: 4,
                          itemHeight: 35,
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          dropdownMaxHeight: 200,
                          dropdownPadding: null,
                          dropdownFullScreen: true,
                          selectedItemHighlightColor: Colors.blue.shade100,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.grey.shade100,
                          ),
                          dropdownElevation: 8,
                          scrollbarRadius: const Radius.circular(40),
                          scrollbarThickness: 6,
                          scrollbarAlwaysShow: true,
                          offset: const Offset(0, 0),
                        ),
                      ),
                      gender == null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    genderError,
                                    style: TextStyle(color: Colors.red),
                                  )),
                            )
                          : Container(),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.width * 0.05,
                ),
                CustomTextField(
                  text: 'Mobile*',
                  controller: mobileController,
                  errorText: mobileError,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: size.width * 0.05,
                ),
                CustomTextField(
                  text: 'Email*',
                  controller: emailController,
                  errorText: emailError,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                CustomTextField(
                  text: 'Password*',
                  controller: passwordController,
                  errorText: passwordError,
                  textInputType: TextInputType.visiblePassword,
                  isObscure: true,
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                // CustomTextField(
                //   text: 'Address',
                //   controller: addressController,
                //   errorText: addressError,
                //   maxLines: 4,
                // ),
                // SizedBox(
                //   height: size.width * 0.05,
                // ),
                // Row(
                //   children: [
                //     Flexible(
                //         child: CustomTextField(
                //       text: 'Pin Code*',
                //       controller: pincodeController,
                //       errorText: pincodeError,
                //       textInputType: TextInputType.number,
                //     )),
                //     Flexible(
                //         child: LoginWidgets.textField('India', enabled: false)),
                //   ],
                // ),
                const SizedBox(
                  height: 10,
                ),
                RoundButton(
                    onPress: () async {
                      if (await validateForm()) {
                        AuthServices.userSignup(
                          context,
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          firstNameController.text.trim(),
                          lastNameController.text.trim(),
                          gender!.trim(),
                          "0",
                          emailController.text.trim(),
                          mobileController.text.trim(),
                          "-",
                          // pincodeController.text.trim(),
                          'India',
                          // addressController.text.trim(),
                          "-",
                        );
                      }
                    },
                    color: Colors.blue.shade900,
                    text: 'Sign Up'),
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
                        SocialAuth.getGoogleSigup(context);
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
                      onPressed: () {},
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
