import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoppe/Screens/LoginScreen.dart';
import 'package:shoppe/Widgets/Custom%20Button%20Widget.dart';

import '../Widgets/Custom_Text_Form_Field.dart';
import 'onBoardingScreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}
final _formKey = GlobalKey<FormState>();
class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack( children: [
      Container( decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/images/Bubbles.png"),
      fit: BoxFit.cover, // Ensures the image covers the full screen
    ),
    ),),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                SizedBox(
                    height:MediaQuery.of(context).size.height * 0.36
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 52,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height:MediaQuery.of(context).size.height * 0.03),
                CustomTextFromField(
                  label: Text('UserName'),
                  icon: Icons.person,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'please enter username';
                    }
                    return null;
                  },
                ),     CustomTextFromField(
                    label: Text('Email address'),
                    keyboardTybe: TextInputType.emailAddress,
                    suffixIcon: Icons.check_circle,
                    color: Color(0xff004BFE),
                    icon: Icons.mail_outline_rounded,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter email';
                      }
                      return null;
                    },
                  ),
                  CustomTextFromField(
                    label: Text('password'),
                    keyboardTybe: TextInputType.text,
                    isObscure: true,
                    icon: Icons.lock_outline,
                    suffixIcon: Icons.visibility_off_outlined,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter password';
                      }
                      if (text.length < 6) {
                        return 'password should be at least 6';
                      }
                      return null;
                    },
                  ),
                  CustomTextFromField(
                    label: Text('PhoneNumber'),
                    keyboardTybe: TextInputType.number,

                    icon: Icons.phone,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter your number';
                      }
                      return null;
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(ontap: (){
                      if (_formKey.currentState!.validate()) ;
                    }, text: 'Sign up',fontsize: 22,width: 400,height: 60,),
                  ),
                  Row(children: [
                    Expanded(
                        child: Divider(
                          color: Color(0xFFB1B1B1),
                          thickness: 1,
                          endIndent: 30,
                          indent: 30,
                        )),
                    Text("Or Sign In With",style:TextStyle(color: Color(0xFF878787)) ,),
                    Expanded(
                        child: Divider(
                          color: Color(0xFFB1B1B1),
                          thickness: 1,
                          endIndent: 30,
                          indent: 30,
                        )),
                  ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset('assets/images/google.png'),
                        Image.asset('assets/images/facebook..png')
                      ]),
                        Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                      style: TextStyle(
                          color: Color(0xFF878787), fontSize: 16)),
                  TextButton(
                      onPressed: () {
                        Get.offAll(LoginScreen());
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 16, color: Color(0xff004BFE)),
                      )
                  )
                        ])
                      )



              ],),
            ),
          ),
        )


   ] ) );
  }
}
