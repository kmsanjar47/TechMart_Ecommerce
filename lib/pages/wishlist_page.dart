import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controllers.dart';
import '../widgets/big_text.dart';
import '../widgets/cart_item_box.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {

  @override
  void initState() {
    super.initState();
    ProductController productController = Provider.of<ProductController>(context,listen:false);
    productController.fetchWishlistItems(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(
      builder: (_,controller,___) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BigText(
              text: "Wishlist",
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
          ),
          body: controller.wishlistItems != null && controller.wishlistItems != []
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.wishlistItems?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CartItemBox(
                      category: controller.wishlistItems![index]["category"],
                      title: controller.wishlistItems![index]["title"],
                      price: controller.wishlistItems![index]["price"],
                      imagePath: controller.wishlistItems![index]["list_view_image_path"],
                      dismissedFunction: (direction) async {
                        await ProductController()
                            .removeWishlistItem(context, index);
                      },
                      index: index,
                    );
                  })
              : Container(
                  child: Center(
                    child: Text("No item in wishlist"),
                  ),
                ),
        );
      }
    );
  }
}
