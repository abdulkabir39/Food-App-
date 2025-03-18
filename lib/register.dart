import 'package:flutter/material.dart';
import 'start.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String _selectedPaymentMethod = "Cash on Delivery";
  void _registerUser() {
    final String firstName = _firstNameController.text.trim();
    final String lastName = _lastNameController.text.trim();
    final String phone = _phoneController.text.trim();
    final String address = _addressController.text.trim();
    if (firstName.isEmpty || lastName.isEmpty || phone.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("User registered: $firstName $lastName")),
    );
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StartPg()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, size: 24),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Image.asset('assets/images/yumly-logo22.png', height: 140),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text('REGISTER', style: GoogleFonts.poppins(fontSize: 27)),
              ),
              const SizedBox(height: 30),
              _buildTextField(_firstNameController, "First Name", Icons.person),
              const SizedBox(height: 20),
              _buildTextField(_lastNameController, "Last Name", Icons.person),
              const SizedBox(height: 20),
              _buildTextField(_phoneController, "Phone Number", Icons.phone, isNumeric: true),
              const SizedBox(height: 20),
              _buildTextField(_addressController, "Delivery Address", Icons.home),
              const SizedBox(height: 20),
              Text('Preferred Payment Method', style: GoogleFonts.poppins(fontSize: 16)),
              const SizedBox(height: 5),
              DropdownButtonFormField<String>(
                value: _selectedPaymentMethod,
                items: ["Cash on Delivery", "Credit Card", "PayPal"].map((String method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPaymentMethod = newValue!;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  prefixIcon: const Icon(Icons.payment),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const StartPg())); },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEBA434),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Text('Register', style: GoogleFonts.readexPro(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isNumeric = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 16)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: isNumeric ? TextInputType.phone : TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Enter your $label',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            prefixIcon: Icon(icon),
          ),
        ),
      ],
    );
  }
}
