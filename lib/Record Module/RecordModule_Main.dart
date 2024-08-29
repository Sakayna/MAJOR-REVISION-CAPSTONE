import 'package:capstone/Record%20Module/AT/leson%206.dart';
import 'package:capstone/Record%20Module/AT/lesson1.dart';
import 'package:capstone/Record%20Module/AT/lesson2.dart';
import 'package:capstone/Record%20Module/AT/lesson3.dart';
import 'package:capstone/Record%20Module/AT/lesson4.dart';
import 'package:capstone/Record%20Module/AT/lesson5.dart';
import 'package:flutter/material.dart';
import 'package:capstone/navbar/Quiz.dart';
import 'package:capstone/navbar/Category.dart';
import 'package:capstone/navbar/CustomBottomNavigationBar.dart';

class RecordModuleLesson1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Module'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progress & Graphs',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildLessonCard(
                    context,
                    'Lesson 1 Quizzes',
                    LessonRecordAT1(),
                  ),
                  _buildLessonCard(
                    context,
                    'Lesson 2 Quizzes',
                    LessonRecordAT2(),
                  ),
                  _buildLessonCard(
                    context,
                    'Lesson 3 Quizzes',
                    LessonRecordAT3(),
                  ),
                  _buildLessonCard(
                    context,
                    'Lesson 4 Quizzes',
                    LessonRecordAT4(),
                  ),
                  _buildLessonCard(
                    context,
                    'Lesson 5 Quizzes',
                    LessonRecordAT5(),
                  ),
                  _buildLessonCard(
                    context,
                    'Lesson 6 Quizzes',
                    LessonRecordAT6(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
        onNavItemTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).popUntil((route) => route.isFirst);
              break;
            case 1:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const CategoryScreen()),
              );
              break;
            case 2:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const QuizScreen()),
              );
              break;
            case 3:
              break; // Already on the Record Module screen
          }
        },
      ),
    );
  }

  Widget _buildLessonCard(
      BuildContext context, String title, Widget destination) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => destination),
          );
        },
      ),
    );
  }
}
