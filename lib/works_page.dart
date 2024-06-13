import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'constants.dart';

class WorksPage extends StatefulWidget {
  const WorksPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WorksPageState createState() => _WorksPageState();
}

class _WorksPageState extends State<WorksPage> with SingleTickerProviderStateMixin {
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();
  late AnimationController _animationController;
  final List<bool> _imageVisibility = List.filled(5, false);
  final List<bool> _isHovered = List.filled(5, false);

  final List<Color> _containerColors = [
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.yellow.shade100,
    Colors.purple.shade100,
  ];

  StateMachineController? stateMachineController;
  SMIInput<bool>? isHead;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _verticalScrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _verticalScrollController.removeListener(_onScroll);
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

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

  Widget buildWorkItem(String title, String description, String imagePath, int index, List<String> labels, Color containerColor) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                ],
              ),
            ),
            const SizedBox(width: 16),
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
                child: MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _isHovered[index] = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _isHovered[index] = false;
                    });
                  },
                  child: AnimatedContainer(
                    height: 360,
                    width: 540,
                    duration: Duration(milliseconds: 300),
                    transform: _isHovered[index]
                        ? (Matrix4.identity()..scale(1.05))
                        : Matrix4.identity(),
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
                          padding: const EdgeInsets.all(16.0),
                          child: AspectRatio(
                            aspectRatio: 7 / 4.5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: containerColor,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    imagePath,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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
    return Scaffold(
      body: Stack(
        children: [
          // Rive animation background
          RiveAnimation.asset(
            "assets/workbg.riv",
            fit: BoxFit.cover,
            stateMachines: ['State Machine 1'],
            onInit: (artBoard) {
              stateMachineController = StateMachineController.fromArtboard(
                  artBoard, 'State Machine 1');
              if (stateMachineController == null) return;
              artBoard.addController(stateMachineController!);
              isHead = stateMachineController?.findInput<bool>('Flare');
            },
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
                    'Selected Works',
                    style: sectionTitleTextStyle,
                  ),
                  const Divider(thickness: 0.5),
                  buildWorkItem(
                    "Card Management App for Card Holder",
                    "A user-centric crypto exchange providing a seamless trading experience designed for novice and advanced users.",
                    "assets/work2.png",
                    0,
                    ["Finance", "Crypto", "User Experience"],
                    _containerColors[0],
                  ),
                  buildWorkItem(
                    "E-Commerce Application",
                    "A versatile e-commerce app designed to enhance the online shopping experience with intuitive navigation and secure transactions.",
                    "assets/work1.png",
                    1,
                    ["Shopping", "E-Commerce", "Security"],
                    _containerColors[1],
                  ),
                  buildWorkItem(
                    "Weather App with Realtime API",
                    "A weather forecasting app that provides accurate and up-to-date weather information based on real-time data.",
                    "assets/work2.png",
                    2,
                    ["Weather", "API", "Realtime Data"],
                    _containerColors[2],
                  ),
                  buildWorkItem(
                    "BMI Calculator",
                    "A user-friendly BMI calculator that helps users keep track of their body mass index and maintain a healthy lifestyle.",
                    "assets/work1.png",
                    3,
                    ["Health", "Fitness", "Calculator"],
                    _containerColors[3],
                  ),
                  buildWorkItem(
                    "Chat Application with Firebase",
                    "A real-time chat application leveraging Firebase for seamless and instantaneous messaging.",
                    "assets/work2.png",
                    4,
                    ["Chat", "Firebase", "Realtime"],
                    _containerColors[4],
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
