import 'package:capstone/Module%20Contents/Heredity/Heredity_AT/Heredity_AT_5_1/results.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_AT/Heredity_AT_5_1/content.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_AT/Heredity_AT_5_1/item.dart';

import 'package:flutter/material.dart';
import 'package:capstone/categories/animal_and_plant_screen.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class Heredity_AT_Quiz_0_Score extends StatelessWidget {
  final List<QuizItem> quizItems;
  final Map<int, List<String>> userSelectedChoices;
  final int userScore;
  final int totalQuestions;

  Heredity_AT_Quiz_0_Score({
    required this.quizItems,
    required this.userSelectedChoices,
    required this.userScore,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final globalVariables =
          Provider.of<GlobalVariables>(context, listen: false);
      globalVariables.incrementQuizTakeCount('quiz7');
      globalVariables.setGlobalScore('quiz7', userScore);
      globalVariables.updateGlobalRemarks('quiz7', userScore, totalQuestions);
      globalVariables.setQuizItemCount('quiz7', totalQuestions);
      globalVariables.printGlobalVariables();
    });
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Animal_and_Plant_Screen(),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF64B6AC),
          toolbarHeight: 120.0,
          automaticallyImplyLeading: false,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              final isTop = constraints.biggest.height <= kToolbarHeight + 16.0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isTop) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, left: 50.0),
                      child: Text(
                        'Heredity Assessment Task',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'Quiz 5_1',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
          leading: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Animal_and_Plant_Screen(),
                ));
              },
            ),
          ),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
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
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                userScore >= 7 // Example passing score
                    ? Image.asset(
                        'assets/lesson1&2/congratulation.png',
                        width: 120,
                        height: 120,
                      )
                    : Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                        size: 120.0,
                      ),
                SizedBox(height: 20),
                Text(
                  'Your Score: $userScore / $totalQuestions',
                  style: TextStyle(
                    fontSize: 30,
                    color: userScore >= 7 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'You ${userScore >= 7 ? 'passed' : 'failed'} the quiz!',
                  style: TextStyle(
                    fontSize: 24,
                    color: userScore >= 7 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Heredity_AT_5_1_Results(
                          quizItems: quizItems,
                          userSelectedChoices: userSelectedChoices,
                          userScore: userScore,
                          totalQuestions: totalQuestions,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF64B6AC),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'View Results',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}