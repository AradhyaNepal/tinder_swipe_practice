import 'widgets/background_curve_widget.dart';
import 'widgets/cards_stack_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            BackgroudCurveWidget(),
            CardsStackWidget(),
          ],
        ),
      ),
    );
  }
}

enum Swipe { left, right, none }
