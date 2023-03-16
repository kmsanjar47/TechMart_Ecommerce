import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/repository/auth_repository.dart';
import 'package:e_commerce_app/data/repository/user_repository.dart';
import 'package:flutter/material.dart';

import '../database_helper/apis.dart';
import '../widgets/big_text.dart';
import '../widgets/cart_item_box.dart';
class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  List? wishlistItems;
  fetchWishlistItems()async{
    try{
      CollectionReference userRef = UserRepository().getUserRepoRef();
      dynamic ref = await userRef
          .where("id",
          isEqualTo: AuthRepository().firebaseAuth.currentUser!.uid)
          .get();
    ref.docs.forEach((element) {
      setState(() {
        wishlistItems = element.data()["wishList"];
      });
    });
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),),);
    }

  }
  @override
  void initState() {
    super.initState();
    fetchWishlistItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BigText(text: "Wishlist",),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: wishlistItems != null && wishlistItems != []?ListView.builder(
          shrinkWrap: true,
          itemCount: wishlistItems?.length,
          itemBuilder: (BuildContext context, int index) {
            return CartItemBox(
              category: wishlistItems![index]["category"],
              title: wishlistItems![index]["title"],
              price: wishlistItems![index]["price"],
              imagePath: wishlistItems![index]["list_view_image_path"],
              dismissedFunction: (direction ) async{
                await FirestoreService().removeWishlistItem(context,index);
              },
              index: index,
            );
          }):Container(child: Center(child:Text("No item in wishlist"),),),
    );
  }
}