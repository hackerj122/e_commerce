// cart_provider.dart
import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart'; 

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  double get totalAmount => _cartItems.fold(
    0,
        (previousValue, cartItem) =>
    previousValue + (cartItem.product.price * cartItem.quantity),
  );

  bool isInCart(Product product) {
    return _cartItems.any((item) => item.product.id == product.id);
  }

  void addToCart(Product product) {
    if (isInCart(product)) {
      // If already in cart, increment quantity
      _cartItems.firstWhere((item) => item.product.id == product.id).quantity++;
    } else {
      // If not in cart, add new item
      _cartItems.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    _cartItems.firstWhere((item) => item.product.id == product.id).quantity = quantity;
    notifyListeners();
  }
}
