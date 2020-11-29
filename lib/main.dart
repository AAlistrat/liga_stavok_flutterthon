import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liga Stavok Flutterthone',
      theme: ThemeData(
        fontFamily: 'SFProDisplay',
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: colorGreen,
          title: RichText(
            text: TextSpan(
              text: 'Liga Stavok ',
              style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: colorWhite),
              children: [
                TextSpan(
                  text: 'Flutterthone',
                  style: TextStyle(color: colorYellow),
                ),
              ],
            ),
          )),
      backgroundColor: colorWhiteBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8, top: 8),
            child: Text(
              'СТАТИСТИКА СОБЫТИЙ:',
              style:
                  TextStyle(color: colorGreenDark, fontWeight: FontWeight.w500),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: false,
              viewportFraction: 0.95,
              enlargeCenterPage: true,
              height: MediaQuery.of(context).size.height * 0.4,
              onPageChanged: (index, reason) => setState(() {
                _current = index;
              }),
            ),
            items: [
              Card(
                child: ListTile(
                  title: Text('Head to Head'),
                  trailing: TextButton(
                    child: Text(
                      'ОБНОВИТЬ',
                      style: TextStyle(color: colorGreen),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Vertical Timeline'),
                  trailing: TextButton(
                    child: Text(
                      'НАЧАТЬ\nТРАНСЛЯЦИЮ',
                      style: TextStyle(color: colorGreen),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == 0 ? colorGreen12 : colorGreen60),
              ),
              Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == 1 ? colorGreen12 : colorGreen60),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
