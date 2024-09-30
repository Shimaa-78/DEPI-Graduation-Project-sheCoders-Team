import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubit/personal_details_cubit.dart';

class ChangePersonalDetailsScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PersonalDetailsCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff004BFE),
          title: Text(
            "Change Personal Details",
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontFamily: "Raleway",
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                _buildSectionHeader("Personal Details"),
                _buildTextField("Email Address", "Example@gmail.com", false),
                _buildPasswordField(
                  context,
                  "Current Password",
                  '',
                  true,
                ),
                _buildPasswordField(
                  context,
                  "New Password",
                  '',
                  false,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      context.read<PersonalDetailsCubit>().saveDetails();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    backgroundColor: Color(0xff004BFE),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Raleway",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(fontSize: 18, fontFamily: "Raleway", fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, String placeholder, bool isPassword) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: placeholder,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xff004BFE)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xff004BFE), width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
      BuildContext context,
      String labelText,
      String placeholder,
      bool isCurrentPassword) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: BlocBuilder<PersonalDetailsCubit, PersonalDetailsState>(
        builder: (context, state) {
          final cubit = context.read<PersonalDetailsCubit>();

          final isPasswordVisible = isCurrentPassword
              ? state.isCurrentPasswordVisible
              : state.isNewPasswordVisible;

          final errorText = isCurrentPassword
              ? state.currentPasswordError
              : state.newPasswordError;

          return TextFormField(
            obscureText: !isPasswordVisible,
            onChanged: (value) {
              if (isCurrentPassword) {
                cubit.validateCurrentPassword(value);
              } else {
                cubit.validateNewPassword(value);
              }
            },
            decoration: InputDecoration(
              labelText: labelText,
              hintText: placeholder,
              errorText: errorText,
              suffixIcon: IconButton(
                icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  if (isCurrentPassword) {
                    cubit.toggleCurrentPasswordVisibility();
                  } else {
                    cubit.toggleNewPasswordVisibility();
                  }
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xff004BFE)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xff004BFE), width: 2),
              ),
            ),
          );
        },
      ),
    );
  }
}




























