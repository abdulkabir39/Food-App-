import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_data.dart';
import 'profile.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});
  @override
  State<Cart> createState() => _CartState();
}
class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartData>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBA434),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('My Cart', style: TextStyle(fontSize: 22, color: Colors.white)),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white, size: 30),
            onSelected: (value) {
              if (value == "empty_cart") {
                cartData.clearCart();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "empty_cart", child: Text("Empty Cart", style: TextStyle(fontSize: 15))),
            ],
          )
        ],
      ),
      body: cartData.cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty!", style: TextStyle(fontSize: 18, color: Colors.black54)))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Order Summary', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartData.cartItems.length,
                    itemBuilder: (context, index) {
                      var item = cartData.cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Image.asset(item["image"], height: 80, width: 80, fit: BoxFit.cover),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item["name"], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                      Text(item["desc"], style: const TextStyle(fontSize: 14, color: Colors.black54)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("\$${(item["price"] * item["quantity"]).toStringAsFixed(2)}", style: const TextStyle(fontSize: 18, color: Colors.red)),
                                          Text("x${item["quantity"]}", style: const TextStyle(fontSize: 18)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    cartData.removeItemAt(index);
                                  },
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Sub Total', style: TextStyle(fontSize: 18)),
                          Text("\$${cartData.getTotal().toStringAsFixed(2)}", style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                      const Divider(color: Colors.black, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Shipping', style: TextStyle(fontSize: 18)),
                          const Text('\$10.79', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      const Divider(color: Colors.black, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("\$${(cartData.getTotal() + 10.79).toStringAsFixed(2)}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEBA434)),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile())),
                          child: const Text('Place Order', style: TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
