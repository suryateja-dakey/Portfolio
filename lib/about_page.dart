import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      'A people-first Product Designer with a passion for crafting delightful experiences across screens. With a keen eye for clean design, I am dedicated to creating elegant and visually appealing user experiences that elevate complex workflows.',
                      style: GoogleFonts.caveat(
                          color: Colors.white, fontSize: 30),
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  child: Text(
                    'Currently, I am helping retail investors to stay up-to-date with the financial market and grow their wealth at OKX.',
                    style: GoogleFonts.caveat(
                        color: Colors.white, fontSize: 30),
                  ),
                ),
                Spacer()
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: Divider(
                thickness: 1,
              ),
            ),
            const SizedBox(height: 16),
             Text(
              'About Me:',
              style: sectionTitleTextStyle,
            ),
            const SizedBox(height: 8),
             Text(
              'Hi, I am Surya Teja Dakey. A people-first Product Designer...',
              style: sectionContentTextStyle,
            ),
            const SizedBox(height: 16),
             Text(
              'Contact Me:',
              style: sectionTitleTextStyle,
            ),
            const SizedBox(height: 8),
             Text(
              'Email: suryateja.dakey@gmail.com',
              style: sectionContentTextStyle,
            ),
            const SizedBox(height: 8),
             Text(
              'Phone: 8328166464',
              style: sectionContentTextStyle,
            ),
            const SizedBox(height: 8),
             Text(
              'Social Media:',
              style: sectionTitleTextStyle,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.link),
                  color: Colors.white,
                  onPressed: () {
                    // Add your social media links
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.link),
                  color: Colors.white,
                  onPressed: () {
                    // Add your social media links
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.link),
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
    );
  }
}
