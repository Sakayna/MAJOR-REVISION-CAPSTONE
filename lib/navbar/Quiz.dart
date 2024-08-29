import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/Animal_and_Plant_Cells_AT_3_2/Animal_and_Plant_Cells_AT_3_2.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_2/Ecosystem_AT_6_2.dart';
import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_AT/Bactera_AT_4_2/Bacteria_AT_4_2.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_AT/Heredity_AT_5_2/Heredity_AT_5_2.dart';
import 'package:capstone/Module%20Contents/Levels%20of%20Biological%20Organization/Levels_of_Biological_Organization_AT/Levels_of_Biological_Organization_AT_2_2/Levels_of_Biological_Organization_AT_2_2.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_AT/Microscopy_AT_1_3/Microscopy_AT_1_3.dart';
import 'package:capstone/Record%20Module/RecordModule_Main.dart';
import 'package:flutter/material.dart';
import 'package:capstone/navbar/Category.dart';
import 'package:capstone/navbar/CustomBottomNavigationBar.dart';
import 'package:capstone/Record%20Module/AT/Lesson_Record_AT.dart';

import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.0), // Added top padding
              RectangleBox(
                longText: 'Microscopy',
                lessonText: 'Lesson 1',
                color: Color(0xFFFFA551),
                lessonId: 0,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Microscopy_AT_1_3()),
                  );
                },
              ),
              SizedBox(height: 2.0), // Reduced space between rectangles
              RectangleBox(
                longText: 'Levels of Biological Organization',
                lessonText: 'Lesson 2',
                color: Color(0xFF9463FF),
                lessonId: 1,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Biological_Organization_AT_2_2()),
                  );
                },
              ),
              SizedBox(height: 2.0), // Reduced space between rectangles
              RectangleBox(
                longText: 'Animal and Plant Cells',
                lessonText: 'Lesson 3',
                color: Color(0xFFA1C084),
                lessonId: 2,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Animal_and_Plant_AT_3_2()),
                  );
                },
              ),
              SizedBox(height: 2.0), // Reduced space between rectangles
              RectangleBox(
                longText: 'Funji, Protists, and Bacteria',
                lessonText: 'Lesson 4',
                color: Color(0xFFFF6A6A),
                lessonId: 3,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Bacteria_AT_4_2()),
                  );
                },
              ),
              SizedBox(height: 2.0), // Reduced space between rectangles
              RectangleBox(
                longText: 'Heredity: Inheritance and Variation',
                lessonText: 'Lesson 5',
                color: Color(0xFF64B6AC),
                lessonId: 4,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Heredity_AT_5_2()),
                  );
                },
              ),
              SizedBox(height: 2.0), // Reduced space between rectangles
              RectangleBox(
                longText: 'Ecosystem',
                lessonText: 'Lesson 6',
                color: Color(0xFFA846A0),
                lessonId: 5,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Ecosystem_AT_6_2()),
                  );
                },
              ),
              SizedBox(height: 16.0), // Added bottom padding
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2, // Set the current index according to your needs
        onNavItemTap: (index) {
          // Handle navigation based on the index of the tapped item
          switch (index) {
            case 0:
              // Home
              Navigator.of(context).popUntil((route) => route.isFirst);
              break;
            case 1:
              // Categories
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const CategoryScreen()),
              );
              break;
            case 3:
              // Record Module
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => RecordModuleLesson1()),
              );
              break;
          }
        },
      ),
    );
  }
}

class RectangleBox extends StatelessWidget {
  final String longText;
  final String lessonText;
  final Color color;
  final VoidCallback onTap;
  final int lessonId;

  RectangleBox({
    required this.longText,
    required this.lessonText,
    required this.color,
    required this.onTap,
    required this.lessonId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalVariables>(
      builder: (context, globalVariables, child) {
        bool canTakeQuiz = globalVariables.canTakeQuiz('lesson${lessonId + 1}',
            'quizId'); // Replace 'quizId' with the actual quiz ID
        return GestureDetector(
          onTap: canTakeQuiz
              ? onTap
              : () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Lesson not completed'),
                      content: Text(
                          'Please complete the current lesson first before taking the quiz.'),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
          child: Opacity(
            opacity: canTakeQuiz ? 1 : 0.5,
            child: Container(
              height: 100,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Stack(
                children: [
                  // Outer White Background
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.01),
                            spreadRadius: 0.01,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Inner Square
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                  // Text 1 (Long Text)
                  Positioned(
                    left: 100,
                    top: 15,
                    child: Container(
                      width: 200,
                      child: Text(
                        longText,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  // Text 2 (Lesson Text)
                  Positioned(
                    left: 100,
                    top: 50,
                    child: Container(
                      width: 200,
                      child: Text(
                        lessonText,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF00B4D8),
                        ),
                      ),
                    ),
                  ),
                  if (!canTakeQuiz)
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Icon(Icons.lock, color: Colors.grey),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
