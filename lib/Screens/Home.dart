import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/profileController.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:notify_ju/Widgets/drawer.dart';
import 'package:notify_ju/Screens/categories.dart';
import 'package:notify_ju/Screens/PagesVote/pageVote.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? 55 : 44,
              height: isSelected ? 55 : 44,
              child: Image.asset(
                'images/amanzimgs/${imagePaths[index]}',
              ),
            ),
          ),
        );
      }),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(ProfileController());
  int _userSatisfaction = 5;
  final PageController _pageController = PageController();

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
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 85.0),
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
                  padding: EdgeInsets.only(top: 118.0),
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
                top: 180,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 240, 240, 240),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            '\nHow satisfied are you with JU services?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        EmojiFeedbackWidget(
                          initialRating: _userSatisfaction,
                          onChanged: (rating) {
                            setState(() {
                              _userSatisfaction = rating;
                            });
                          },
                        ),
                        const SizedBox(height: 40),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Material(
                                  elevation: 8,
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: PageView(
                                    controller: _pageController,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.0),
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(25.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Be part of the solution! Report any campus issues and help us improve the environment.',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 35, 33, 42),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Categories(),
                                                      ),
                                                    );
                                                  },
                                                  child:
                                                      const Text('Report Now'),
                                                ),
                                                const SizedBox(width: 8),
                                                Image.asset(
                                                  'images/amanzimgs/idea.gif',
                                                  width: 105,
                                                  height: 105,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.0),
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(25.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Speak up! Your input can drive the positive changes you want to see on campus.',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 37, 33, 50),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const VotingPage1(),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text('Post Now'),
                                                ),
                                                const SizedBox(width: 8),
                                                Image.asset(
                                                  'images/amanzimgs/rate.gif',
                                                  width: 105,
                                                  height: 105,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SmoothPageIndicator(
                                controller: _pageController,
                                count: 2,
                                effect: const WormEffect(
                                  dotHeight: 8,
                                  dotWidth: 8,
                                  spacing: 16,
                                  dotColor: Colors.grey,
                                  activeDotColor:
                                      Color.fromARGB(255, 227, 200, 226),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
