// product_listing_page.dart
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/provider/api_service.dart';
import 'package:e_commerce/provider/cart_provider.dart';
import 'package:e_commerce/screens/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Listing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          return FutureBuilder<List<Product>>(
            future: ApiService().getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error loading products'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No products available'));
              } else {
                final products = snapshot.data!;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final isInCart = cartProvider.isInCart(product);

                    return Card(
                      child: ListTile(
                        title: Text(product.title),
                        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                        leading: Image.network(product.image),
                        trailing: ElevatedButton(
                          onPressed: () {
                            if (isInCart) {
                              cartProvider.removeFromCart(product);
                            } else {
                              cartProvider.addToCart(product);
                            }
                          },
                          child: Text(isInCart ? 'Remove from Cart' : 'Add to Cart'),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(product: product),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
