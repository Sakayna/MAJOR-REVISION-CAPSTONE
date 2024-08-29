import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1_2/Ecosystem_AT_6_1_2.dart';
import 'package:flutter/material.dart';

class Ecosystem_AT_Quiz_1_Results extends StatelessWidget {
  final List<Map<String, String>> questions;
  final List<String?> selectedPredators;
  final List<String?> selectedPreys;

  Ecosystem_AT_Quiz_1_Results({
    required this.questions,
    required this.selectedPredators,
    required this.selectedPreys,
  });

  @override
  Widget build(BuildContext context) {
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
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Ecosystem_AT_6_1_2(),
                ),
              );
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                bool isPredatorCorrect =
                    selectedPredators[index] == questions[index]['predator'];
                bool isPreyCorrect =
                    selectedPreys[index] == questions[index]['prey'];

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
                        questions[index]['question']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Your Predator: ${selectedPredators[index] ?? "Not Answered"}',
                        style: TextStyle(
                          color: isPredatorCorrect ? Colors.green : Colors.red,
                        ),
                      ),
                      Text(
                        'Your Prey: ${selectedPreys[index] ?? "Not Answered"}',
                        style: TextStyle(
                          color: isPreyCorrect ? Colors.green : Colors.red,
                        ),
                      ),
                      SizedBox(height: 8),
                      if (!isPredatorCorrect || !isPreyCorrect)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isPredatorCorrect)
                              Text(
                                'Correct Predator: ${questions[index]['predator']}',
                                style: TextStyle(color: Colors.green),
                              ),
                            if (!isPreyCorrect)
                              Text(
                                'Correct Prey: ${questions[index]['prey']}',
                                style: TextStyle(color: Colors.green),
                              ),
                          ],
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
                  color: Color(0xFFA846A0),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Ecosystem_AT_6_1_2(),
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
            ),
          ],
        ),
      ),
    );
  }
}
