// product_detail_page.dart
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(product.image),
              SizedBox(height: 16),
              Text(
                product.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('\$${product.price.toStringAsFixed(2)}'),
              SizedBox(height: 8),
              Text(product.description),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  showQuantityPickerDialog(context, product);
                },
                child: Text('Add to Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showQuantityPickerDialog(BuildContext context, Product product) {
    int quantity = 1;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Quantity'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (quantity > 1) {
                          setState(() => quantity--);
                        }
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Text('$quantity'),
                    IconButton(
                      onPressed: () {
                        setState(() => quantity++);
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    if (quantity > 0) {
                      Provider.of<CartProvider>(context, listen: false)
                          .addToCart(product);
                    }
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
