import 'dart:math';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rive/rive.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'constants.dart';

class WorksPage extends StatefulWidget {
  const WorksPage({Key? key}) : super(key: key);

  @override
  _WorksPageState createState() => _WorksPageState();
}

class _WorksPageState extends State<WorksPage> {
  final ScrollController _verticalScrollController = ScrollController();

  @override
  void dispose() {
    _verticalScrollController.dispose();
    super.dispose();
  }

  void _showImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: InteractiveViewer(
            child: Image.asset(imagePath),
          ),
        ),
      ),
    );
  }

  Widget buildWorkItem(String title, String description, List<String> imagePaths,
      int index, List<String> labels, Color containerColor) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isLargeScreen)
                Column(
                  children: [
                    ShakeTransition(
                      child: Text(
                        title,
                        style: headerWorkTextStyle,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ShakeTransition(
                      child: Text(
                        description,
                        style: subTextStyle,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      children: labels.map((label) {
                        return ShakeTransition(
                          child: Chip(
                            label: Text(label, style: TextStyle(color: Colors.white)),
                            backgroundColor: Color.fromARGB(255, 44, 42, 42),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              SmoothImageTransition(
                child: isLargeScreen
                    ? Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShakeTransition(
                                  child: Text(
                                    title,
                                    style: headerWorkTextStyle,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  description,
                                  style: subTextStyle,
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8.0,
                                  children: labels.map((label) {
                                    return Chip(
                                      label: Text(label, style: TextStyle(color: Colors.white)),
                                      backgroundColor: Color.fromARGB(255, 44, 42, 42),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Flexible(
                            child: OptimizedCarousel(
                              imagePaths: imagePaths,
                              showImageDialog: _showImageDialog, // Pass the function as a callback
                            ),
                          ),
                        ],
                      )
                    : OptimizedCarousel(
                        imagePaths: imagePaths,
                        showImageDialog: _showImageDialog, // Pass the function as a callback
                      ),
              ),
              const Divider(thickness: 0.5),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Rive animation background
          RiveAnimation.asset(
            "assets/workbg.riv",
            fit: BoxFit.cover,
            stateMachines: ['State Machine 1'],
          ),
          // Main content
          SingleChildScrollView(
            controller: _verticalScrollController,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'My Works',
                    style: sectionTitleTextStyle,
                  ),
                  const Divider(thickness: 0.5),
                  buildWorkItem(
                    "Card Management App for Card Holder",
                    "A user-centric crypto exchange providing a seamless trading experience designed for novice and advanced users.",
                    [
                      "assets/myworks/cms1.png",
                      "assets/myworks/cms2.png",
                    ],
                    0,
                    ["Finance", "Crypto", "User Experience"],
                    Colors.green.shade100,
                  ),
                  buildWorkItem(
                    "E-Commerce Application",
                    "A versatile e-commerce app designed to enhance the online shopping experience with intuitive navigation and secure transactions.",
                    [
                      "assets/myworks/blackstore1.png",
                      "assets/myworks/blackstore2.png",
                      "assets/myworks/blackstore3.png",
                      "assets/myworks/blackstore4.png",
                    ],
                    1,
                    ["Shopping", "E-Commerce", "Security"],
                    Colors.red.shade100,
                  ),
                  buildWorkItem(
                    "Weather App with Realtime API",
                    "A weather forecasting app that provides accurate and up-to-date weather information based on real-time data.",
                    [
                      "assets/myworks/weather1.png",
                      "assets/myworks/weather2.png",
                      "assets/myworks/weather3.png",
                    ],
                    2,
                    ["Weather", "API", "Realtime Data"],
                    Colors.blue.shade100,
                  ),
                  buildWorkItem(
                    "BMI Calculator",
                    "A user-friendly BMI calculator that helps users keep track of their body mass index and maintain a healthy lifestyle.",
                    [
                      "assets/myworks/bmi1.png",
                      "assets/myworks/bmi2.png",
                      "assets/myworks/bmi3.png",
                      "assets/myworks/bmi4.png",
                      "assets/myworks/bmi5.png",
                    ],
                    3,
                    ["Health", "Fitness", "Calculator"],
                    Colors.yellow.shade100,
                  ),
                  buildWorkItem(
                    "Chat Application with Firebase",
                    "A real-time chat application leveraging Firebase for seamless and instantaneous messaging.",
                    [
                      "assets/myworks/chater1.png",
                      "assets/myworks/chater2.png",
                      "assets/myworks/chater3.png",
                    ],
                    4,
                    ["Chat", "Firebase", "Realtime"],
                    Colors.purple.shade100,
                  ),
                  buildConnectFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShakeTransition extends StatelessWidget {
  final Widget child;
  final double offset;
  final Duration duration;

  const ShakeTransition({
    Key? key,
    required this.child,
    this.offset = 16.0,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(sin(value * pi * 2) * offset, 0.0),
          child: child,
        );
      },
      child: child,
    );
  }
}

class SmoothImageTransition extends StatefulWidget {
  final Widget child;

  const SmoothImageTransition({Key? key, required this.child}) : super(key: key);

  @override
  _SmoothImageTransitionState createState() => _SmoothImageTransitionState();
}

class _SmoothImageTransitionState extends State<SmoothImageTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}

class OptimizedCarousel extends StatefulWidget {
  final List<String> imagePaths;
  final void Function(BuildContext, String) showImageDialog;

  const OptimizedCarousel({
    Key? key,
    required this.imagePaths,
    required this.showImageDialog,
  }) : super(key: key);

  @override
  _OptimizedCarouselState createState() => _OptimizedCarouselState();
}

class _OptimizedCarouselState extends State<OptimizedCarousel> {
  List<Color> containerColors = [
    Colors.green.shade100,
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.yellow.shade100,
    Colors.purple.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 360,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        enlargeCenterPage: true,
      ),
      itemCount: widget.imagePaths.length,
      itemBuilder: (context, index, realIndex) {
        return MouseRegion(
          onEnter: (_) => setState(() {}),
          onExit: (_) => setState(() {}),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: containerColors[index % containerColors.length],
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8.0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () => widget.showImageDialog(context, widget.imagePaths[index]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(widget.imagePaths[index], fit: BoxFit.cover),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Constants {
  static const TextStyle headerWorkTextStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subTextStyle = TextStyle(
    fontSize: 16.0,
  );

  static const TextStyle sectionTitleTextStyle = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
  );
}


