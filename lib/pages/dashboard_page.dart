import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with AutomaticKeepAliveClientMixin<DashboardPage> {
  int _pageIndex = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  List<Widget> drawerItems = [
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
  ];


  List<Map<String, dynamic>> productList = [
    Product(
        title: "Fantech G2324 MX Blue",
        price: 2500,
        category: "Mechanical Keyboard",
        listViewImagePath: "assets/product_images/keyboard.png",
        productImagesPath: ["assets/product_images/keyboard.png"]).toMap(),
    Product(
        title: "Fantech@ G2324 MX Red",
        price: 2550,
        category: "Mechanical Keyboard",
        listViewImagePath: "assets/product_images/keyboard.png",
        productImagesPath: ["assets/product_images/keyboard.png"]).toMap(),
    Product(
        title: "Fantech@ G2324 MX Red",
        price: 2550,
        category: "Mechanical Keyboard",
        listViewImagePath: "assets/product_images/keyboard.png",
        productImagesPath: ["assets/product_images/keyboard.png"]).toMap(),
    Product(
        title: "Fantech@ G2324 MX Red",
        price: 2550,
        category: "Mechanical Keyboard",
        listViewImagePath: "assets/product_images/keyboard.png",
        productImagesPath: ["assets/product_images/keyboard.png"]).toMap(),
  ];

  List<CategoryBox> categoryBoxList = const [
    CategoryBox(
        categoryName: "Keyboard",
        imagePath: "assets/category_icons/controller.png"),
    CategoryBox(
        categoryName: "Mouse", imagePath: "assets/category_icons/mouse.png"),
    CategoryBox(
        categoryName: "Ram", imagePath: "assets/category_icons/ram-memory.png"),
    CategoryBox(
        categoryName: "HDD", imagePath: "assets/category_icons/hdd.png"),
    CategoryBox(
        categoryName: "GPU", imagePath: "assets/category_icons/gpu.png"),
    CategoryBox(
        categoryName: "CPU", imagePath: "assets/category_icons/cpu.png"),
    CategoryBox(
        categoryName: "Laptop", imagePath: "assets/category_icons/laptop.png"),
    CategoryBox(
        categoryName: "PC", imagePath: "assets/category_icons/computer.png"),
    CategoryBox(
        categoryName: "Projector",
        imagePath: "assets/category_icons/projector.png"),
    CategoryBox(
        categoryName: "Headphones",
        imagePath: "assets/category_icons/headphones.png"),
  ];


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: drawerItems
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
                        height: MediaQuery.of(context).size.height * 0.0775,
                        width: MediaQuery.of(context).size.width * 0.0775,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.67,
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
                    const Icon(
                      CupertinoIcons.profile_circled,
                      size: 40,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //------------------------Image Carousel--------------------------

              CarouselSlider.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index, int pageIndex) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Image.asset(
                      "assets/banners/banner1.jpg",
                      fit: BoxFit.fill,
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


              //-----------------------Item Category Grid-----------------------

              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TitleText(text: "Category:"),
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: categoryBoxList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    crossAxisCount: 5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return categoryBoxList[index];
                  }),

              //-----------------------List-View Item---------------------------

              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TitleText(
                  text: "Explore Products:",
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: productList.length,
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
                    child: ExploreProductBox(
                      category: productList[index]["category"],
                      title: productList[index]["title"],
                      price: productList[index]["price"],
                      imagePath: productList[index]["list_view_image_path"],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 3,
                  );
                },
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
