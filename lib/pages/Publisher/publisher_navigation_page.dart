import 'package:e_commerce_app/pages/General%20User/pages.dart';
import 'package:e_commerce_app/pages/Publisher/publisher_dashboard_page.dart';
import 'package:e_commerce_app/pages/Publisher/publisher_product_page.dart';
import 'package:e_commerce_app/pages/Publisher/publisher_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PublisherNavigationPage extends StatelessWidget {
  const PublisherNavigationPage({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
      const PublisherDashboard(),
      const PublishedProductsPage(),
      const PublisherProfilePage(),
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
            color: Colors.purple,
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
            color: Colors.red,
            icon: Icons.production_quantity_limits,
            isSelected: index == 1,
            title: "Products",
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
            color: Colors.green,
            icon: CupertinoIcons.profile_circled,
            isSelected: index == 2,
            title: "Profile",
          ),

        ],
        currentIndex: index!,
        elevation: 16,
      ),
    );
  }
}
