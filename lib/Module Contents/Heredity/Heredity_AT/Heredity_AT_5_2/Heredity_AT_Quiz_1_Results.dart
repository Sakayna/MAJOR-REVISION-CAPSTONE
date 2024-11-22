import 'package:capstone/Module%20Contents/Heredity/Heredity_AT/Heredity_AT_5_2/Heredity_AT_5_2.dart';
import 'package:flutter/material.dart';

class Heredity_AT_5_1_2_Results extends StatelessWidget {
  final List<String> stages;
  final List<String> userAnswers;

  const Heredity_AT_5_1_2_Results({
    Key? key,
    required this.stages,
    required this.userAnswers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF64B6AC),
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
                      'Heredity',
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
                      'AT 5.1.2',
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
                  builder: (context) =>
                      Heredity_AT_5_2(), // Ensure this widget exists and is imported
                ),
              );
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
                itemCount: stages.length,
                itemBuilder: (context, index) {
                  bool isCorrect = userAnswers[index] == stages[index];

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
                          'Stage ${index + 1}:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          stages[index],
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Your Answer:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          userAnswers[index].isNotEmpty
                              ? userAnswers[index]
                              : 'No Answer Provided',
                          style: TextStyle(
                            fontSize: 16,
                            color: isCorrect ? Colors.green : Colors.red,
                          ),
                        ),
                        if (!isCorrect)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Text(
                                'Correct Answer:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                stages[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                ),
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
                    color: Color(0xFF64B6AC),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Heredity_AT_5_2()),
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
      ),
    );
  }
}
