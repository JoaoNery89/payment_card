import 'package:flutter/material.dart';
import 'myCard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cartão',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyCard(title: 'Cartões'),
      debugShowCheckedModeBanner: false,
    );
  }

}