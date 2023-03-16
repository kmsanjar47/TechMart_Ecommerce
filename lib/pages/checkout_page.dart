import 'package:e_commerce_app/database_helper/apis.dart';
import 'package:e_commerce_app/pages/order_completed_page.dart';
import 'package:e_commerce_app/widgets/user_profile_info_box.dart';
import 'package:flutter/material.dart';

import '../widgets/big_text.dart';
import '../widgets/medium_text.dart';
import '../widgets/title_text.dart';

class CheckOutPage extends StatefulWidget {
  double totalPrice;
  CheckOutPage(this.totalPrice, {Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}


class _CheckOutPageState extends State<CheckOutPage> {
  Map userInfo = {};
  String paymentGateway = "Home Delivery";
  Widget paymentTextGenerator(String paymentGateway){
    if(paymentGateway == "PayPal") {
      return Text("PayPal Currently Not Available",style: TextStyle(color: Colors.red),);
    }
    else if(paymentGateway == "Bank") {
      return Text("Bank Payment Currently Not Available",style: TextStyle(color: Colors.red),);
    }
    else {
      return Column(
        children: [
          Divider(),
          Text("Total Price: ${widget.totalPrice}"),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderCompletedPage(),),);

          },child: const Text("Procced Order"),),
        ],
      );
    }
  }
  
  fetchUserInfo(BuildContext context)async{
    try {
      dynamic ref = await FirestoreService().firestore
          .collection("users")
          .where("id", isEqualTo: AuthService().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        setState(() {
          userInfo = {"name":element.data()["name"],
            "username":element.data()["username"],
            "location":element.data()["location"],
            "country":element.data()["country"]};
        });
        });


    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserInfo(context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Checkout",style: TextStyle(color: Colors.black),),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleText(text: "User Credentials:"),
              ElevatedButton(onPressed: (){}, child: Text("Edit"))
            ],
          ),
          SizedBox(height: 8,),
          UserProfileInfoBox(info: "Name: ${userInfo["name"]}"),
            SizedBox(height: 8,),
          UserProfileInfoBox(info: "Location: ${userInfo["location"]}"),
            SizedBox(height: 8,),
          UserProfileInfoBox(info: "Country: ${userInfo["country"]}"),
            SizedBox(height: 15,),
            TitleText(text: "Payment Options:"),
            Column(
              children: [

                RadioListTile(
                  title: Row(
                    children: [
                      paymentGateway=="PayPal"?Icon(Icons.paypal,color: Colors.blue,):Icon(Icons.paypal),
                      SizedBox(width: 3,),
                      BigText(text:"PayPal"),
                    ],
                  ),
                  value: "PayPal",
                  groupValue: paymentGateway,
                  onChanged: (value){
                    setState(() {
                      paymentGateway = value.toString();
                    });
                  },
                ),

                RadioListTile(
                  title: Row(
                    children: [
                      paymentGateway=="Bank"?Icon(Icons.payment,color: Colors.blue,):Icon(Icons.payment),
                      SizedBox(width: 3,),
                      BigText(text:"Bank"),
                    ],
                  ),
                  value: "Bank",
                  groupValue: paymentGateway,
                  onChanged: (value){
                    setState(() {
                      paymentGateway = value.toString();
                    });
                  },
                ),

                RadioListTile(
                  title: Row(
                    children: [
                      paymentGateway=="Home Delivery"?Icon(Icons.home,color: Colors.blue,):Icon(Icons.home),
                      SizedBox(width: 3,),
                      BigText(text:"Home Delivery"),
                    ],
                  ),
                  value: "Home Delivery",
                  groupValue: paymentGateway,
                  onChanged: (value){
                    setState(() {
                      paymentGateway = value.toString();
                    });
                  },
                ),
                paymentTextGenerator(paymentGateway),
              ],
            )

    ],)
      ),
    );
  }
}
