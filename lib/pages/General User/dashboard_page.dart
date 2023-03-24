import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/controllers/product_controllers.dart';
import 'package:provider/provider.dart';
import 'pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with AutomaticKeepAliveClientMixin<DashboardPage> {
  int _pageIndex = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    ProductController productController =
        Provider.of<ProductController>(context, listen: false);
    productController.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ProductController>(builder: (_, controller, ___) {
      return Scaffold(
        key: _key,
        backgroundColor: Colors.white,
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
                      const Text(
                        "TechMart",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: [
                          InkWell(
                            child: const Icon(
                              CupertinoIcons.search,
                              size: 30,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SearchPage(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CartPage()));
                            },
                            child: const Icon(
                              CupertinoIcons.cart,
                              size: 30,
                            ),
                          ),
                        ],
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
                  itemBuilder:
                      (BuildContext context, int index, int pageIndex) {
                    return Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),

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

                const SizedBox(height: 14,),

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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: TitleText(text: "Category")),
                ),
                const SizedBox(height: 10,),
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: controller.categoryBoxList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1,
                      crossAxisCount: 5,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return controller.categoryBoxList[index];
                    }),

                //-----------------------List-View Item---------------------------

                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: TitleText(
                      text: "Explore Products",
                    ),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.productDoc.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductPage(controller.productDoc[index]),
                            ),
                          );
                        },
                        child: ExploreProductBox(
                          category: controller.productDoc[index]["category"],
                          title: controller.productDoc[index]["title"],
                          price: controller.productDoc[index]["price"],
                          imagePath: controller.productDoc[index]
                              ["list_view_image_path"],
                        ));
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
    });
  }

  @override
  bool get wantKeepAlive => true;
}
