import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1_3/Ecosystem_AT_6_1_3.dart';
import 'package:flutter/material.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1/Ecosystem_AT_6_1.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1/item.dart';

class Ecosystem_AT_Quiz_2_Results extends StatelessWidget {
  final List<QuizItem> quizItems;
  final Map<int, List<String>> userSelectedChoices;
  final int userScore;
  final int totalQuestions;

  Ecosystem_AT_Quiz_2_Results({
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
            builder: (context) => Ecosystem_AT_6_1(),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quiz Results'),
          backgroundColor: Color(0xFFA846A0),
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
                          title: Text(
                            quizItems[index].question,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image(
                                  image:
                                      AssetImage(quizItems[index].imagePath)),
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
                                          : '',
                                      style: TextStyle(
                                        color: isSelected
                                            ? isCorrect
                                                ? Colors.green
                                                : Colors.red
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
                  color: Color(0xFFA846A0),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Ecosystem_AT_6_1_3(),
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
