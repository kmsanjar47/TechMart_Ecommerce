import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/database_helper/apis.dart';
import 'package:e_commerce_app/pages/pages.dart';
import 'package:e_commerce_app/widgets/explore_product_box_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String myText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Card(
            child: TextField(
              decoration: const InputDecoration(
                  focusColor: Colors.black,
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search...."),
              onChanged: (val) {
                setState(() {
                  myText = val;
                });
              },
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          builder: (context, snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting)
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      if (data["title"]
                          .toString()
                          .toLowerCase()
                          .contains(myText.toLowerCase())) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(data)));
                          },
                          child: ExploreProductBox(
                            category: data["category"],
                            title: data["title"],
                            price: data["price"],
                            imagePath: data["list_view_image_path"],
                          ),
                        );
                      } else if (myText == "") {
                        return Container();
                      }
                    });
          },
          stream:
              FirestoreService().firestore.collection("products").snapshots(),
        ));
  }
}
