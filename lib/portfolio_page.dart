import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:google_fonts/google_fonts.dart';
import 'works_page.dart';
import 'creatives_page.dart';
import 'about_page.dart';
import 'constants.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  late StateMachineController? stateMachineController;
  SMIInput<bool>? isHead;
  final PageController _pageController = PageController();

  void _toggleHeadAnimation() {
    if (isHead == null) return;
    setState(() {
      isHead?.value = !(isHead?.value ?? false);
      print('New value of isHead: ${isHead?.value}');
    });
  }

  void _onTabSelected(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;
    double tabTextSize = screenWidth < 600 ? 12 : 16;
    double appBarHeight = screenWidth < 600 ? 100 : 200;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: appBarBackgroundColor,
                expandedHeight: appBarHeight,
                floating: false,
                pinned: true,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Surya Teja Dakey",
                      style: GoogleFonts.reenieBeanie(
                          color: Colors.white, fontSize: tabTextSize)),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      RiveAnimation.asset(
                        "assets/creativebg.riv",
                        fit: BoxFit.cover,
                        stateMachines: ['State Machine 1'],
                        onInit: (artBoard) {
                          stateMachineController =
                              StateMachineController.fromArtboard(
                                  artBoard, 'State Machine 1');
                          if (stateMachineController == null) return;
                          artBoard.addController(stateMachineController!);
                          isHead =
                              stateMachineController?.findInput<bool>('Flare');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 30),
                  Expanded(
                    child: TextButton(
                      onPressed: () => _onTabSelected(0),
                      child: Text(
                        "SURYA TEJA",
                        style: tabTextStyle.copyWith(fontSize: tabTextSize),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: TextButton(
                      onPressed: () => _onTabSelected(1),
                      child: Text(
                        "WORKS",
                        style: tabTextStyle.copyWith(fontSize: tabTextSize),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => _onTabSelected(2),
                      child: Text(
                        "CREATIVES",
                        style: tabTextStyle.copyWith(fontSize: tabTextSize),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => _onTabSelected(0),
                      child: Text(
                        "ABOUT",
                        style: tabTextStyle.copyWith(fontSize: tabTextSize),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25),
                ],
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: [
                    AboutPage(onTabSelected: _onTabSelected),
                    const WorksPage(),
                     CreativesPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
