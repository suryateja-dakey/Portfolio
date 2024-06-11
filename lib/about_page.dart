import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart' as rive;
// import 'package:rive/rive.dart';
import 'constants.dart';

class AboutPage extends StatelessWidget {
  final Function(int) onTabSelected;

  const AboutPage({super.key, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.black87],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/avatar.jpg'), // Your avatar image
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Text(
                          "Hi, I'm Surya Teja Dakey",
                          style: GoogleFonts.caveat(
                              color: Colors.white, fontSize: 50),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          'I\'m Surya, a passionate Flutter developer with a knack for crafting engaging and user-friendly mobile applications. I thrive in collaborative environments, working closely with designers and product managers to bring innovative ideas to life.\n\nMy current focus is on building beautiful and performant mobile apps using Flutter. I enjoy the challenge of translating complex functionalities into intuitive experiences that empower users.',
                          style: GoogleFonts.caveat(
                              color: Colors.white, fontSize: 30),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Stack(
                        children: [
                           rive.RiveAnimation.asset(
                            "assets/eclipse.riv",
                            fit: BoxFit.cover,
                            artboard: 'State Machine 1',
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              onTabSelected(1); // Navigate to works page
                            },
                            icon: const Icon(Icons.arrow_right_alt),
                            label: const Text("Some of My Works"),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                              backgroundColor: Colors.black87,
                              textStyle: const TextStyle(fontSize: 16),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              side: const BorderSide(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ).copyWith(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.resolveWith(
                                  (states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return Color.fromARGB(255, 84, 58, 132);
                                }
                                return Colors.black87;
                              }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Currently, I am helping retail investors to stay up-to-date with the financial market and grow their wealth at OKX.',
                        style: GoogleFonts.caveat(
                            color: Colors.white, fontSize: 30),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: const Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Contact Me:',
                  style: sectionTitleTextStyle.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Email: suryateja.dakey@gmail.com',
                  style: sectionContentTextStyle.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Phone: 8328166464',
                  style: sectionContentTextStyle.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Social Media:',
                  style: sectionTitleTextStyle.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.facebook),
                      color: Colors.white,
                      onPressed: () {
                        // Add your social media links
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.telegram),
                      color: Colors.white,
                      onPressed: () {
                        // Add your social media links
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.g_mobiledata),
                      color: Colors.white,
                      onPressed: () {
                        // Add your social media links
                      },
                    ),
                  ],
                ),
                buildConnectFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
