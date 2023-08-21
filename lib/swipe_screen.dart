import 'package:flutter/material.dart';

class Person {
  String name;
  List<String> images;

  Person({
    required this.name,
    required this.images,
  });
}

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  final personsList = [
    Person(
      name: "Dakota",
      images: [
        "dakota1.jpg",
        "dakota2.jpg",
        "dakota3.jpg",
      ],
    ),
    Person(
      name: "Selena",
      images: [
        "salena1.jpeg",
        "salena1.jpeg",
        "salena1.jpg",
      ],
    ),
    Person(
      name: "Arya",
      images: [
        "arya1.jpg"
            "arya1.jpeg"
      ],
    ),
    Person(
      name: "Hermione",
      images: [
        "hermione1.jpeg",
        "hermione2.jpeg",
        "hermione3.jpg",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 30,
              width: double.infinity,
              child: Placeholder(),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal:10,
                ),
                child: const Stack(
                  children: [
                    Positioned.fill(
                        child: SizedBox(
                            //Todo: Add image
                            )),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        //Todo: Add next image bar
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: SizedBox(
                        //Todo: Add Name
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
              width: double.infinity,
              child: Placeholder(),
            ),
          ],
        ),
      ),
    );
  }
}
