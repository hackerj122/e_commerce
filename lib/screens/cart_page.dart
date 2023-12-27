// cart_page.dart
import 'package:e_commerce/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          final cartItems = cartProvider.cartItems;

          return cartItems.isEmpty
              ? Center(child: Text('Your cart is empty'))
              : ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];

              return Card(
                child: ListTile(
                  title: Text(cartItem.product.title),
                  subtitle: Text('Quantity: ${cartItem.quantity}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      cartProvider.removeFromCart(cartItem.product);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: \$${cartProvider.totalAmount.toStringAsFixed(2)}'),
                ElevatedButton(
                  onPressed: () {
                    // Implement checkout logic here
                  },
                  child: Text('Checkout'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
