import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/database_helper/apis.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/widgets/explore_product_box_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final int totalOrders = 0;
  List productDoc = [];
  UserModel firestoreJsonParse(snapshot) {
    UserModel user = UserModel.fromJson(snapshot.data.docs[0]);
    return user;
  }

  fetchProducts()async {
    var result = await ProductServices().firestore.collection("products").get();
    result.docs.forEach((element) { 
      setState(() {
        productDoc.add(element.data());
      });
    });
    print(productDoc);


    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder(
          stream: FirestoreService()
              .firestore
              .collection("users")
              .where("id",
                  isEqualTo: AuthService().firebaseAuth.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              if(snapshot.data.docs.length > 0){
                return Center(
                  child: Column(
                    children: [
                    const CircleAvatar(),
                    Text("Username: ${firestoreJsonParse(snapshot).username}"),
                    Text("Name:${firestoreJsonParse(snapshot).name}"),
                    Text("Email:${firestoreJsonParse(snapshot).email}"),
                    Text("Location:${firestoreJsonParse(snapshot).location}"),
                    Text("Country:${firestoreJsonParse(snapshot).country}"),
                    Text("Account Created:${firestoreJsonParse(snapshot).dateCreated}"),
                    Text("Total Completed Orders: $totalOrders"),

                      ElevatedButton(onPressed: (){
                        AuthService().firebaseAuth.signOut();
                      }, child: Text("Logout")),
                      
                      Expanded(
                        child: ListView.builder(itemCount: productDoc.length,
                            itemBuilder: (context,index){
                          return ExploreProductBox(category: productDoc[index]["category"], title: productDoc[index]["title"], price: productDoc[index]["price"],imagePath: productDoc[index]["list_view_image_path"],);
                        }),
                      )



                  ],

                  ),
                );
              }
            }
            else{
              return Container();
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
