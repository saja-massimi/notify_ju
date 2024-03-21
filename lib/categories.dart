import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final List<String> image = [
    'images/fight.webp',
    'images/tree.png',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 175, 210, 134),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 58, 132, 60),
        ),
        body: ListView(
          children: [
            SizedBox(height: 30.0),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Choose a category',
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            GridView.count(
              crossAxisCount: 2, // Number of columns in the grid
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0, shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                image.length,
                (index) => Container(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: Image.asset(
                      image[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
