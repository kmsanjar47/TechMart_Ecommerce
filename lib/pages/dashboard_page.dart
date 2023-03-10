import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/pages/cart_page.dart';
import 'package:e_commerce_app/pages/orders_page.dart';
import 'package:e_commerce_app/pages/product_page.dart';
import 'package:e_commerce_app/pages/support_page.dart';
import 'package:e_commerce_app/pages/wishlist_page.dart';
import 'package:e_commerce_app/utils/responsive.dart';
import 'package:e_commerce_app/widgets/custom_list_tile.dart';
import 'package:e_commerce_app/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/medium_text.dart';
import '../widgets/title_text.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _pageIndex = 0;
  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const Icon(
                Icons.circle,
                size: 150,
              ),
              CustomListTile(
                title: "HOME",
                icon: Icons.home_filled,
                pageRoute: DashboardPage(),
              ),
              CustomListTile(
                title: "ORDERS",
                icon: Icons.offline_pin_rounded,
                pageRoute: OrderPage(),
              ),
              CustomListTile(
                title: "CART",
                icon: Icons.shopping_cart,
                pageRoute: CartPage(),
              ),
              CustomListTile(
                title: "WISHLIST",
                icon: Icons.list_alt_rounded,
                pageRoute: WishListPage(),
              ),
              CustomListTile(
                title: "SUPPORT",
                icon: Icons.support_agent,
                pageRoute: SupportPage(),
              ),
              CustomListTile(title: "LOGOUT", icon: Icons.logout),
            ],
          ),
        ),
      ),
      key: _key,
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        _key.currentState!.openDrawer();
                      },
                      child: Image.asset(
                        "assets/icons/drawer_four_dot.png",
                        height: 30,
                        width: 30,
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            hintText: "Search...",
                            hintStyle: TextStyle(color: Colors.grey[200]),
                            filled: true,
                            fillColor: Colors.blueGrey[100]),
                      ),
                    ),
                    Icon(
                      CupertinoIcons.profile_circled,
                      size: 40,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),

              //Image Carousel

              CarouselSlider.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index, int pageIndex) {
                  return ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: Container(
                      child: Image.asset(
                        "assets/icons/banner1.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  height: 250,
                  initialPage: 0,
                  autoPlay: true,
                  aspectRatio: 2 / 1,
                  scrollDirection: Axis.horizontal,
                  enlargeCenterPage: true,
                  autoPlayInterval: const Duration(seconds: 10),
                ),
              ),

              Center(
                child: DotsIndicator(
                  dotsCount: 5,
                  position: _pageIndex.toDouble(),
                ),
              ),

              //Item Category Grid
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TitleText(text: "Category:"),
              ),
              Container(
                height: 200,
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(8),
                        height: ResponsiveModel.getDeviceHeight(context) * 0.60,
                        width: ResponsiveModel.getDeviceWidth(context) * 0.60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 14,
                              offset: Offset(4, 4),
                            ),
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 14,
                              offset: Offset(-4, -4),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          "assets/product_images/controller.png",
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
              ),

              //List-View Item
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TitleText(
                  text: "Explore Products:",
                ),
              ),
              Container(
                height: 700,
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          width: ResponsiveModel.getDeviceHeight(context),
                          height:
                              ResponsiveModel.getDeviceHeight(context) * 0.1217,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 14,
                                offset: const Offset(4, 4),
                              ),
                              const BoxShadow(
                                color: Colors.white,
                                blurRadius: 14,
                                offset: Offset(-4, -4),
                              ),
                            ],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //Product Image
                              Image.asset("assets/product_images/keyboard.png"),
                              //Column(product title,description)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MediumText(
                                    text: "Fantech G2324 MX Blue",
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  MediumText(text: "Mechanical Keyboard"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SmallText(text: "Regular Price: 2500TK"),
                                ],
                              ),
                              //Price
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 3,
                      );
                    },
                    itemCount: 10),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
