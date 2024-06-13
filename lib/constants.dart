import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color appBarBackgroundColor = Color.fromARGB(255, 72, 45, 77);

final TextStyle headerTextStyle = GoogleFonts.abel(
  color: Colors.white,
  
  fontSize: 14,
  fontWeight: FontWeight.w300,
);
final TextStyle subTextStyle = GoogleFonts.workSans(
  color: Colors.white,
  fontSize: 14,
  fontWeight: FontWeight.w200,
);
  // const TextStyle headerWorkTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  // //  const TextStyle subTextStyle = TextStyle(fontSize: 14);
  //  const TextStyle sectionTitleTextStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

final TextStyle noteTextStyle = GoogleFonts.workSans(
  color: Colors.white,
  fontSize: 14,
  fontWeight: FontWeight.w200,
);

final TextStyle headerWorkTextStyle = GoogleFonts.workSans(
  color: Colors.white.withOpacity(0.9),
  fontSize: 30,
  fontWeight: FontWeight.w500,
);

final TextStyle tabTextStyle = GoogleFonts.workSans(
  color: Colors.white,
  fontSize: 15,
  fontWeight: FontWeight.w300,
);

final TextStyle sectionTitleTextStyle = GoogleFonts.workSans(
  fontSize: 32,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

final TextStyle sectionContentTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.white,
);

Widget buildConnectFooter() {
  return Container(
    height: 100,
    color: Colors.white10,
    child: Padding(
      padding: const EdgeInsets.all(40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text("Let's connect!", style: tabTextStyle)),
          Flexible(child: Text("Email: suryateja.dakey@gmail.com", style: tabTextStyle)),
          Flexible(child: Text("© 2024 by Surya Teja", style: tabTextStyle))
        ],
      ),
    ),
  );
}