import "package:e_commerce_app/pages/Publisher/publisher_add_banner.dart";
import "package:e_commerce_app/pages/Publisher/publisher_add_product.dart";
import "package:e_commerce_app/widgets/medium_text.dart";
import "package:e_commerce_app/widgets/neuphormic_button.dart";
import "package:e_commerce_app/widgets/title_text.dart";
import "package:flutter/material.dart";

class PublisherDashboard extends StatelessWidget {
  const PublisherDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "TechMart",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const TitleText(text: "Welcome"),
            NeuphormicButton(
              onTap: () {
                // showDialog(
                //     context: context,
                //     builder: (context) => AlertDialog(
                //
                //           content: Column(
                //             children: [
                //               NeuphormicButton(
                //                 width: 100,
                //                 height: 50,
                //                 onTap: () {},
                //                 color: Colors.grey.shade200,
                //                 centerWidget: const MediumText(
                //                   text: "ADD PRODUCT",
                //                 ),
                //               ),
                //               NeuphormicButton(
                //                 width: 100,
                //                 height: 50,
                //                 onTap: () {},
                //                 color: Colors.grey.shade200,
                //                 centerWidget: const MediumText(
                //                   text: "ADD BANNER",
                //                 ),
                //               )
                //             ],
                //           ),
                //         ));
                showDialog(
                    builder: (context) => Dialog(
                          backgroundColor: Colors.transparent,
                          insetPadding: const EdgeInsets.all(10),
                          child: Container(
                            width: double.infinity,
                            height: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NeuphormicButton(
                                    width: 300,
                                    height: 50,
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PublisherAddProduct()));
                                    },
                                    widgetColor: Colors.grey.shade200,
                                    centerWidget: const Center(
                                      child: MediumText(
                                        text: "ADD PRODUCT",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  NeuphormicButton(
                                    width: 300,
                                    height: 50,
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PublisherAddBanner()));
                                    },
                                    widgetColor: Colors.grey.shade200,
                                    centerWidget: const Center(
                                      child: MediumText(
                                        text: "ADD BANNER",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    context: context);
              },
              widgetColor: Colors.grey.shade100,
              centerWidget: const Icon(Icons.add, color: Colors.black),
              height: 100,
              width: 200,
            ),
            TitleText(text: "Recently Added")
          ],
        ),
      ),
    );
  }
}
