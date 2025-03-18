import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartData extends ChangeNotifier {
  List<Map<String, dynamic>> cartItems = [];

  CartData() {
    loadCart();
  }

  // Load saved cart data from SharedPreferences
  Future<void> loadCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartString = prefs.getString('cartItems');
    if (cartString != null) {
      List decoded = jsonDecode(cartString);
      cartItems = List<Map<String, dynamic>>.from(decoded);
      notifyListeners();
    }
  }

  // Save cart data to SharedPreferences
  Future<void> saveCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartString = jsonEncode(cartItems);
    await prefs.setString('cartItems', cartString);
  }

  // Add an item to the cart
  void addItem(Map<String, dynamic> item) {
    int existingIndex = cartItems.indexWhere((element) => element['name'] == item['name']);
    if (existingIndex != -1) {
      cartItems[existingIndex]['quantity'] += item['quantity'];
    } else {
      cartItems.add(item);
    }
    saveCart();
    notifyListeners();
  }

  // Remove an item at a specific index
  void removeItemAt(int index) {
    cartItems.removeAt(index);
    saveCart();
    notifyListeners();
  }

  // Clear the entire cart
  void clearCart() {
    cartItems.clear();
    saveCart();
    notifyListeners();
  }

  // Calculate the total cost
  double getTotal() {
    return cartItems.fold(0, (sum, item) => sum + (item["price"] * item["quantity"]));
  }
}
