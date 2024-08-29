import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/AT1/score.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class AnimalAndPlant extends StatefulWidget {
  @override
  _AnimalAndPlantState createState() => _AnimalAndPlantState();
}

class _AnimalAndPlantState extends State<AnimalAndPlant> {
  final List<String> plantOnly = [];
  final List<String> both = [];
  final List<String> animalOnly = [];

  final List<String> items = [
    'Mitochondria',
    'Chloroplast',
    'Cell Wall',
    'Cell Membrane',
    'Nucleus',
    'Ribosomes',
    'Vacuole',
    'Lysosomes',
    'Centrioles',
    'Endoplasmic Reticulum',
    'Golgi apparatus',
    'Cytoplasm',
  ];

  List<String> remainingItems = [];

  @override
  void initState() {
    super.initState();
    remainingItems = List.from(items);
  }

  void submitOrder() {
    int score = 0;

    // Correct answers
    final List<String> correctPlantOnly = ['Cell Wall', 'Chloroplast'];
    final List<String> correctBoth = [
      'Cell Membrane',
      'Ribosomes',
      'Nucleus',
      'Endoplasmic Reticulum',
      'Golgi apparatus',
      'Lysosomes',
      'Vacuole',
      'Mitochondria',
      'Cytoplasm'
    ];
    final List<String> correctAnimalOnly = ['Centriole'];

    // Track user answers
    final Map<String, List<String>> userAnswers = {
      'Plant Only': List.from(plantOnly),
      'Both': List.from(both),
      'Animal Only': List.from(animalOnly),
    };

    // Calculate the score based on correct answers
    score += plantOnly.where((item) => correctPlantOnly.contains(item)).length;
    score += both.where((item) => correctBoth.contains(item)).length;
    score +=
        animalOnly.where((item) => correctAnimalOnly.contains(item)).length;

    bool passed = score >= 8; // Adjusted passing score as needed

    // Global variable updates
    var globalVariables = Provider.of<GlobalVariables>(context, listen: false);
    globalVariables.setQuizTaken('lesson3', 'quiz1', true);
    globalVariables.incrementQuizTakeCount('lesson3_quiz1');
    globalVariables.updateGlobalRemarks('lesson3_quiz1', score, items.length);
    globalVariables.setGlobalScore('lesson3_quiz1', score);
    globalVariables.setQuizItemCount('lesson3_quiz1', items.length);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Plant_Animal_ScorePage(
          score: score,
          passed: passed,
          userAnswers: userAnswers,
          correctAnswers: {
            'Plant Only': correctPlantOnly,
            'Both': correctBoth,
            'Animal Only': correctAnimalOnly,
          },
        ),
      ),
    );
  }

  void returnItemToOriginalPosition(String item, List<String> list) {
    setState(() {
      list.remove(item);
      remainingItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal and Plant Venn Diagram Quiz'),
        backgroundColor: Color(0xFFA1C084),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
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
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.grey),
                        SizedBox(width: 8),
                        Text(
                          'Instructions',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Drag the items below and place them in the correct part of the Venn diagram: Plant, Animal, or Both.',
                      style: TextStyle(fontSize: 12),
                    ),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: remainingItems.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2.5,
                        ),
                        itemBuilder: (context, index) {
                          return Draggable<String>(
                            data: remainingItems[index],
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Color(0xFFA1C084),
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Colors.grey),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.01),
                                    spreadRadius: 0.01,
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  remainingItems[index],
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            feedback: Material(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFFA1C084),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.grey),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.01),
                                      spreadRadius: 0.01,
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    remainingItems[index],
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            childWhenDragging: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Colors.grey),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.01),
                                    spreadRadius: 0.01,
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  remainingItems[index],
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            onDragCompleted: () {
                              setState(() {
                                remainingItems.removeAt(index);
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.green.withOpacity(0.3),
                    child: DragTarget<String>(
                      onAccept: (receivedItem) {
                        setState(() {
                          plantOnly.add(receivedItem);
                        });
                      },
                      builder: (context, acceptedItems, rejectedItems) {
                        return buildCircleContent(plantOnly, 'Plant');
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.purple.withOpacity(0.3),
                    child: DragTarget<String>(
                      onAccept: (receivedItem) {
                        setState(() {
                          both.add(receivedItem);
                        });
                      },
                      builder: (context, acceptedItems, rejectedItems) {
                        return buildCircleContent(both, 'Both');
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.blue.withOpacity(0.3),
                    child: DragTarget<String>(
                      onAccept: (receivedItem) {
                        setState(() {
                          animalOnly.add(receivedItem);
                        });
                      },
                      builder: (context, acceptedItems, rejectedItems) {
                        return buildCircleContent(animalOnly, 'Animal');
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitOrder,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCircleContent(List<String> items, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ),
        SizedBox(height: 10),
        for (var item in items)
          GestureDetector(
            onTap: () => returnItemToOriginalPosition(item, items),
            child: Text(
              item,
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
