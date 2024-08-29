import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1_2/results.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class Ecosystem_AT_Quiz_1_Score extends StatelessWidget {
  final int score;
  final List<Map<String, String>> questions;
  final List<String?> selectedPredators;
  final List<String?> selectedPreys;

  Ecosystem_AT_Quiz_1_Score({
    required this.score,
    required this.questions,
    required this.selectedPredators,
    required this.selectedPreys,
  });

  @override
  Widget build(BuildContext context) {
    bool passed = score >= 7; // Example passing criteria

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final globalVariables =
          Provider.of<GlobalVariables>(context, listen: false);
      globalVariables.incrementQuizTakeCount('quiz10');
      globalVariables.setGlobalScore('quiz10', score);
      globalVariables.updateGlobalRemarks('quiz10', score, questions.length);
      globalVariables.setQuizItemCount('quiz10', questions.length);
      globalVariables.printGlobalVariables();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA846A0),
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
                      'Ecosystem',
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
                      'Assessment Task',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 18.0),
                    child: Text(
                      'AT 6.1.2',
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
              Navigator.of(context).pop(); // Go back to the previous screen
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
              passed
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
                'Your Score: $score / ${questions.length}',
                style: TextStyle(
                  fontSize: 30,
                  color: passed ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'You ${passed ? 'passed' : 'failed'} the quiz!',
                style: TextStyle(
                  fontSize: 24,
                  color: passed ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Ecosystem_AT_Quiz_1_Results(
                        questions: questions,
                        selectedPredators: selectedPredators,
                        selectedPreys: selectedPreys,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA846A0),
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
    );
  }
}
