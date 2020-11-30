import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:liga_stavok_flutterthon/api_client/sportradar_api_client.dart';
import 'package:liga_stavok_flutterthon/blocs/head_to_head_bloc.dart';
import 'package:liga_stavok_flutterthon/head_to_head_bloc_observer.dart';
import 'package:liga_stavok_flutterthon/constants.dart';
import 'package:liga_stavok_flutterthon/widgets/head_to_head_card.dart';
import 'package:liga_stavok_flutterthon/widgets/vertical_timeline_card.dart';

void main() {
  Bloc.observer = HeadToHeadBlocObserver();
  final SportRadarApiClient sportRadarApiClient = SportRadarApiClient(
    httpClient: http.Client(),
  );
  runApp(App(sportRadarApiClient: sportRadarApiClient));
}

class App extends StatelessWidget {
  final SportRadarApiClient sportRadarApiClient;
  App({@required this.sportRadarApiClient});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liga Stavok Flutterthone',
      theme: ThemeData(
        fontFamily: 'SFProDisplay',
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => HeadToHeadBloc(sportRadarApiClient: sportRadarApiClient),
        child: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentWidgetIndex = 0;

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
                _currentWidgetIndex = index;
              }),
            ),
            items: [
              HeadToHeadCard(),
              VerticalTimelineCard(),
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
                    color: _currentWidgetIndex == 0 ? colorGreen12 : colorGreen60),
              ),
              Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentWidgetIndex == 1 ? colorGreen12 : colorGreen60),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
