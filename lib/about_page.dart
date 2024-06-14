import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:webapp/constants.dart';

class AboutPage extends StatefulWidget {
  final Function(int) onTabSelected;

  const AboutPage({super.key, required this.onTabSelected});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  // A map to hold the hover state of each social media button
  final Map<String, bool> _isHovering = {
    'linkedin': false,
    'github': false,
    'whatsapp': false,
    'instagram': false,
  };

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth < 600 ? 30 : 50;
    double bodyFontSize = screenWidth < 600 ? 14 : 20;

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
                        backgroundImage: AssetImage('assets/avatar2.jpg'), // Your avatar image
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Text(
                          "Hi, I'm Surya Teja Dakey",
                          style: GoogleFonts.caveat(
                              color: Colors.white, fontSize: titleFontSize),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'A passionate Flutter developer with a knack for crafting engaging and user-friendly mobile applications. I thrive in collaborative environments, working closely with designers and product managers to bring innovative ideas to life.\n\nMy current focus is on building beautiful and performant mobile apps as well as web apps using Flutter. I enjoy the challenge of translating complex functionalities into intuitive experiences that empower users.',
                        style: GoogleFonts.kalam(
                            color: Colors.white, fontSize: bodyFontSize, fontWeight: FontWeight.w200),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Currently, I am seeking freelancing opportunities to help retail investors stay up-to-date with the financial market and grow their wealth.',
                        style: GoogleFonts.kalam(
                            color: Colors.white, fontSize: bodyFontSize, fontWeight: FontWeight.w200),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          widget.onTabSelected(1); // Navigate to works page
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
                              return const Color.fromARGB(255, 84, 58, 132);
                            }
                            return Colors.black87;
                          }),
                        ),
                      ),
                    ],
                  ),
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
                  style: GoogleFonts.kalam(color: Colors.white, fontSize: bodyFontSize, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Email: suryateja.dakey@gmail.com',
                  style: GoogleFonts.kalam(color: Colors.white, fontSize: bodyFontSize),
                ),
                const SizedBox(height: 8),
                Text(
                  'Phone: 8328166464',
                  style: GoogleFonts.kalam(color: Colors.white, fontSize: bodyFontSize),
                ),
                const SizedBox(height: 8),
                Text(
                  'Social Media:',
                  style: GoogleFonts.kalam(color: Colors.white, fontSize: bodyFontSize, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildAnimatedSocialButton(
                        'linkedin',
                        SocialMediaButton.linkedin(
                          url: "https://in.linkedin.com/in/suryateja-dakey-aa9852190?original_referer=https%3A%2F%2Fwww.google.com%2F",
                          size: 35,
                          color: Colors.blue,
                        )),
                    buildAnimatedSocialButton(
                        'github',
                        SocialMediaButton.github(
                          url: "https://github.com/suryateja-dakey/Portfolio",
                          size: 35,
                          color: Colors.blue,
                        )),
                    buildAnimatedSocialButton(
                        'whatsapp',
                        SocialMediaButton.whatsapp(
                          url: "https://wa.me/918328166464",
                          size: 35,
                          color: Colors.green,
                        )),
                    buildAnimatedSocialButton(
                        'instagram',
                        SocialMediaButton.instagram(
                          url: "https://www.instagram.com/ifucook?igsh=a3E1OXU4MmxraDMx&utm_source=qr",
                          size: 35,
                          color: Colors.pink,
                        )),
                  ],
                ),
                screenWidth < 600 ? const SizedBox() : buildConnectFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAnimatedSocialButton(String key, Widget button) {
    return MouseRegion(
      onEnter: (_) => _onHover(key, true),
      onExit: (_) => _onHover(key, false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: _isHovering[key]! ? (Matrix4.identity()..scale(1.2)) : Matrix4.identity(),
        child: button,
      ),
    );
  }

  void _onHover(String key, bool isHovered) {
    setState(() {
      _isHovering[key] = isHovered;
    });
  }

 
}
