import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shoppe/Widgets/Custom%20Button%20Widget.dart';

import 'endScreen.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
  String total;
  PaymentScreen(this.total);
}

class _PaymentScreenState extends State<PaymentScreen> {
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  // FocusNodes for auto-scrolling to focused TextField
  final FocusNode cardNumberFocusNode = FocusNode();
  final FocusNode cardHolderFocusNode = FocusNode();
  final FocusNode expiryDateFocusNode = FocusNode();
  final FocusNode cvvFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  void dispose() {
    // Dispose of the focus nodes
    cardNumberFocusNode.dispose();
    cardHolderFocusNode.dispose();
    expiryDateFocusNode.dispose();
    cvvFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Text(AppLocalizations.of(context)!.payment, style: TextStyle(
          fontFamily: "Raleway",
          fontWeight: FontWeight.bold,
          fontSize: 28,
          color: Colors.black,
        ),),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey, // Use form key for validation
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Credit Card Input
                  CreditCardWidget(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused,
                    onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                  ),
                  const SizedBox(height: 20),
                  // Total Amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.total_Amount,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Raleway",
                          color: Color(0xffA6A6A6),
                        ),
                      ),
                      Text(
                        '\$${widget.total}', // Display the passed total amount
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 20),
                  // Card Number Input
                  TextFormField(
                    focusNode: cardNumberFocusNode,
                    decoration:  InputDecoration(
                      labelText: AppLocalizations.of(context)!.card_Number,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.please_enter_a_valid_card_number;
                      } else if (value.length != 16) {
                        return   AppLocalizations.of(context)!.please_enter_a_valid_card_number;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        cardNumber = value;
                      });
                    },
                  ),

                  const SizedBox(height: 16),
                  // Card Holder Input
                  TextFormField(
                    focusNode: cardHolderFocusNode,
                    decoration:  InputDecoration(
                      labelText: AppLocalizations.of(context)!.card_Holder_Name,

                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.please_enter_the_name_of_cart_holder;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        cardHolderName = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      // Expiry Date Input
                      Expanded(
                        child: TextFormField(
                          focusNode: expiryDateFocusNode,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.expiryDateYyMm,

                          ),
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            // Check if the format is MM/YY
                            if (value == null || value.isEmpty || !RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{2})$').hasMatch(value)) {
                              return AppLocalizations.of(context)!.please_enter_a_valid_date_MmYy;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              expiryDate = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      // CVV Code Input
                      Expanded(
                        child: TextFormField(
                          focusNode: cvvFocusNode,
                          decoration: const InputDecoration(
                            labelText: 'CVV',

                          ),
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length < 3) {
                              return AppLocalizations.of(context)!.please_enter_a_valid_CVV;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              cvvCode = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                  // Confirm Button

                  Center(
                    child: CustomButton(ontap:  () {
                      if (_formKey.currentState!.validate()) {
                        Get.offAll(CongratulatoryScreen());
                      }
                    }, width: 250, text: AppLocalizations.of(context)!.confirm,
                        height: 60, fontsize: 18),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}