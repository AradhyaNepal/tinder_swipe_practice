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
            //Todo: Next image hidden under the hook
            Expanded(
              child: IndividualPerson(
                backgroundWidget: IndividualPerson(
                  nextPerson: null,
                  person: personsList.elementAtOrNull(_personIndex + 1),
                ),
                nextPerson: () {
                  _personIndex++;
                  setState(() {});
                },
                person: personsList.elementAtOrNull(_personIndex),
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
  final Person? person;

  ///Null means its itself BackgroundWidget
  final Widget? backgroundWidget;

  ///Null if its backgroundWidget
  final VoidCallback? nextPerson;

  const IndividualPerson({
    super.key,
    required this.person,
    required this.nextPerson,
    this.backgroundWidget,
  });

  @override
  State<IndividualPerson> createState() => _IndividualPersonState();
}

class _IndividualPersonState extends State<IndividualPerson> {
  int selectedIndex = 0;
  final PageController pageController = PageController();
  late Size size;
  Offset scrolledOffset = Offset.zero;

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
    final person = widget.person;
    if (person == null) {
      return const Center(
        child: Text(
          "No more girls found.\nTry again later.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            ignoring: true,
            child: widget.backgroundWidget ?? const SizedBox(),
          ),
        ),
        Positioned.fill(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(),
            child: Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()
                ..rotateZ(angleToRadian(getAngle()))
                ..translate(getXTranslate(), getYTranslate()),
              child: Stack(
                children: [
                  Listener(
                    onPointerMove: (details) {
                      scrolledOffset = Offset(
                        scrolledOffset.dx + details.delta.dx,
                        scrolledOffset.dy + details.delta.dy,
                      );
                      setState(() {});
                    },
                    onPointerUp: (details) {
                      if (scrolledOffset.dx.abs() > size.width * 0.25) {
                        widget.nextPerson?.call();
                      } else {
                        scrolledOffset = Offset.zero;
                        setState(() {});
                      }
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
                                "assets/${person.images[selectedIndex]}",
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
                                for (int i = 0; i < person.images.length; i++)
                                  Expanded(
                                    child: Container(
                                      margin: i == person.images.length - 1
                                          ? null
                                          : const EdgeInsets.only(right: 10),
                                      height: 5,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: selectedIndex == i
                                            ? Colors.white
                                            : Colors.grey,
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
                              person.name,
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
                                      if (selectedIndex ==
                                          person.images.length - 1) {
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
                  ),
                  if(scrolledOffset.dx>size.width*0.125)
                    Positioned(
                      top: 50,
                      left: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ),
                  if(scrolledOffset.dx<size.width*0.125)
                    Positioned(
                      top: 50,
                      right: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text(
                          "No",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  double getAngle() {
    final angle = scrolledOffset.dx * 0.5;
    if (angle > 180) return 180;
    if (angle < -180) return -180;
    return angle;
  }

  double getXTranslate() {
    return scrolledOffset.dx;
  }

  double getYTranslate() {
    return scrolledOffset.dy - scrolledOffset.dx.abs() * 2;
  }

  final double pi = 3.141592653589793238;

  double angleToRadian(double angle) {
    return angle * pi / 180;
  }
}
