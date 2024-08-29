import 'package:capstone/Module%20Contents/Heredity/Heredity_AT/Heredity_AT_5_1/item.dart';

import 'package:capstone/Module%20Contents/Heredity/Heredity_AT/Heredity_AT_5_1/Heredity_AT_5_1.dart';
import 'package:flutter/material.dart';

class Heredity_AT_5_1_Results extends StatelessWidget {
  final List<QuizItem> quizItems;
  final Map<int, List<String>> userSelectedChoices;
  final int userScore;
  final int totalQuestions;

  Heredity_AT_5_1_Results({
    required this.quizItems,
    required this.userSelectedChoices,
    required this.userScore,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Heredity_AT_5_1(), // Redirect to Heredity_AT_5_1
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quiz Results'),
          backgroundColor: Color(0xFF64B6AC),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Overall Score: $userScore / $totalQuestions',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: totalQuestions,
                itemBuilder: (context, index) {
                  final userAnswers = userSelectedChoices[index];
                  final isCorrect = userAnswers != null &&
                      userAnswers.isNotEmpty &&
                      userAnswers.first == quizItems[index].correctAnswer;

                  final pointsText = isCorrect ? '1/1 point' : '0/1 point';
                  final selectedChoices = userAnswers ?? [];

                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey[200]!,
                        width: 1.0,
                      ),
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, right: 8.0),
                            child: Text(
                              pointsText,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Column(
                            children: [
                              Image(
                                  image:
                                      AssetImage(quizItems[index].imagePath)),
                              SizedBox(height: 10),
                              Text(
                                quizItems[index].question,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Choices:',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Column(
                                children:
                                    quizItems[index].choices.map((choice) {
                                  final isSelected = userAnswers != null &&
                                      userAnswers.contains(choice);
                                  final isWrong = isSelected && !isCorrect;
                                  final isUserSelected =
                                      selectedChoices.contains(choice);
                                  return ListTile(
                                    title: Text(choice),
                                    leading: Radio<String>(
                                      value: choice,
                                      groupValue: userAnswers != null &&
                                              userAnswers.isNotEmpty
                                          ? userAnswers.first
                                          : null,
                                      onChanged: (value) {},
                                    ),
                                    trailing: Text(
                                      isSelected
                                          ? isCorrect
                                              ? 'Correct'
                                              : 'Wrong'
                                          : isUserSelected
                                              ? 'Selected'
                                              : '',
                                      style: TextStyle(
                                        color: isSelected
                                            ? isCorrect
                                                ? Colors.green
                                                : Colors.red
                                            : isUserSelected
                                                ? Colors.blue
                                                : Colors.black,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              if (!isCorrect)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Correct Answer: ${quizItems[index].correctAnswer}',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF64B6AC),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Heredity_AT_5_1(), // Redirect to Heredity_AT_5_1
                      ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
