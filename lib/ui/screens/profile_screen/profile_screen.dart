import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/models/user_model.dart';
import 'package:janajal/services/auth_service.dart';
import 'package:janajal/ui/helping_widget/custom_textfield.dart';
import 'package:janajal/ui/helping_widget/round_button.dart';
import 'package:janajal/ui/screens/login_screen/login_screen.dart';
import 'package:janajal/utils/shared_pref.dart';
import 'package:janajal/utils/validator.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? _userModel;

  bool isModified = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  String? gender = null;
  bool showGetOtp = false;
  bool isMobileVerified = true;
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
  void initState() {
    _userModel =
        Provider.of<AuthController>(context, listen: false).getUserModel;
    firstNameController.text = _userModel!.name ??
        "" +
            (_userModel!.lastName == null
                ? ""
                : _userModel!.lastName == 'NA'
                    ? ""
                    : _userModel!.lastName!);
    lastNameController.text = _userModel!.lastName ?? "";
    gender = 'Male';
    emailController.text = _userModel!.email ?? "";
    addressController.text = _userModel!.address ?? "";
    pincodeController.text = _userModel!.pincode ?? "";
    mobileController.text = _userModel!.mobile ?? "";
    if (_userModel!.mobile == '0') {
      mobileController.text = '';
    }
    callApi();
    // TODO: implement initState
    super.initState();
  }

  callApi() async {
    isMobileVerified = await AuthServices.isMobileVerified(context, "");
    print(isMobileVerified);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   width: 50,
                  // ),
                  const Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700),
                  ),
                  // MaterialButton(
                  //   elevation: 2,
                  //   minWidth: 0,
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 20, vertical: 15),
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //   },
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(20)),
                  //   color: Colors.green,
                  //   child: const Text(
                  //     'Save',
                  //     style: TextStyle(
                  //         color: Colors.white, fontWeight: FontWeight.bold),
                  //   ),
                  // )
                ],
              ),
              SizedBox(
                height: size.width * 0.12,
              ),
              CustomTextField(
                text: 'Full Name*',
                controller: firstNameController,
                errorText: firstNameError,
                textInputType: TextInputType.name,
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
                        itemPadding: const EdgeInsets.only(left: 14, right: 14),
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
                onChange: (String value) {
                  String error = Validator.validateMobile(value);
                  if (error == '' &&
                      _userModel!.mobile != mobileController.text.toString()) {
                    setState(() {
                      showGetOtp = true;
                    });
                  } else {
                    showGetOtp = false;
                    setState(() {});
                  }
                },
                text: 'Mobile*',
                enabled: !isMobileVerified,
                maxLength: 10,
                controller: mobileController,
                errorText: mobileError,
                textInputType: TextInputType.number,
              ),
              SizedBox(
                height: 5,
              ),
              showGetOtp
                  ? MaterialButton(
                      color: Colors.blue,
                      minWidth: 0,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () async {
                        if (!(await AuthServices.checkMobileExist(
                            mobileController.text.trim(), context))) {
                          AuthServices.sendOtp(
                              context, mobileController.text.toString());
                          //  AuthServices.
                        }
                      },
                      child: const Text(
                        'Get OTP',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: size.width * 0.05,
              ),
              CustomTextField(
                enabled: false,
                text: 'Email*',
                controller: emailController,
                errorText: emailError,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: size.width * 0.1,
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
              //         child: CustomTextField(
              //       text: 'India',
              //       enabled: false,
              //       controller: TextEditingController(),
              //     )),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              RoundButton(
                  onPress: () async {
                    await SharedPref.removeUserFromSharedPrefs();
                    await GoogleSignIn().signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return LoginScreen();
                    }), (route) => false);
                  },
                  color: Colors.red.shade600,
                  text: "Logout")
            ],
          ),
        ),
      ),
    );
  }
}
