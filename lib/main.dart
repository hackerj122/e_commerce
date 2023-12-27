import 'package:e_commerce/provider/cart_provider.dart';
import 'package:e_commerce/screens/cart_page.dart';
import 'package:e_commerce/screens/product_detail_page.dart';
import 'package:e_commerce/screens/product_listing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
    create: (context) => CartProvider(),
    child: const MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ProductListingPage(),
        '/product_detail': (context) => ProductDetailPage(product: null!), // Placeholder product
        '/cart': (context) => CartPage(),
      },
    );
  }
}

