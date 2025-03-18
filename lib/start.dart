import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';

class StartPg extends StatefulWidget {
  const StartPg({super.key});
  @override
  State<StartPg> createState() => _StartPgState();
}

class _StartPgState extends State<StartPg> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        children: [
          _buildPage(
            "A Feast Awaits",
            "All your favorite meals so fine,\nOrder with ease, at any time",
            "assets/yumly33.png",
            "Continue",
            true,
          ),
          _buildPage(
            "Just One Click",
            "Get delivery at your doorstep,\nYour meal arrives, fresh and quick",
            "assets/yumly44.png",
            "Get Started",
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildPage(String title, String subtitle, String imagepath, String buttonText, bool isPageOne) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double height = constraints.maxHeight;
        double width = constraints.maxWidth;
        // Define the sizes relative to screen height/width:
        double containerHeight = height * 0.35; // Reduced orange container height
        double imageHeight = height * 0.4;        // Overlapping image height
        double imageWidth = width * 0.7;          // Overlapping image width

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Orange container – positioned below half of the image height
            Positioned(
              top: imageHeight * 0.5,
              left: 0,
              right: 0,
              child: Container(
                height: containerHeight,
                width: width,
                decoration: const BoxDecoration(
                  color: Color(0xFFEBA434),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(70)),
                ),
              ),
            ),
            // Overlapping image – placed at the top, centered, and fully visible
            Positioned(
              top: 0,
              left: (width - imageWidth) / 2,
              child: SizedBox(
                height: imageHeight,
                width: imageWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    imagepath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Text and buttons section – placed below the container
            Positioned(
              top: imageHeight * 0.5 + containerHeight + 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 23),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDots(isActive: isPageOne),
                      const SizedBox(width: 7),
                      _buildDots(isActive: !isPageOne),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Signup button
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignupPage()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) return Colors.white24;
                          return const Color(0xFFEBA434);
                        }),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                        ),
                      ),
                      child: Text(buttonText, style: const TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Sign in button
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) return const Color(0xFFEBA434);
                          return Colors.black12;
                        }),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                        ),
                      ),
                      child: const Text("Sign in ", style: TextStyle(fontSize: 19, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDots({required bool isActive}) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFFEBA434) : Colors.grey,
      ),
    );
  }
}
