import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'constants.dart';

class WorksPage extends StatefulWidget {
  const WorksPage({Key? key}) : super(key: key);

  @override
  _WorksPageState createState() => _WorksPageState();
}

class _WorksPageState extends State<WorksPage> with SingleTickerProviderStateMixin {
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();
  late AnimationController _animationController;
  List<bool> _imageVisibility = List.filled(5, false);

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    // Add listener to vertical scroll controller
    _verticalScrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    // Remove listener and dispose controllers
    _verticalScrollController.removeListener(_onScroll);
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // Function to handle scroll events
  void _onScroll() {
    for (int i = 0; i < _imageVisibility.length; i++) {
      final double startOffset = i * MediaQuery.of(context).size.height;
      final double endOffset = (i + 1) * MediaQuery.of(context).size.height;
      if (_verticalScrollController.offset >= startOffset &&
          _verticalScrollController.offset <= endOffset) {
        setState(() {
          _imageVisibility[i] = true;
        });
        if (!_animationController.isAnimating) {
          _animationController.forward();
        }
      }
    }
  }

  // Widget to build each work item
  Widget buildWorkItem(String title, String description, String imagePath, int index) {
    return Column(
      children: [
        // Row containing work item details and image
        Row(
          children: [
            // Work item details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: headerWorkTextStyle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: subTextStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Animated image
            Flexible(
              child: VisibilityDetector(
                key: Key('$imagePath$index'),
                onVisibilityChanged: (info) {
                  if (info.visibleFraction == 1) {
                    setState(() {
                      _imageVisibility[index] = true;
                    });
                    if (!_animationController.isAnimating) {
                      _animationController.forward();
                    }
                  }
                },
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: _imageVisibility[index] ? 1 : 0,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _animationController,
                      curve: Curves.easeInOut,
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        imagePath,
                        width: 500,
                        height: 500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const Divider(thickness: 0.5),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _verticalScrollController,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text(
              'Some of my works:',
              style: sectionTitleTextStyle,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: ListView(
                controller: _horizontalScrollController,
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/work1.png'),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/work2.png'),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/work1.png'),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/work2.png'),
                  ),
                ],
              ),
            ),
            // Build each work item
            buildWorkItem(
              "Card Management App for Card Holder",
              "A user-centric crypto exchange providing a seamless trading experience designed for novice and advanced users.",
              "assets/work2.png",
              0,
            ),
            buildWorkItem(
              "E-Commerce Application",
              "A versatile e-commerce app designed to enhance the online shopping experience with intuitive navigation and secure transactions.",
              "assets/work1.png",
              1,
            ),
            buildWorkItem(
              "Weather App with Realtime API",
              "A weather forecasting app that provides accurate and up-to-date weather information based on real-time data.",
              "assets/work2.png",
              2,
            ),
            buildWorkItem(
              "BMI Calculator",
              "A user-friendly BMI calculator that helps users keep track of their body mass index and maintain a healthy lifestyle.",
              "assets/work1.png",
              3,
            ),
            buildWorkItem(
              "Chat Application with Firebase",
              "A real-time chat application leveraging Firebase for seamless and instantaneous messaging.",
              "assets/work2.png",
              4,
            ),
          ],
        ),
      ),
    );
  }
}
