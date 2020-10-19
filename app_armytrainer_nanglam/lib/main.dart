import 'package:app_armytrainer_nanglam/pushTab.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pushTab.dart';
import 'sitTab.dart';
import 'profileTab.dart';

void main() => runApp(
      MaterialApp(
        title: 'MyApp',
        home: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> with TickerProviderStateMixin {
  TabController _tabController;
  double _sizeHeight;
  double _sizeWidth;
  double _deviceRatio;
  double _paddingTop;
  var _nothing;

  List<Widget> list = [
    Tab(
        child: Text(
      'Push-Up',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'MainFont',
        fontSize: 24,
      ),
    )),
    Tab(
        child: Text(
      'Sit-Up',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'MainFont',
        fontSize: 24,
      ),
    ))
  ];

  _loadValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bool key = (prefs.getBool('key') ?? false);
      if (key != true) {}
      prefs.setBool('key', true);
    });
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: list.length);
    _loadValue();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _sizeHeight = MediaQuery.of(context).size.height;
    _sizeWidth = MediaQuery.of(context).size.width;
    _deviceRatio = MediaQuery.of(context).devicePixelRatio;
    _paddingTop = MediaQuery.of(context).padding.top;
    _sizeHeight -= _paddingTop;
    return Scaffold(
      backgroundColor: Color(0xff191C2B),
      appBar: null,
      body: SizedBox(
        height: _sizeHeight * _deviceRatio,
        width: _sizeWidth * _deviceRatio,
        child: Column(children: [
          SizedBox(height: _paddingTop + 5),
          Row(
            children: [
              SizedBox(
                width: 40,
                height: 48,
              ),
              IconButton(
                icon: Icon(
                  Icons.bar_chart,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileApp(),
                      )).then((value) => setState(() {
                        _nothing = value;
                      }));
                },
              ),
              Expanded(
                flex: 1,
                child: SizedBox(height: 48),
              ),
              SizedBox(
                width: 235,
                height: 35,
                child: TabBar(
                  tabs: list,
                  controller: _tabController,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 4, color: Color(0xffE32A51)),
                    insets: EdgeInsets.symmetric(horizontal: 35.0),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
                height: 48,
              ),
            ],
          ),
          SizedBox(height: _sizeHeight * 0.045),
          SizedBox(
            width: _sizeWidth * _deviceRatio,
            height: _sizeHeight * 0.819,
            child: TabBarView(
              controller: _tabController,
              children: [
                PushTab(),
                SitTab(),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
