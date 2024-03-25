import 'package:flutter/material.dart';
import 'image_input.dart';

class addReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 175, 210, 134),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 58, 132, 60),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 30.0),
                Text(
                  'new Report',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  enabled: false,
                  decoration:
                      InputDecoration(hintText: 'Report Type :', filled: true),
                ),
                SizedBox(
                  height: 20.2,
                ),
                TextField(
                  enabled: false,
                  decoration:
                      InputDecoration(hintText: 'Address :', filled: true),
                ),
                SizedBox(
                  height: 20.2,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  enabled: true,
                  decoration: InputDecoration(
                    hintText: 'description : ',
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 20.2,
                ),
                TextField(
                  keyboardType: TextInputType.datetime,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'date : ',
                    filled: true,
                  ),
                ),
                ImageInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
