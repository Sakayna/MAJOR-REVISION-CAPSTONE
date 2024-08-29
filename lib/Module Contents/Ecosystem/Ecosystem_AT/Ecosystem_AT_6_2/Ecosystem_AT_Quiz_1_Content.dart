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

class Ecosystem_AT_Quiz_3_Content extends StatefulWidget {
  @override
  _Ecosystem_AT_Quiz_3_ContentState createState() =>
      _Ecosystem_AT_Quiz_3_ContentState();
}

class _Ecosystem_AT_Quiz_3_ContentState
    extends State<Ecosystem_AT_Quiz_3_Content> {
  final List<QuizItem> quizItems = [
    QuizItem(
      question: 'What is a macroecosystem?',
      choices: [
        'An ecosystem within a small, specific area.',
        'An ecosystem covering a large geographical area.',
        'An ecosystem within a forest floor.',
        'An ecosystem within a potted plant.'
      ],
      correctAnswer: 'An ecosystem covering a large geographical area.',
    ),
    QuizItem(
      question: 'Which of the following is an example of a microecosystem?',
      choices: ['Ocean', 'Desert', 'Coral reef', 'Grassland'],
      correctAnswer: 'Coral reef',
    ),
    QuizItem(
      question:
          'What determines the type of macroecosystem that exists in an area?',
      choices: [
        'The type of animals in the area',
        'The type of vegetation in the area',
        'The climate of the area',
        'The human activities in the area'
      ],
      correctAnswer: 'The climate of the area',
    ),
    QuizItem(
      question:
          'The place where an organism lives within an ecosystem is called its:',
      choices: ['Habitat', 'Niche', 'Biome', 'Ecosystem'],
      correctAnswer: 'Habitat',
    ),
    QuizItem(
      question: 'Which of the following is NOT an abiotic factor?',
      choices: ['Light', 'Temperature', 'Plants', 'Water'],
      correctAnswer: 'Plants',
    ),
    QuizItem(
      question:
          'Abiotic factors do not influence the number and variety of plants in an ecosystem.',
      choices: ['True', 'False'],
      correctAnswer: 'False',
    ),
    QuizItem(
      question:
          'The blue and red wavelengths of light are important for photosynthesis.',
      choices: ['True', 'False'],
      correctAnswer: 'True',
    ),
    QuizItem(
      question:
          'Endothermic animals have body temperatures that vary with the environment.',
      choices: ['True', 'False'],
      correctAnswer: 'False',
    ),
    QuizItem(
      question:
          'Photoperiodism is the effect of the length of daylight and darkness on the behavior and functioning of plants.',
      choices: ['True', 'False'],
      correctAnswer: 'True',
    ),
    QuizItem(
      question:
          'Extreme temperatures can cause destruction to body tissues and cells.',
      choices: ['True', 'False'],
      correctAnswer: 'True',
    ),

    // Add more quiz items here...
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
          builder: (context) => Ecosystem_AT_Quiz_3_Score(
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Color(0xFFA846A0),
                    floating: false,
                    pinned: false,
                    snap: false,
                    expandedHeight: 120.0,
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        final isTop =
                            constraints.biggest.height <= kToolbarHeight + 16.0;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isTop) ...[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 50.0),
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
                                padding: const EdgeInsets.only(
                                    left: 50.0, right: 18.0),
                                child: Text(
                                  'AT 6.2: Quiz ',
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
                        onPressed: currentQuestionIndex == 0
                            ? () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Warning'),
                                    content: Text(
                                        'You cannot go back after starting a quiz.'),
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
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      child: currentQuestionIndex < quizItems.length
                          ? QuizItemWidget(
                              quizItem: quizItems[currentQuestionIndex],
                              onSubmit: submitAnswer,
                              isLastQuestion:
                                  currentQuestionIndex == quizItems.length - 1,
                              userSelectedChoices: userSelectedChoices,
                              currentQuestionIndex: currentQuestionIndex,
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
      Color(0xFFA846A0),
    ];
    var globalVariables = Provider.of<GlobalVariables>(context);

    return Center(
      child: Padding(
        // Add Padding widget here
        padding: const EdgeInsets.only(top: 80.0), // Specify top padding
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
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
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
                        globalVariables.setQuizTaken('lesson6', 'quiz4', true);
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
                    child: Text('Next', style: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}