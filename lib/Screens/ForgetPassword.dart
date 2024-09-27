import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe/Screens/LoginScreen.dart';
import 'package:shoppe/Widgets/Custom%20Button%20Widget.dart';
import 'package:shoppe/Widgets/Custom_Text_Form_Field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Bubbles.png"),
            fit: BoxFit.cover, // Ensures the image covers the full screen
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.40),
              Text(
                "Forgot Password?",
                style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 30,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                  "Don't worry! please enter the email address associated with your account.",
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: "NunitoSans",
                      fontWeight: FontWeight.w300)),
              CustomTextFromField(
                label: Text('Email address'),
                keyboardTybe: TextInputType.emailAddress,
                icon: Icons.mail_outline_rounded,
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'please enter email';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(17.0),
                child: CustomButton(
                    ontap: () {
                      Get.offAll(LoginScreen());
                    },
                    text: "Submit",
                    height: 60,
                    width: 400,
                    fontsize: 22),
              )
            ],
          ),
        ),
      )
    ]));
  }
}
