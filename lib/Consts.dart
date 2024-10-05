import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final List<String> cartItems = ["Item 1", "Item 2", "Item 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(cartItems[index]), // Unique key for each item
            direction: DismissDirection.endToStart, // Swipe to the right
            onDismissed: (direction) {
              // Perform the delete action, e.g., remove item from list
              cartItems.removeAt(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${cartItems[index]} removed")),
              );
            },
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              title: Text(cartItems[index]),
              subtitle: Text("Price: \$20.00"),
            ),
          );
        },
      ),
    );
  }
}
