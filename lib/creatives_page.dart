import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'constants.dart';

class CreativesPage extends StatefulWidget {
  const CreativesPage({Key? key}) : super(key: key);

  @override
  _CreativesPageState createState() => _CreativesPageState();
}

class _CreativesPageState extends State<CreativesPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late StateMachineController? stateMachineController;
  SMIInput<bool>? isHead;

  final List<bool> _imageVisibility = List.filled(4, false);
  final List<bool> _isHovered = List.filled(4, false);

  final List<Color> _containerColors = [
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.yellow.shade100,
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget buildCreativeItem(String title, String description, String note, String imagePath, int index) {
    Widget itemWidget;
    if (title == "Rive") {
      itemWidget = RiveAnimation.asset(
        imagePath,
        fit: BoxFit.cover,
        stateMachines: ['State Machine 1'],
        onInit: (artBoard) {
          stateMachineController = StateMachineController.fromArtboard(
            artBoard,
            'State Machine 1',
          );
          if (stateMachineController == null) return;
          artBoard.addController(stateMachineController!);
          isHead = stateMachineController?.findInput<bool>('Flare');
        },
      );
    } else {
      itemWidget = Image.asset(
        imagePath,
        fit: BoxFit.fitWidth,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MouseRegion(
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
              height: _isHovered[index] ? 260 : 250,
              width: _isHovered[index] ? 260 : 250,
              duration: Duration(milliseconds: 300),
              transform: _isHovered[index] ? (Matrix4.identity()..scale(1.05)) : Matrix4.identity(),
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: _containerColors[index % _containerColors.length],
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: itemWidget,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
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
                const SizedBox(height: 8),
                Text(
                  note,
                  style: noteTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Creatives',
                  style: sectionTitleTextStyle,
                ),
                const SizedBox(height: 32),
                buildCreativeItem(
                  "Rive",
                  "I can use Rive to create captivating animations for apps, enhancing user experience and engagement with visually appealing motion graphics.",
                  "Note: Tap on the image to experience Rive",
                  "assets/big_wheel_demo.riv",
                  0,
                ),
                buildCreativeItem(
                  "Firebase",
                  "I can integrate Firebase to enable seamless backend services integration, including authentication, real-time database, cloud storage, and more, empowering apps with robust features.",
                  "Implement real-time database",
                  "assets/firebaselog.png",
                  1,
                ),
                buildCreativeItem(
                  "Riverpod",
                  "I can use Riverpod to simplify state management in Flutter applications, offering a declarative and intuitive approach to manage app state and dependencies.",
                  "Manage app state and dependencies.",
                  "assets/riverpodlogo.png",
                  2,
                ),
                buildCreativeItem(
                  "Git",
                  "I can use Git, a distributed version control system, to collaborate efficiently, track changes, and manage project versions effectively, ensuring code reliability and project scalability.",
                  "Managing code efficiently among team.",
                  "assets/githublogo.png",
                  3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
