import 'package:e_commerce_app/pages/custom_navigation_bar_ui.dart';
import 'package:e_commerce_app/pages/dashboard_page.dart';
import 'package:e_commerce_app/widgets/navigation_item.dart';
import 'package:e_commerce_app/pages/search_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? index;
  static PageController? _pageController;
  static GlobalKey<ScaffoldState>? globalKey;

  @override
  void initState() {
    super.initState();
    index = 0;
    _pageController = PageController(
      initialPage: index!,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _pages = [
      DashboardPage(),
      const SearchPage(),
    ];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (indexX) {
          index = indexX;
        },
        children: _pages,
      ),
      bottomNavigationBar: CustomNavigationBar(
        items: [
          NavBarItemWidget(
            onTap: () {
              if (_pageController!.hasClients) {
                _pageController!.jumpToPage(0);
              }
              setState(() {
                index = 0;
              });
            },
            icon: Icons.home,
            isSelected: index == 0,
            title: "home",
          ),
          NavBarItemWidget(
            onTap: () {
              if (_pageController!.hasClients) {
                _pageController!.jumpToPage(1);
              }
              setState(() {
                index = 1;
              });
            },
            icon: Icons.search,
            isSelected: index == 1,
            title: "Search",
          ),
        ],
        currentIndex: index!,
        elevation: 16,
      ),
    );
  }
}
