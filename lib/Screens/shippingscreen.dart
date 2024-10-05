import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/Custom Button Widget.dart';
import 'PaymentScreen.dart';

class ShippingScreen extends StatefulWidget {
  final String total;

  ShippingScreen(this.total);

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key to manage validation

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  String? _selectedCountry;
  String? _selectedShippingMethod;

  final List<String> _countries = [
    'Egypt', 'USA', 'Canada', 'UK', 'Germany', 'France', 'Australia',
    'Brazil', 'China', 'India', 'Japan', 'Mexico', 'Italy', 'Russia',
    'South Africa', 'Saudi Arabia', 'Argentina', 'Netherlands', 'South Korea',
    'Spain', 'Turkey', 'Sweden', 'Norway', 'Denmark', 'Switzerland', 'UAE',
    'Nigeria', 'Kenya', 'Malaysia', 'Singapore', 'New Zealand', 'Belgium',
    'Poland', 'Ireland', 'Portugal', 'Greece', 'Indonesia', 'Thailand',
    'Vietnam', 'Philippines', 'Pakistan', 'Bangladesh', 'Chile', 'Colombia',
    'Peru', 'Venezuela'
  ];

  final List<String> _shippingMethods = ['Standard', 'Express'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Shipping',
          style: TextStyle(
            fontFamily: "Raleway",
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 46.0, horizontal: 30),
        child: Form(
          key: _formKey, // Attach form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Full Name
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Address
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // City
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Country Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCountry,
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                ),
                items: _countries.map((country) {
                  return DropdownMenuItem(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                  });
                },
                validator: (value) {
                  if (value == null) { // No need to check for isEmpty
                    return 'Please select a country';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Shipping Method Dropdown
              DropdownButtonFormField<String>(
                value: _selectedShippingMethod,
                decoration: const InputDecoration(
                  labelText: 'Shipping Method',
                  border: OutlineInputBorder(),
                ),
                items: _shippingMethods.map((method) {
                  return DropdownMenuItem(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedShippingMethod = value;
                  });
                },
                validator: (value) {
                  if (value == null) { // No need to check for isEmpty
                    return 'Please select a shipping method';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 100), // Add some space before the button

              Center(
                child: CustomButton(
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      // Proceed to the payment screen if the form is valid
                      Get.to(PaymentScreen(widget.total)); // Use widget.total

                      // Clear the form fields
                      _fullNameController.clear();
                      _addressController.clear();
                      _cityController.clear();
                      _selectedCountry = null;
                      _selectedShippingMethod = null;
                    }
                  },
                  width: 250,
                  text: "Continue to Payment",
                  height: 50,
                  fontsize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
