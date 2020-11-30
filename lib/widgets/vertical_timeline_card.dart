import 'package:flutter/material.dart';
import 'package:liga_stavok_flutterthon/constants.dart';

class VerticalTimelineCard extends StatelessWidget {
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
                icon: Icon(Icons.not_started_outlined, color: colorGreen, size: 22),
                onPressed: () {},
              ),
            ],
          ),
          Container(
            height: 0.5,
            width: double.infinity,
            color: colorGreenDark,
          ),
          Expanded(
            child: Center(),
          ),
        ],
      ),
    );
  }
}
