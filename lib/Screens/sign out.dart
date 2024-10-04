
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoppe/Screens/ForgetPassword.dart';

class SignOut extends StatelessWidget {
  const SignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(onPressed: (){
          GoogleSignIn googleSignIn = GoogleSignIn();
          googleSignIn .disconnect();
          Get.off(ForgetPassword());
        }, icon:Icon(Icons.ice_skating_outlined) ),
      ),

    );
  }
}
