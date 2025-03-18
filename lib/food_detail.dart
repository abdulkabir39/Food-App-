import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_data.dart';

class FoodDetailPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final String price;
  final String imagePlaceholder; // Path to image asset

  const FoodDetailPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imagePlaceholder,
  });

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  int _quantity = 1; // For quantity selection
  int _selectedIndex = 0; // For bottom navigation bar selection

  // Dummy bottom navigation items
  final List<String> _bottomNavItems = [
    'Home',
    'Favorites',
    'Cart',
    'Profile',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Implement navigation if required.
    });
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar with back button
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Details", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Image Container
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(widget.imagePlaceholder, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 20),
              // Food Name + Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.price,
                    style: const TextStyle(fontSize: 20, color: Colors.redAccent, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(widget.subtitle, style: const TextStyle(fontSize: 14, color: Colors.black54)),
              ),
              const SizedBox(height: 8),
              // Rating Stars (Placeholder)
              const Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star_half, color: Colors.amber, size: 20),
                  SizedBox(width: 6),
                  Text("4.5", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              // Ingredients Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Ingredients", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800])),
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _IngredientItem(label: "Cheese"),
                  _IngredientItem(label: "Tomato"),
                  _IngredientItem(label: "Lettuce"),
                  _IngredientItem(label: "Sauce"),
                ],
              ),
              const SizedBox(height: 20),
              // Description
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800])),
              ),
              const SizedBox(height: 10),
              Text(
                "This ${widget.title.toLowerCase()} uses premium ingredients, including fresh veggies and a signature sauce. Perfect for satisfying your cravings!",
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 20),
              // Quantity Selector and Add To Cart Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Quantity Selector
                  Row(
                    children: [
                      InkWell(
                        onTap: _decrementQuantity,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.remove, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text('$_quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: _incrementQuantity,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.add, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<CartData>(context, listen: false).addItem({
                        "name": widget.title,
                        "desc": widget.subtitle,
                        "price": double.parse(widget.price.replaceAll("\$", "")),
                        "quantity": _quantity,
                        "image": widget.imagePlaceholder,
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${widget.title} added to cart!")));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEBA434),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text("Add To Cart", style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        color: const Color(0xFFEBA434),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _bottomNavItems.asMap().entries.map((entry) {
            int index = entry.key;
            String label = entry.value;
            bool isSelected = index == _selectedIndex;
            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: isSelected ? Colors.white : Colors.transparent),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _IngredientItem extends StatelessWidget {
  final String label;
  const _IngredientItem({super.key, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
          child: const Center(child: Icon(Icons.food_bank, color: Colors.black54, size: 20)),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black87)),
      ],
    );
  }
}
