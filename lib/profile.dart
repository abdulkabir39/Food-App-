import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile', style: TextStyle(fontSize: 22, color: Colors.white)),
        leading: IconButton(onPressed: () { Navigator.pop(context); }, icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25)),
        actions: [
          IconButton(onPressed: () { Navigator.pop(context); }, icon: const Icon(Icons.more_vert, color: Colors.white, size: 25)),
        ],
        shadowColor: Colors.transparent,
        backgroundColor: const Color(0xFFEBA434),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 260,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned(
                  top: 30,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: const AssetImage('assets/profile.jpg'),
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 55,
                  right: 140,
                  child: GestureDetector(
                    onTap: () { print('Edit profile picture'); },
                    child: Container(
                      height: 55,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEBA434),
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(2, 2))],
                      ),
                      padding: const EdgeInsets.all(7),
                      child: const Icon(Icons.edit, size: 23, color: Colors.white),
                    ),
                  ),
                ),
                const Positioned(
                  top: 200,
                  left: 0,
                  right: 0,
                  child: Center(child: Text('Person Name', style: TextStyle(fontSize: 25, color: Colors.black))),
                ),
                const Positioned(
                  top: 225,
                  left: 0,
                  right: 0,
                  child: Center(child: Text("username", style: TextStyle(fontSize: 20, color: Colors.black54))),
                ),
                const SizedBox(height: 20,)
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text('My Details', style: TextStyle(fontSize: 27, color: Colors.black)),
                      ),
                      const SizedBox(height: 20),
                      const TextField(
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Enter email Address',
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        style: const TextStyle(fontSize: 20, color: Colors.black),
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Enter password',
                          labelStyle: const TextStyle(color: Colors.black),
                          prefixIcon: const Icon(Icons.lock_open_outlined, color: Colors.black),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off, color: Colors.black),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        style: const TextStyle(fontSize: 20, color: Colors.black),
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Confirm password',
                          labelStyle: const TextStyle(color: Colors.black),
                          prefixIcon: const Icon(Icons.lock_open_outlined, color: Colors.black),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off, color: Colors.black),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const TextField(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Enter Full Name',
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(Icons.person, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const TextField(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Enter contact no',
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(Icons.phone, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: const BoxDecoration(color: Color(0xFFEBA434)),
                        child: ElevatedButton(
                          onPressed: () { print('Save button pressed'); },
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            minimumSize: const Size(double.infinity, 50),
                            shape: const RoundedRectangleBorder(),
                          ),
                          child: const Text('Save', style: TextStyle(fontSize: 24, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
