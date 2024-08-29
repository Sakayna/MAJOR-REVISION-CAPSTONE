import 'package:capstone/navbar/Quiz.dart';
import 'package:capstone/navbar/Category.dart';
import 'package:capstone/navbar/CustomBottomNavigationBar.dart';
import 'package:capstone/Record%20Module/AT/Lesson_Record_AT.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:capstone/components/graph_card.dart';
import 'package:capstone/components/graph_details_screen.dart';

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
              child: Consumer<GlobalVariables>(
                builder: (context, globalVariables, child) {
                  final canTakeQuiz = globalVariables.getQuizTaken('lesson1',
                      'quiz1'); // Add the appropriate second argument

                  return Column(
                    children: [
                      Opacity(
                        opacity: canTakeQuiz ? 1 : 0.5,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RecordModule(),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              GraphCard(
                                title: 'Assessment Task',
                                itemCount: 0, // Removed display
                                takeCount: 0, // Removed display
                              ),
                              if (!canTakeQuiz)
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.lock,
                                        color: Colors.white, size: 50.0),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3, // Set the current index according to your needs
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
            case 2:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const QuizScreen()),
              );
              break;
            case 3:
              // Record Module (Already on the Record Module screen)
              break;
          }
        },
      ),
    );
  }
}
