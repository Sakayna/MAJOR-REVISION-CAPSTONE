import 'package:capstone/Module%20Contents/Microscopy/Microscopy_AT/Microscopy_AT_1_3/Microscopy_AT_1_3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class Microscopy_AT_Quiz_1_Results extends StatelessWidget {
  final List<String> questions;
  final List<String> userAnswers;
  final List<String> correctAnswers;

  const Microscopy_AT_Quiz_1_Results({
    Key? key,
    required this.questions,
    required this.userAnswers,
    required this.correctAnswers,
  }) : super(key: key);

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < userAnswers.length; i++) {
      if (userAnswers[i] == correctAnswers[i]) {
        score++;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    int correctAnswersCount = calculateScore();
    int totalQuestions = questions.length;

    // Update global variables with the results
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final globalVariables =
          Provider.of<GlobalVariables>(context, listen: false);
      globalVariables.setGlobalScore('quiz2', correctAnswersCount);
      globalVariables.setQuizItemCount('quiz2', totalQuestions);
      globalVariables.updateGlobalRemarks(
          'quiz2', correctAnswersCount, totalQuestions);
      globalVariables.incrementQuizTakeCount('quiz2');
      globalVariables.printGlobalVariables(); // Optional: for debugging
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Microscopy_AT_1_3(), // Replace with actual route to Microscopy_AT_1_3 screen
              ),
            );
          },
        ),
        title: Text('Quiz Results'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  bool isCorrect = userAnswers[index] == correctAnswers[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    padding: const EdgeInsets.all(16.0),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          questions[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Your Answer: ${userAnswers[index]}',
                          style: TextStyle(
                            color: isCorrect ? Colors.green : Colors.red,
                          ),
                        ),
                        if (!isCorrect)
                          Text(
                            'Correct Answer: ${correctAnswers[index]}',
                            style: TextStyle(color: Colors.green),
                          ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFA551),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Go back to the previous screen
                      },
                      child: Text(
                        'Go back',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
