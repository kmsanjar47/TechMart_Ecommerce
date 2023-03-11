import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with AutomaticKeepAliveClientMixin<SearchPage> {
  String? myText;

  @override
  void initState() {
    super.initState();
    myText = "Search ${DateTime.now().microsecondsSinceEpoch}";
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
