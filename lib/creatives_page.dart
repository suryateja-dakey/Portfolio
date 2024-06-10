import 'package:flutter/material.dart';
import 'constants.dart';

class CreativesPage extends StatelessWidget {
  const CreativesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
             Text(
              'Creatives:',
              style: sectionTitleTextStyle,
            ),
            const SizedBox(height: 8),
            // Add your creatives content here
             Text(
              'Here are some creative works...',
              style: sectionContentTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
