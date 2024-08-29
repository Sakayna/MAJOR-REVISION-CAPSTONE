import 'package:capstone/Module%20Contents/Levels%20of%20Biological%20Organization/Levels_of_Biological_Organization_AT/Levels_of_Biological_Organization_AT_2_2/Levels_of_Biological_Organization_AT_2_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class ResultsPage extends StatelessWidget {
  final List<String> questions;
  final List<String> userAnswers;
  final List<String> correctAnswers;

  const ResultsPage({
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
      globalVariables.setGlobalScore('quiz3', correctAnswersCount);
      globalVariables.setQuizItemCount('quiz3', totalQuestions);
      globalVariables.updateGlobalRemarks(
          'quiz3', correctAnswersCount, totalQuestions);
      globalVariables.incrementQuizTakeCount('quiz3');
      globalVariables.printGlobalVariables(); // Optional: for debugging
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9463FF),
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
                      'Levels of Biological Organization',
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
                      'Quiz Results',
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
                      'AT 2.1',
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
                      color: Color(0xFF9463FF),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Biological_Organization_AT_2_2()),
                        );
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
