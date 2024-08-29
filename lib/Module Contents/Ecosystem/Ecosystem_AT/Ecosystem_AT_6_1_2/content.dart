import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1_2/score.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_2/Ecosystem_AT_Quiz_1_Score.dart';
import 'package:capstone/helpers/fisher_yates.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class QuizItem {
  final String question;
  final List<String> choices;
  final String correctAnswer;

  QuizItem({
    required this.question,
    required this.choices,
    required this.correctAnswer,
  });
}

class Ecosystem_AT_Quiz_1_Content extends StatefulWidget {
  @override
  _Ecosystem_AT_Quiz_1_ContentState createState() =>
      _Ecosystem_AT_Quiz_1_ContentState();
}

class _Ecosystem_AT_Quiz_1_ContentState
    extends State<Ecosystem_AT_Quiz_1_Content> {
  final List<QuizItem> quizItems = [
    QuizItem(
      question:
          'What is the main difference between sexual and asexual reproduction?',
      choices: [
        'Sexual reproduction involves one parent, while asexual reproduction involves two parents.',
        'Sexual reproduction involves two parents, while asexual reproduction involves one parent.',
        'Sexual reproduction produces genetically identical offspring, while asexual reproduction produces genetically diverse offspring.',
        'Sexual reproduction occurs only in animals, while asexual reproduction occurs only in plants.'
      ],
      correctAnswer:
          'Sexual reproduction involves two parents, while asexual reproduction involves one parent.',
    ),
    QuizItem(
      question: 'What process results in the formation of gametes?',
      choices: ['Mitosis', 'Meiosis', 'Binary fission', 'Budding'],
      correctAnswer: 'Meiosis',
    ),
    QuizItem(
      question: 'Where does spermatogenesis occur in males?',
      choices: ['Ovaries', 'Testes', 'Epididymis', 'Prostate gland'],
      correctAnswer: 'Testes',
    ),
    QuizItem(
      question: 'What is the outcome of fertilization?',
      choices: [
        'A haploid gamete',
        'A diploid zygote',
        'Two identical daughter cells',
        'A multicellular organism'
      ],
      correctAnswer: 'A diploid zygote',
    ),
    QuizItem(
      question: 'Which organisms are known to exhibit external fertilization?',
      choices: ['Humans', 'Birds', 'Frogs', 'Mammals'],
      correctAnswer: 'Frogs',
    ),
    QuizItem(
      question: 'Which structure is involved in bacterial conjugation?',
      choices: ['Flagellum', 'Pilus', 'Cilia', 'Capsule'],
      correctAnswer: 'Pilus',
    ),
    QuizItem(
      question: 'What advantage does internal fertilization offer?',
      choices: [
        'Production of more offspring',
        'Increased survival of the zygote',
        'Exposure to environmental hazards',
        'Requirement of a moist environment'
      ],
      correctAnswer: 'Increased survival of the zygote',
    ),
    QuizItem(
      question:
          'What is the term for the exchange of genetic material between two bacteria?',
      choices: ['Mitosis', 'Transformation', 'Transduction', 'Conjugation'],
      correctAnswer: 'Conjugation',
    ),
    QuizItem(
      question:
          'Which reproductive process is used by bacteria to pick up DNA from their environment?',
      choices: [
        'Conjugation',
        'Transformation',
        'Transduction',
        'Binary fission'
      ],
      correctAnswer: 'Transformation',
    ),
    QuizItem(
      question:
          'What is the function of bacteriophages in bacterial transduction?',
      choices: [
        'They transfer DNA between bacteria.',
        'They assist in bacterial cell division.',
        'They help bacteria move.',
        'They provide energy to bacteria.'
      ],
      correctAnswer: 'They transfer DNA between bacteria.',
    ),
  ];

  int currentQuestionIndex = 0;
  int userScore = 0;
  Map<int, List<String>> userSelectedChoices = {};

  @override
  void initState() {
    super.initState();
    FisherYates.shuffleList(quizItems);
    for (var quizItem in quizItems) {
      FisherYates.shuffleList(quizItem.choices);
    }
  }

  void submitAnswer(String selectedChoice) {
    final int questionIndex = currentQuestionIndex;

    if (!userSelectedChoices.containsKey(questionIndex)) {
      userSelectedChoices[questionIndex] = [];
    }

    userSelectedChoices[questionIndex]!.add(selectedChoice);

    if (selectedChoice == quizItems[questionIndex].correctAnswer) {
      setState(() {
        userScore++;
      });
    }

    if (currentQuestionIndex < quizItems.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Ecosystem_AT_Quiz_1_Score(
            quizItems: quizItems,
            userSelectedChoices: userSelectedChoices,
            userScore: userScore,
            totalQuestions: quizItems.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentQuestionIndex == 0) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Warning'),
              content: Text('You cannot go back after starting a quiz.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
          return false;
        } else {
          setState(() {
            currentQuestionIndex--;
          });
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chapter 2 Lesson 1 Quiz 1'),
          backgroundColor: Color(0xFF729B79), // Set the background color
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: currentQuestionIndex == 0
                ? () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Warning'),
                        content:
                            Text('You cannot go back after starting a quiz.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                : () {
                    setState(() {
                      currentQuestionIndex--;
                    });
                  },
          ),
        ),
        body: currentQuestionIndex < quizItems.length
            ? QuizItemWidget(
                quizItem: quizItems[currentQuestionIndex],
                onSubmit: submitAnswer,
                isLastQuestion: currentQuestionIndex == quizItems.length - 1,
                userSelectedChoices: userSelectedChoices,
                currentQuestionIndex: currentQuestionIndex,
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class QuizItemWidget extends StatefulWidget {
  final QuizItem quizItem;
  final ValueChanged<String> onSubmit;
  final bool isLastQuestion;
  final Map<int, List<String>> userSelectedChoices;
  final int currentQuestionIndex;

  QuizItemWidget({
    required this.quizItem,
    required this.onSubmit,
    required this.isLastQuestion,
    required this.userSelectedChoices,
    required this.currentQuestionIndex,
  });

  @override
  _QuizItemWidgetState createState() => _QuizItemWidgetState();
}

class _QuizItemWidgetState extends State<QuizItemWidget> {
  String? selectedChoice;
  bool answerSubmitted = false; // Track if the answer is submitted

  @override
  void initState() {
    super.initState();
    selectedChoice =
        widget.userSelectedChoices[widget.currentQuestionIndex]?.last;
  }

  @override
  void didUpdateWidget(covariant QuizItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentQuestionIndex != widget.currentQuestionIndex) {
      selectedChoice =
          widget.userSelectedChoices[widget.currentQuestionIndex]?.last;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> buttonColors = [
      Color(0xFF64B6AC),
    ];

    var globalVariables = Provider.of<GlobalVariables>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          // Add Padding widget here
          padding: const EdgeInsets.only(top: 20.0), // Specify top padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    widget.quizItem.question,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ...widget.quizItem.choices.asMap().entries.map((entry) {
                int idx = entry.key;
                String choice = entry.value;
                bool isSelected = selectedChoice == choice;
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected
                          ? buttonColors[idx % buttonColors.length]
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                            color: isSelected
                                ? Colors.transparent
                                : Colors.grey[400]!), // Lighter gray border
                      ),
                    ),
                    onPressed: answerSubmitted
                        ? null // Disable button after answer is submitted
                        : () {
                            setState(() {
                              selectedChoice = choice;
                            });
                          },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        choice,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
              if (widget.isLastQuestion)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: EdgeInsets.only(top: 10, right: 20, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedChoice != null) {
                          globalVariables.setQuizTaken(
                              'lesson6', 'quiz2', true);
                          globalVariables.allowQuiz('lesson6', 'quiz3');
                          setState(() {
                            answerSubmitted = true;
                          });
                          widget.onSubmit(selectedChoice!);
                        }
                      },
                      child:
                          Text('Submit', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                )
              else
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: EdgeInsets.only(top: 10, right: 20, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedChoice != null) {
                          widget.onSubmit(selectedChoice!);
                          setState(() {
                            selectedChoice = null;
                          });
                        }
                      },
                      child:
                          Text('Next', style: TextStyle(color: Colors.black)),
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
