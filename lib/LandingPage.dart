import 'package:Xchangez/CustomScaffold.dart';
import 'package:flutter/cupertino.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(Container(child: Text("Landing")));
  }
}
