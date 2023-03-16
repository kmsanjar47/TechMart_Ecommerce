import 'package:e_commerce_app/pages/custom_navigation_bar_ui.dart';
import 'package:e_commerce_app/pages/dashboard_page.dart';
import 'package:e_commerce_app/pages/pages.dart';
import 'package:e_commerce_app/pages/profile_page.dart';
import 'package:e_commerce_app/widgets/navigation_item.dart';
import 'package:e_commerce_app/pages/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'orders_page.dart';

void main() => runApp(const NavigationPage());

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      WishListPage(),
      OrderPage(),
      ProfilePage(),
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
            title: "Home",
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
            icon: CupertinoIcons.heart_fill,
            isSelected: index == 1,
            title: "Wishlist",
          ),
          NavBarItemWidget(
            onTap: () {
              if (_pageController!.hasClients) {
                _pageController!.jumpToPage(2);
              }
              setState(() {
                index = 2;
              });
            },
            icon: Icons.shopping_bag_outlined,
            isSelected: index == 2,
            title: "Orders",
          ),
          NavBarItemWidget(
            onTap: () {
              if (_pageController!.hasClients) {
                _pageController!.jumpToPage(3);
              }
              setState(() {
                index = 3;
              });
            },
            icon: CupertinoIcons.profile_circled,
            isSelected: index == 3,
            title: "Profile",
          ),
        ],
        currentIndex: index!,
        elevation: 16,
      ),
    );
  }
}
