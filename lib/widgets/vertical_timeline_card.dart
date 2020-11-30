import 'package:flutter/material.dart';
import 'package:liga_stavok_flutterthon/constants.dart';

class VerticalTimelineCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Vertical Timeline'),
        trailing: IconButton(
          icon: Icon(
            Icons.not_started_outlined,
            color: colorGreen,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
