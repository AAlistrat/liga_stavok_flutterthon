import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:liga_stavok_flutterthon/constants.dart';


class VerticalTimelineCard extends StatefulWidget {
  @override
  _VerticalTimelineCardState createState() => _VerticalTimelineCardState();
}

class _VerticalTimelineCardState extends State<VerticalTimelineCard> with TickerProviderStateMixin {
  GifController gifController;
  IconData playIcon;

  @override
  void initState() {
    playIcon = Icons.not_started_outlined;
    gifController = GifController(vsync: this);
    gifController.stop();
    super.initState();
  }

  @override
  void dispose() {
    gifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Vertical Timeline',
                  style: cardTitleTextStyle,
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: Icon(playIcon, color: colorGreen, size: 24),
                onPressed: () => setState(() {
                  if (playIcon == Icons.not_started_outlined) {
                    gifController.repeat(
                      min: 0,
                        max: 7,
                        period: Duration(milliseconds: 400),
                    );
                    playIcon = Icons.stop_circle_outlined;
                  } else {
                    gifController.stop();
                    playIcon = Icons.not_started_outlined;
                  }
                }),
              ),
            ],
          ),
          Container(
            height: 0.5,
            width: double.infinity,
            color: colorGreenDark,
          ),
          Expanded(
            child: Center(
              child: GifImage(
                controller: gifController,
                  image: AssetImage('assets/images/puggy.gif'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
