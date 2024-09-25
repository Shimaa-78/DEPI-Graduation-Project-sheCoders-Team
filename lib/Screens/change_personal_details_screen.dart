import 'package:flutter/material.dart';


class ChangePersonalDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff004BFE),
        title: Text('Change Personal Details',style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildSectionHeader('Personal Details'),
            _buildTextField('Email Address', 'example@gmail.com', false),
            _buildTextField('Password', '********', true),
            SizedBox(height: 10,),


            _buildSectionHeader('Business Address Details'),
            _buildTextField('Address', '8 St EL-Kamhawi Wadi El-Nail\'s Rd,', false),
            _buildTextField('City', 'Cairo', false),
            _buildTextField('Country', 'Egypt', false),



            SizedBox(height: 20),
            // Save Button
            ElevatedButton(
              onPressed: () {
                // Handle Save action
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15), backgroundColor: Color(0xff004BFE),
              ),
              child: Text('Save', style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
            ),
          ],
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
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
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
}