import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/AT1/Animal_and_Plant_Cells_AT_3_1.dart';
import 'package:flutter/material.dart';

class Plant_Animal_ResultsPage extends StatelessWidget {
  final Map<String, List<String>> userAnswers;
  final Map<String, List<String>> correctAnswers;

  const Plant_Animal_ResultsPage({
    Key? key,
    required this.userAnswers,
    required this.correctAnswers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA1C084),
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
                      'Plant and Animal Cells',
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
                      'Quiz Results',
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Animal_and_Plant_AT_3_1(),
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
            buildResultSection('Plant Only', userAnswers['Plant Only']!,
                correctAnswers['Plant Only']!),
            SizedBox(height: 20),
            buildResultSection(
                'Both', userAnswers['Both']!, correctAnswers['Both']!),
            SizedBox(height: 20),
            buildResultSection('Animal Only', userAnswers['Animal Only']!,
                correctAnswers['Animal Only']!),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFA1C084),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Animal_and_Plant_AT_3_1(),
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

  Widget buildResultSection(
      String title, List<String> userAnswers, List<String> correctAnswers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Your Answers:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        for (var answer in userAnswers)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              answer,
              style: TextStyle(
                  fontSize: 16,
                  color: correctAnswers.contains(answer)
                      ? Colors.green
                      : Colors.red),
            ),
          ),
        SizedBox(height: 10),
        Text(
          'Correct Answers:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        for (var answer in correctAnswers)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey,
              ),
            ),
          ),
      ],
    );
  }
}
