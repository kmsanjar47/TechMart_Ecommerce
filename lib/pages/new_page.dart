import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> with AutomaticKeepAliveClientMixin<NewPage> {
  String? myText;

  @override
  void initState() {
    super.initState();
    myText = "ANJAR ${DateTime.now().microsecondsSinceEpoch}";
  }
  @override
  Widget build(BuildContext context) {super.build(context);
    return Scaffold(
      body: Center(

        child: Text(myText!),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
