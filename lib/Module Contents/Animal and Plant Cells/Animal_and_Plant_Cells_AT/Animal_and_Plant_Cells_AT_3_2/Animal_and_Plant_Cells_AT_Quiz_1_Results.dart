import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/Animal_and_Plant_Cells_AT_3_2/Animal_and_Plant_Cells_AT_Quiz_1_Score.dart';
import 'package:flutter/material.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/Animal_and_Plant_Cells_AT_3_2/Animal_and_Plant_Cells_AT_Quiz_1_Items.dart';

class Animal_and_Plant_AT_3_1_2_Results extends StatelessWidget {
  final List<QuizItem> quizItems;
  final Map<int, List<String>> userSelectedChoices;
  final int userScore;
  final int totalQuestions;

  Animal_and_Plant_AT_3_1_2_Results({
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
            builder: (context) => Animal_and_Plant_AT_3_1_2_Score(
              quizItems: quizItems,
              userSelectedChoices: userSelectedChoices,
              userScore: userScore,
              totalQuestions: totalQuestions,
            ),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quiz Results'),
          backgroundColor: Color(0xFFA1C084),
        ),
        body: Column(
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
            Expanded(
              child: ListView.builder(
                itemCount: totalQuestions +
                    1, // Adjusted to include the "Go Back" button
                itemBuilder: (context, index) {
                  if (index == totalQuestions) {
                    // "Go Back" button at the end
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Animal_and_Plant_AT_3_1_2_Score(
                                quizItems: quizItems,
                                userSelectedChoices: userSelectedChoices,
                                userScore: userScore,
                                totalQuestions: totalQuestions,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFA1C084),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Go Back',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

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
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, right: 8.0),
                            child: Text(pointsText),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            quizItems[index].question,
                            style: TextStyle(color: Colors.black),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Choices:',
                                style: TextStyle(color: Colors.black),
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
                                    style: TextStyle(color: Colors.red),
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
            ),
          ],
        ),
      ),
    );
  }
}
