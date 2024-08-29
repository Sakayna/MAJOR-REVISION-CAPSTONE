import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_TLA/Ecosystem_TLA_6_2.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:math';

void main() {
  runApp(MaterialApp(home: ModuleScreen10()));
}

class SceneNode {
  final String name;
  final String modelPath;
  final vector.Vector3 position;
  final vector.Vector3 scale;

  SceneNode({
    required this.name,
    required this.modelPath,
    required this.position,
    required this.scale,
  });
}

class ModuleScreen10 extends StatefulWidget {
  @override
  _ModuleScreen10Page createState() => _ModuleScreen10Page();
}

class _ModuleScreen10Page extends State<ModuleScreen10> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  ARLocationManager? arLocationManager;
  bool surfaceDetected = false;
  bool modelPlaced = false;
  bool introductionShown = false;
  bool instructionsShown = false;
  List<ARNode> nodes = [];
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  int currentQuestionIndex = 0;
  List<bool> unlockedButtons = List.filled(10, false);
  List<String> wrongAnswers = [];
  String feedbackMessage = '';
  bool showFeedback = false;
  Color feedbackColor = Colors.black;
  List<String> correctFeedbackMessages = [
    "Great Job!",
    "You are Amazing!",
    "Wow! Hats off to you!",
  ];

  // Function Questions (First Set)
  List<Map<String, String>> functionQuestions = [
    {
      "question":
          "This type of interaction benefits both species. Tap to answer.",
      "answer": "Mutualism",
      "definition":
          "Mutualism is a symbiotic relationship where both species benefit from the interaction.",
      "image": "assets/lesson10/mutualism.png",
      "discussionImage": "assets/lesson10/mutualism.png",
    },
    {
      "question":
          "This interaction occurs when one organism benefits and the other is harmed. Tap to answer.",
      "answer": "Parasitism",
      "definition":
          "Parasitism is a relationship where one organism, the parasite, benefits at the expense of the host.",
      "image": "assets/lesson10/parasitism.png",
      "discussionImage": "assets/lesson10/parasitism.png",
    },
    {
      "question":
          "This interaction involves competition for resources. Tap to answer.",
      "answer": "Competition",
      "definition":
          "Competition occurs when two or more species compete for the same resources, such as food or territory.",
      "image": "assets/lesson10/competition.png",
      "discussionImage": "assets/lesson10/competition.png",
    },
    {
      "question":
          "In this interaction, one organism benefits without affecting the other. Tap to answer.",
      "answer": "Commensalism",
      "definition":
          "Commensalism is a type of relationship where one organism benefits while the other is neither helped nor harmed.",
      "image": "assets/lesson10/commensalism.png",
      "discussionImage": "assets/lesson10/commensalism.png",
    },
    {
      "question":
          "This is a type of interaction where one organism hunts and consumes another. Tap to answer.",
      "answer": "Predation",
      "definition":
          "Predation is an interaction where a predator hunts, kills, and eats its prey.",
      "image": "assets/lesson10/predation.png",
      "discussionImage": "assets/lesson10/predation.png",
    },
  ];

  // Image Questions (Second Set)
  List<Map<String, String>> imageQuestions = [
    {
      "question":
          "Which type of ecological relationship is depicted in the image?",
      "answer": "Mutualism",
      "discussion":
          "This image depicts mutualism, where both organisms involved benefit from the relationship. For example, bees and flowers have a mutualistic relationship where bees get nectar from the flowers, and in return, they pollinate the flowers.",
      "questionImage": "assets/lesson10/images/beesandflower.jpg",
      "image": "assets/lesson10/images/beesandflower.jpg",
    },
    {
      "question":
          "Which type of ecological relationship is depicted in the image?",
      "answer": "Predation",
      "discussion":
          "This image depicts predation, where a predator hunts, kills, and eats its prey. For example, a cheetah hunting a deer is a typical predatory interaction.",
      "questionImage": "assets/lesson10/images/cheetahanddeer.jpg",
      "image": "assets/lesson10/images/cheetahanddeer.jpg",
    },
    {
      "question":
          "Which type of ecological relationship is depicted in the image?",
      "answer": "Competition",
      "discussion":
          "This image depicts competition, where two or more species compete for the same resources, such as food or territory. For example, two animals competing for food in the same habitat.",
      "questionImage": "assets/lesson10/images/compete.jpg",
      "image": "assets/lesson10/images/compete.jpg",
    },
    {
      "question":
          "Which type of ecological relationship is depicted in the image?",
      "answer": "Commensalism",
      "discussion":
          "This image depicts commensalism, where one organism benefits while the other is neither helped nor harmed. For example, a remora fish attached to a shark benefits by feeding on scraps while the shark remains unaffected.",
      "questionImage": "assets/lesson10/images/remorashark.png",
      "image": "assets/lesson10/images/remorashark.png",
    },
    {
      "question":
          "Which type of ecological relationship is depicted in the image?",
      "answer": "Parasitism",
      "discussion":
          "This image depicts parasitism, where one organism, the parasite, benefits at the expense of the host. For example, ticks feeding on the blood of a host animal.",
      "questionImage": "assets/lesson10/images/ticks.jpg",
      "image": "assets/lesson10/images/ticks.jpg",
    },
  ];

  // The combined question list to manage flow
  List<Map<String, String>> questionAnswerPairs = [];

  @override
  void initState() {
    super.initState();
    // First, randomize the function questions
    functionQuestions.shuffle(Random());
    // Then randomize the image questions
    imageQuestions.shuffle(Random());
    // Combine them, keeping function questions first
    questionAnswerPairs = [...functionQuestions, ...imageQuestions];
  }

  @override
  void dispose() {
    arSessionManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: Center(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.black,
              child: Text(
                'Correct: $correctAnswers  Wrong: $incorrectAnswers',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          actions: [
            SizedBox(width: 48),
          ],
        ),
      ),
      body: Stack(
        children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontal,
          ),
          if (!surfaceDetected || (surfaceDetected && !modelPlaced))
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera, size: 100, color: Colors.white),
                  SizedBox(height: 20),
                  Text(
                    'Scan the surface and Tap the screen to place the models',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          if (modelPlaced && !introductionShown)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Introduction to the AR Learning Module',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'In this module, you will learn about different ecological interactions. Pay attention to the models and try to answer the questions correctly. Good luck!',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              introductionShown = true;
                            });
                          },
                          child: Text('Next'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (introductionShown && !instructionsShown)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Instructions',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'You will be asked a series of questions related to different types of ecological interactions. Tap on the corresponding model to answer each question. If you answer incorrectly, it will be counted. Try your best to get them all right!',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              instructionsShown = true;
                            });
                          },
                          child: Text('Start'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (showFeedback)
            Positioned(
              top: 16,
              left: MediaQuery.of(context).size.width / 6,
              right: MediaQuery.of(context).size.width / 6,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    feedbackMessage,
                    style: TextStyle(
                      fontSize: 16,
                      color: feedbackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          if (modelPlaced &&
              instructionsShown &&
              currentQuestionIndex < questionAnswerPairs.length)
            Positioned(
              bottom: 150,
              left: 16,
              right: 16,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    if (questionAnswerPairs[currentQuestionIndex]
                        .containsKey('questionImage'))
                      Image.asset(
                        questionAnswerPairs[currentQuestionIndex]
                            ['questionImage']!,
                        height: 100,
                      ),
                    SizedBox(height: 10),
                    Text(
                      questionAnswerPairs[currentQuestionIndex]['question']!,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          if (instructionsShown)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: questionAnswerPairs.length,
                  itemBuilder: (context, index) {
                    String buttonText = questionAnswerPairs[index]['answer']!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: unlockedButtons[index]
                                ? () {
                                    _showDefinitionOrDiscussion(
                                      context,
                                      buttonText,
                                      questionAnswerPairs[index],
                                    );
                                  }
                                : null,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(5),
                              foregroundColor: Colors.white,
                            ),
                            child: unlockedButtons[index]
                                ? Column(
                                    children: [
                                      if (questionAnswerPairs[index]
                                          .containsKey('image'))
                                        Image.asset(
                                          questionAnswerPairs[index]['image']!,
                                          width: 60,
                                          height: 60,
                                        ),
                                      Text(
                                        buttonText,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )
                                : Icon(Icons.help_outline, size: 40),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  void onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;
    this.arLocationManager = arLocationManager;

    this.arSessionManager!.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          showWorldOrigin: false,
          handlePans: false,
          handleScale: true,
        );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap =
        (List<ARHitTestResult> hitTestResults) {
      if (!modelPlaced) {
        ARHitTestResult? singleHitTestResult;
        try {
          singleHitTestResult = hitTestResults.firstWhere(
            (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane,
          );
        } catch (e) {
          singleHitTestResult = null;
        }

        if (singleHitTestResult != null) {
          var translation = singleHitTestResult.worldTransform.getTranslation();
          var rotation = singleHitTestResult.worldTransform.getRotation();
          var rotationQuaternion = vector.Quaternion.fromRotation(rotation);

          // Add the table node
          var tableNode = ARNode(
            type: NodeType.localGLTF2,
            uri: "assets/lesson5/organelles/table.gltf",
            scale: vector.Vector3(1.5, 1.0, 1.0),
            position: vector.Vector3(
              translation.x + 0.05,
              translation.y - 0.25,
              translation.z - 0.20,
            ),
            rotation: vector.Vector4(0, 1, 0, 1.5708),
            name: "table",
            canScale: false,
          );

          arObjectManager!.addNode(tableNode).then((didAddTableNode) {
            if (didAddTableNode!) {
              nodes.add(tableNode);

              // Updated sceneNodes list with new ecological models
              List<SceneNode> sceneNodes = [
                // Predation Model
                SceneNode(
                  name: "Predation",
                  modelPath: "assets/lesson10/predation.gltf",
                  position: vector.Vector3(-0.30, 0.05, -0.15),
                  scale: vector.Vector3(0.03, 0.03, 0.03),
                ),
                // Mutualism Model
                SceneNode(
                  name: "Mutualism",
                  modelPath: "assets/lesson10/mutualism.gltf",
                  position: vector.Vector3(-0.15, 0.05, -0.15),
                  scale: vector.Vector3(0.03, 0.03, 0.03),
                ),
                // Competition Model
                SceneNode(
                  name: "Competition",
                  modelPath: "assets/lesson10/competition.gltf",
                  position: vector.Vector3(0.0, 0.05, -0.15),
                  scale: vector.Vector3(0.03, 0.03, 0.03),
                ),
                // Parasitism Model
                SceneNode(
                  name: "Parasitism",
                  modelPath: "assets/lesson10/parasitism.gltf",
                  position: vector.Vector3(0.15, 0.05, -0.15),
                  scale: vector.Vector3(0.03, 0.03, 0.03),
                ),
                // Commensalism Model
                SceneNode(
                  name: "Commensalism",
                  modelPath: "assets/lesson10/commensalism.gltf",
                  position: vector.Vector3(0.30, 0.05, -0.15),
                  scale: vector.Vector3(0.03, 0.03, 0.03),
                ),
              ];

              loadModels(sceneNodes, translation, rotationQuaternion);
            }
          });
        }
      }
    };
  }

  Future<void> loadModel(SceneNode sceneNode, vector.Vector3 translation,
      vector.Quaternion rotation) async {
    try {
      var newNode = ARNode(
        type: NodeType.localGLTF2,
        uri: sceneNode.modelPath,
        scale: sceneNode.scale,
        position: vector.Vector3(
          translation.x + sceneNode.position.x,
          translation.y + sceneNode.position.y,
          translation.z + sceneNode.position.z,
        ),
        rotation: vector.Vector4(0, 1, 0, 6.2832),
        name: sceneNode.name,
        canScale: false,
      );

      bool didAddNode = await arObjectManager!.addNode(newNode) ?? false;
      if (didAddNode) {
        nodes.add(newNode);
      }
    } catch (e) {
      arSessionManager?.onError("Failed to add model: $e");
    }
  }

  void loadModels(List<SceneNode> sceneNodes, vector.Vector3 translation,
      vector.Quaternion rotation) async {
    for (var sceneNode in sceneNodes) {
      await loadModel(sceneNode, translation, rotation);
    }
    setState(() {
      modelPlaced = true;
      surfaceDetected = true;
    });
    arObjectManager!.onNodeTap = (tappedNodes) {
      tappedNodes.forEach((nodeName) {
        String question =
            questionAnswerPairs[currentQuestionIndex]['question']!;
        String answer = questionAnswerPairs[currentQuestionIndex]['answer']!;

        if (nodeName == answer) {
          _showDefinitionOrDiscussion(
            context,
            nodeName,
            questionAnswerPairs[currentQuestionIndex],
          );

          setState(() {
            correctAnswers++;
            unlockedButtons[currentQuestionIndex] = true;
            currentQuestionIndex++;
            feedbackMessage = correctFeedbackMessages[
                Random().nextInt(correctFeedbackMessages.length)];
            feedbackColor = Colors.green;
            showFeedback = true;
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                showFeedback = false;
                feedbackMessage = '';
              });
            });
          });
        } else {
          setState(() {
            incorrectAnswers++;
            feedbackMessage = 'Wrong! You tapped on $nodeName';
            feedbackColor = Colors.red;
            wrongAnswers.add(
                'Q: ${questionAnswerPairs[currentQuestionIndex]['question']} - Your answer: $nodeName');
            showFeedback = true;
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                showFeedback = false;
                feedbackMessage = '';
              });
            });
          });
        }
      });
    };
  }

  void _showDefinitionOrDiscussion(
      BuildContext context, String part, Map<String, String> questionPair) {
    double dialogHeight;

    if (questionPair['definition'] != null &&
        questionPair['definition']!.length > 200) {
      dialogHeight = 300.0;
    } else if (questionPair['definition'] != null &&
        questionPair['definition']!.length > 100) {
      dialogHeight = 250.0;
    } else {
      dialogHeight = 200.0;
    }

    String contentText =
        questionPair['definition'] ?? questionPair['discussion']!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(part),
          content: SizedBox(
            height: dialogHeight,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(contentText),
                  if (questionPair.containsKey('discussionImage'))
                    SizedBox(height: 10),
                  if (questionPair.containsKey('discussionImage'))
                    Image.asset(questionPair['discussionImage']!),
                  if (questionPair.containsKey('questionImage'))
                    SizedBox(height: 10),
                  if (questionPair.containsKey('questionImage'))
                    Image.asset(questionPair['questionImage']!),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                if (currentQuestionIndex >= questionAnswerPairs.length) {
                  _showScore();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showScore() {
    int finalScore = correctAnswers - incorrectAnswers;
    if (finalScore < 0) finalScore = 0;
    String passOrFail = finalScore >= 7 ? 'Passed' : 'Failed';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Completed!'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Your Score: $finalScore / ${questionAnswerPairs.length}'),
                Text('You have $passOrFail'),
                SizedBox(height: 20),
                Text('Incorrect Answers:'),
                for (String wrongAnswer in wrongAnswers) Text(wrongAnswer),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Click on the button to go back to the module.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Ecosystem_TLA_6_2()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('Exit'),
            ),
          ],
        );
      },
    );
  }
}
