import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.camera),
                label: Text('camera'),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.camera),
                label: Text('camera'),
              ),
            ],
          )
        ],
      )),
    );
  }
}
