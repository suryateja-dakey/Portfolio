import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
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

class _PortfolioPageState extends State<PortfolioPage> with SingleTickerProviderStateMixin {
  late rive.StateMachineController? stateMachineController;
  rive.SMIInput<bool>? isHead;
  final PageController _pageController = PageController();

  final List<bool> _isHovered = List.filled(4, false);
  late AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    // _requestPermissions();
  }

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
  void dispose() {
    _pageController.dispose();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tabTextSize = screenWidth < 600 ? 15 : 16;
    double appBarHeight = screenWidth < 600 ? 120 : 200;
    bool isMobile = screenWidth < 600;

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
                        color: Colors.white,
                        fontSize: tabTextSize,
                      )),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      rive.RiveAnimation.asset(
                        "assets/creativebg.riv",
                        fit: BoxFit.cover,
                        stateMachines: ['State Machine 1'],
                        onInit: (artBoard) {
                          stateMachineController =
                              rive.StateMachineController.fromArtboard(
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
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: isMobile
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: MouseRegion(
                              onEnter: (_) => setState(() => _isHovered[0] = true),
                              onExit: (_) => setState(() => _isHovered[0] = false),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                transform: _isHovered[0]
                                    ? Matrix4.identity().scaled(1.1)
                                    : Matrix4.identity(),
                                child: TextButton(
                                  onPressed: () => _onTabSelected(0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "SURYA TEJA",
                                        style: tabTextStyle.copyWith(
                                            fontSize: tabTextSize,
                                            fontWeight: FontWeight.w400,
                                            color: _isHovered[0] ? Colors.blue : Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          PopupMenuButton<int>(
                            onSelected: _onTabSelected,
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.black, Colors.grey[800]!],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.work, color: Colors.white),
                                      SizedBox(width: 10),
                                      Text(
                                        'WORKS',
                                        style: tabTextStyle.copyWith(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.black, Colors.grey[800]!],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.create, color: Colors.white),
                                      SizedBox(width: 10),
                                      Text(
                                        'CREATIVES',
                                        style: tabTextStyle.copyWith(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: 0,
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.black, Colors.grey[800]!],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.info, color: Colors.white),
                                      SizedBox(width: 10),
                                      Text(
                                        'ABOUT',
                                        style: tabTextStyle.copyWith(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "MENU",
                                    style: tabTextStyle.copyWith(
                                        fontSize: tabTextSize,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  AnimatedIcon(
                                    icon: AnimatedIcons.menu_close,
                                    progress: _animationController!,
                                    color: Colors.white,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: MouseRegion(
                              onEnter: (_) => setState(() => _isHovered[0] = true),
                              onExit: (_) => setState(() => _isHovered[0] = false),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                transform: _isHovered[0]
                                    ? Matrix4.identity().scaled(1.1)
                                    : Matrix4.identity(),
                                child: TextButton(
                                  onPressed: () => _onTabSelected(0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "SURYA TEJA",
                                        style: tabTextStyle.copyWith(
                                            fontSize: tabTextSize,
                                            color: _isHovered[0] ? Colors.blue : Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: MouseRegion(
                              onEnter: (_) => setState(() => _isHovered[1] = true),
                              onExit: (_) => setState(() => _isHovered[1] = false),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                transform: _isHovered[1]
                                    ? Matrix4.identity().scaled(1.1)
                                    : Matrix4.identity(),
                                child: TextButton(
                                  onPressed: () => _onTabSelected(1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.work, color: _isHovered[1] ? Colors.blue : Colors.white),
                                      SizedBox(width: 5),
                                      Text(
                                        "WORKS",
                                        style: tabTextStyle.copyWith(
                                            fontSize: tabTextSize,
                                            color: _isHovered[1] ? Colors.blue : Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: MouseRegion(
                              onEnter: (_) => setState(() => _isHovered[2] = true),
                              onExit: (_) => setState(() => _isHovered[2] = false),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                transform: _isHovered[2]
                                    ? Matrix4.identity().scaled(1.1)
                                    : Matrix4.identity(),
                                child: TextButton(
                                  onPressed: () => _onTabSelected(2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.create, color: _isHovered[2] ? Colors.blue : Colors.white),
                                      SizedBox(width: 5),
                                      Text(
                                        "CREATIVES",
                                        style: tabTextStyle.copyWith(
                                            fontSize: tabTextSize,
                                            color: _isHovered[2] ? Colors.blue : Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: MouseRegion(
                              onEnter: (_) => setState(() => _isHovered[3] = true),
                              onExit: (_) => setState(() => _isHovered[3] = false),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                transform: _isHovered[3]
                                    ? Matrix4.identity().scaled(1.1)
                                    : Matrix4.identity(),
                                child: TextButton(
                                  onPressed: () => _onTabSelected(0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.info, color: _isHovered[3] ? Colors.blue : Colors.white),
                                      SizedBox(width: 5),
                                      Text(
                                        "ABOUT",
                                        style: tabTextStyle.copyWith(
                                            fontSize: tabTextSize,
                                            color: _isHovered[3] ? Colors.blue : Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: [
                    AboutPage(onTabSelected: _onTabSelected),
                     WorksPage(onTabSelected: _onTabSelected),
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
