import 'package:flutter/material.dart';
import 'package:shoppe/Consts/Kcolors.dart';
import 'package:shoppe/Widgets/Custom Button Widget.dart';

import '../Models/CartModel.dart';
import '../Widgets/Methods.dart';

class CartScreen extends StatelessWidget {
   CartScreen({super.key});
  String buttonString = "";

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Update buttonString based on CartList status
    buttonString = CartList.isEmpty ? "Go Shopping" : "Let's Start";

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.05, // Responsive vertical padding
          left: screenWidth * 0.05,
          right: screenWidth * 0.05, // Responsive horizontal padding
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Cart",
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                const SizedBox(width: 3),
                CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xffE5EBFC),
                    child: Center(
                      child: Text(
                        CartList.length.toString(),
                        style: const TextStyle(
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    )),
              ],
            ),
            // Check if the CartList is empty
            Expanded(
              child: CartList.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleLogo("assets/images/Logo for emty Cart.png"),
                    const SizedBox(height: 20),
                    const Text(
                      "Your cart is empty!",
                      style: TextStyle(
                        color: Color(0xff004BFE),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Raleway",
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.separated(
                itemCount: CartList.length,
                itemBuilder: (context, index) {
                  return buildCartItem(
                      context, CartList[index], screenWidth, screenHeight);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Replace with actual total calculation
                    Text(
                      "Total \$${CartModel.calculateTotal()}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Raleway",
                      ),
                    ),
                    CustomButton(
                      ontap: () {},
                      width: 170,
                      text: buttonString,
                      height: 50,
                      fontsize: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to calculate the total price of items in the cart

  // Method to build each Cart Item
  Widget buildCartItem(BuildContext context, CartModel cartItem,
      double screenWidth, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  width: screenWidth * 0.35, // Make responsive
                  height: screenHeight * 0.15, // Make responsive
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      cartItem.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.delete_outline_outlined,
                      color: const Color(0xffD97474),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: screenWidth * 0.03), // Responsive spacing
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.discreption,
                    style: const TextStyle(fontSize: 16, fontFamily: "NutioSans"),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${cartItem.color}, Size ${cartItem.size}",
                    style: const TextStyle(
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${cartItem.price}",
                        style: const TextStyle(
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            add_remove_FromCart(Icons.remove),
                            const SizedBox(width: 5),
                            Container(
                              child: Center(
                                child: Text(
                                  "${cartItem.numofItems}",
                                  style: const TextStyle(
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(7)),
                                color: const Color(0xffE5EBFC),
                              ),
                              width: screenWidth * 0.1, // Responsive width
                              height: screenHeight * 0.05, // Responsive height
                            ),
                            const SizedBox(width: 5),
                            add_remove_FromCart(Icons.add),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container add_remove_FromCart(IconData icn) {
    return Container(
      child: Icon(
        icn,
        color: KPrimeryColor,
        size: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: KPrimeryColor,
          width: 2,
        ),
      ),
      width: 30,
      height: 30,
    );
  }
}
