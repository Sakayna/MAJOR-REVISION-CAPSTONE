import 'package:capstone/navbar/Quiz.dart';
import 'package:capstone/navbar/Category.dart';
import 'package:capstone/navbar/CustomBottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:capstone/components/graph_card.dart';
import 'package:capstone/components/graph_details_screen.dart';

class RecordModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessment Tasks'),
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
              child: ListView.builder(
                itemCount: 8, // Updated to include 8 quizzes total
                itemBuilder: (context, index) {
                  final globalVariables =
                      Provider.of<GlobalVariables>(context, listen: false);

                  // Determine the lesson and quiz number based on index
                  String lessonQuizTitle;
                  String quizKey;
                  int lessonNumber;
                  int quizNumber;

                  if (index == 0) {
                    lessonQuizTitle = 'Lesson 1 Quiz 1';
                    quizKey = 'quiz1';
                    lessonNumber = 1;
                    quizNumber = 1;
                  } else if (index == 1) {
                    lessonQuizTitle = 'Lesson 1 Quiz 2';
                    quizKey = 'quiz2';
                    lessonNumber = 1;
                    quizNumber = 2;
                  } else if (index == 2) {
                    lessonQuizTitle = 'Lesson 2 Quiz 1';
                    quizKey = 'quiz3';
                    lessonNumber = 2;
                    quizNumber = 1;
                  } else if (index == 3) {
                    lessonQuizTitle = 'Lesson 3 Quiz 1';
                    quizKey = 'quiz4';
                    lessonNumber = 3;
                    quizNumber = 1;
                  } else if (index == 4) {
                    lessonQuizTitle = 'Lesson 3 Quiz 2';
                    quizKey = 'quiz5';
                    lessonNumber = 3;
                    quizNumber = 2;
                  } else if (index == 5) {
                    lessonQuizTitle = 'Lesson 4 Quiz 1';
                    quizKey = 'quiz6';
                    lessonNumber = 4;
                    quizNumber = 1;
                  } else if (index == 6) {
                    lessonQuizTitle = 'Lesson 5 Quiz 1';
                    quizKey = 'quiz7';
                    lessonNumber = 5;
                    quizNumber = 1;
                  } else {
                    lessonQuizTitle = 'Lesson 5 Quiz 2';
                    quizKey = 'quiz8';
                    lessonNumber = 5;
                    quizNumber = 2;
                  }

                  final itemCount = globalVariables.quizItemCount[quizKey] ?? 0;
                  final takeCount = globalVariables.quizTakeCount[quizKey] ?? 0;
                  final remarks = globalVariables.globalRemarks[quizKey] ?? [];
                  final scores = globalVariables.globalScores[quizKey] ?? [0];
                  final dateTaken =
                      globalVariables.quizTakenDates[quizKey] ?? [];

                  // Unlock quiz if there's already a take count
                  bool canTakeQuiz = globalVariables.getQuizTaken(
                      'lesson$lessonNumber', 'quiz$quizNumber');

                  // Automatically unlock the quiz if there's a take count
                  if (takeCount > 0) {
                    canTakeQuiz = true;
                    globalVariables.allowQuiz(
                        'lesson$lessonNumber', 'quiz$quizNumber');
                  }

                  return Column(
                    children: [
                      Opacity(
                        opacity: canTakeQuiz ? 1 : 0.5,
                        child: GestureDetector(
                          onTap: canTakeQuiz
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => GraphDetailScreen(
                                        title: lessonQuizTitle,
                                        itemCount: itemCount,
                                        takeCount: takeCount,
                                        remarks: remarks,
                                        scores: scores,
                                        dateTaken: dateTaken,
                                      ),
                                    ),
                                  );
                                }
                              : () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('No Record'),
                                      content: Text(
                                          'No record available for this quiz yet. Please complete the quiz first to generate a record.'),
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
                          child: Stack(
                            children: [
                              GraphCard(
                                title: lessonQuizTitle,
                                itemCount: itemCount,
                                takeCount: takeCount,
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
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
