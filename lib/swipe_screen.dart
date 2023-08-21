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
  var _personIndex = 0;
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
        "salena2.jpeg",
        "salena3.jpg",
      ],
    ),
    Person(
      name: "Arya",
      images: [
        "arya1.jpg",
        "arya2.jpeg",
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
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.green.withOpacity(0.5),
            ),
            Expanded(
              child: _personIndex > personsList.length - 1
                  ? const Center(
                      child: Text(
                        "No more girls found.\nTry again later.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : IndividualPerson(
                      nextPerson: () {
                        _personIndex++;
                        setState(() {});
                      },
                      person: personsList[_personIndex],
                    ),
            ),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.red.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}

class IndividualPerson extends StatefulWidget {
  final Person person;
  final VoidCallback nextPerson;

  const IndividualPerson({
    super.key,
    required this.person,
    required this.nextPerson,
  });

  @override
  State<IndividualPerson> createState() => _IndividualPersonState();
}

class _IndividualPersonState extends State<IndividualPerson> {
  int selectedIndex = 0;
  final PageController pageController = PageController();
  late Size size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (details) {
        if (details.delta.dx > 0) {
          print("Right${details.delta.dx}");
        }
        if (details.delta.dx < 0) {
          print("Left${details.delta.dx}");
        }
      },
      onPointerUp: (details) {
        print("Cancel");
      },
      child: Container(
        width: size.width,
        margin: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/${widget.person.images[selectedIndex]}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 15,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  for (int i = 0; i < widget.person.images.length; i++)
                    Expanded(
                      child: Container(
                        margin: i == widget.person.images.length - 1
                            ? null
                            : const EdgeInsets.only(right: 10),
                        height: 5,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              selectedIndex == i ? Colors.white : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              left: 10,
              child: Text(
                widget.person.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned.fill(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (selectedIndex == 0) return;
                        selectedIndex--;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (selectedIndex == widget.person.images.length - 1) {
                          return;
                        }
                        selectedIndex++;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
