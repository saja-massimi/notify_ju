import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/profileController.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:notify_ju/Widgets/drawer.dart';

class EmojiFeedbackWidget extends StatefulWidget {
  final Function(int) onChanged;
  final int initialRating;

  const EmojiFeedbackWidget({
    Key? key,
    required this.onChanged,
    this.initialRating = 5,
  }) : super(key: key);

  @override
  _EmojiFeedbackWidgetState createState() => _EmojiFeedbackWidgetState();
}

class _EmojiFeedbackWidgetState extends State<EmojiFeedbackWidget> {
  late int _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final isSelected = index + 1 == _rating;
        final imagePaths = [
          'angry.png',
          'bad.png',
          'neutral.png',
          'good.png',
          'happy.png'
        ];
        return GestureDetector(
          onTap: () {
            setState(() {
              _rating = index + 1;
              widget.onChanged(_rating);
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'images/amanzimgs/${imagePaths[index]}',
              width: 49, // Adjust the size as needed
              height: 49,
              color: isSelected ? null : null,
            ),
          ),
        );
      }),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(ProfileController());
  int _userSatisfaction = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: Builder(
        builder: (context) => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF1b6770),
                Color(0xFF464A5E),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              FutureBuilder(
                future: controller.getUserName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 77.0),
                        child: Text(
                          'Welcome ${snapshot.data}!',
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 110.0),
                  child: Text(
                    'Your voice matters here.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 230, 230, 230),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: 160,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'How satisfied are you with JU services?\n',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          EmojiFeedbackWidget(
                            initialRating: _userSatisfaction,
                            onChanged: (rating) {
                              setState(() {
                                _userSatisfaction = rating;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          const Text(
                            '\nBe part of the solution! Report any campus issues and help us improve the environment.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
