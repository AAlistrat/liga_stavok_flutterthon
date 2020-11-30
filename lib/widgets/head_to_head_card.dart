import 'package:flutter/material.dart';
import 'package:liga_stavok_flutterthon/constants.dart';

class HeadToHeadCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
          child: ListTile(
            title: Text('Head to Head'),
            trailing: IconButton(
                icon: Icon(Icons.refresh, color: colorGreen),
                onPressed: () {},
            ),
            subtitle: Column(
              children: [],
            ),
          ),
    );
  }
}
