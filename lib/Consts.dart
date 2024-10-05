// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'Widgets/BuildItemCart.dart';
// import 'cubit/cart_cubit.dart';
//
// class CartScreen extends StatelessWidget {
//   final List<String> cartItems = ["Item 1", "Item 2", "Item 3"];
//
//   @override
//   Widget build(BuildContext context) {
//     final cartCubit = context.read<CartCubit>();
//     cartCubit.getUserCart();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: ListView.builder(
//         itemCount: cartCubit.cartModel?.cartItems.length ?? 0,
//         itemBuilder: (context, index) {
//           return Dismissible(
//               key: Key(cartCubit.cartModel?.cartItems[index]
//                   as String), // Unique key for each item
//               direction: DismissDirection.endToStart, // Swipe to the right
//               onDismissed: (direction) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("${cartItems[index]} removed")),
//                 );
//               },
//               background: Container(
//                 alignment: Alignment.centerRight,
//                 color: Colors.red,
//                 padding: EdgeInsets.only(right: 20.0),
//                 child: Icon(Icons.delete, color: Colors.white),
//               ),
//               child: CartItemWidget(
//                 cartItem: cartCubit.cartModel!.cartItems[index],
//                 screenWidth: MediaQuery.of(context).size.width,
//                 screenHeight: MediaQuery.of(context).size.height,
//               ));
//         },
//       ),
//     );
//   }
// }
