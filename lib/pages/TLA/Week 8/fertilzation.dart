import 'package:capstone/Module%20Contents/Heredity/Heredity_TLA/Heredity_TLA_5_2.dart';
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
  runApp(MaterialApp(home: ModuleScreen8()));
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

class ModuleScreen8 extends StatefulWidget {
  @override
  _ModuleScreen8Page createState() => _ModuleScreen8Page();
}

class _ModuleScreen8Page extends State<ModuleScreen8> {
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
  List<bool> unlockedButtons = List.filled(8, false);
  List<String> wrongAnswers = [];
  String feedbackMessage = '';
  bool showFeedback = false;
  Color feedbackColor = Colors.black;
  List<String> correctFeedbackMessages = [
    "Great Job!",
    "You are Amazing!",
    "Wow! Hats off to you!",
  ];

  List<Map<String, String>> questionAnswerPairs = [
    {
      "question":
          "During which stage in plants does the transfer of pollen occur from one flower to another?",
      "answer": "Pollination",
      "definition":
          "Pollination is the process by which pollen is transferred from the anther (male part) of one flower to the stigma (female part) of another flower. This process is vital for the fertilization of plants.",
      "image": "assets/lesson8/plants/Pollination2.png",
    },
    {
      "question":
          "In plants, at which stage does the pollen grain start growing a tube to reach the ovule?",
      "answer": "Pollen Germination",
      "definition":
          "Pollen germination is the process where the pollen grain begins to grow a pollen tube after landing on the stigma. This tube allows the male gametes to travel towards the ovule for fertilization.",
      "image": "assets/lesson8/plants/pollen.png",
    },
    {
      "question":
          "Which stage involves tube growth and the fusion of male and female gametes in plants?",
      "answer": "Fertilization (Tube Growth and Double Fertilization)",
      "definition":
          "Fertilization in plants includes the growth of the pollen tube and double fertilization, where one sperm fertilizes the egg forming a zygote, and another fuses with two polar nuclei to form the endosperm.",
      "image": "assets/lesson8/plants/fertilization.png",
    },
    {
      "question":
          "At which stage do seeds and fruits begin to form after fertilization in plants?",
      "answer": "Seed and Fruit Formation",
      "definition":
          "Seed and fruit formation occurs after fertilization, where the ovule develops into a seed and the surrounding tissue matures into a fruit, which aids in seed dispersal.",
      "image": "assets/lesson8/Applefruit.png",
    },
    {
      "question":
          "In human reproduction, at which stage are the reproductive cells (sperm and eggs) produced?",
      "answer": "Gamete Production",
      "definition":
          "Gamete production refers to the formation of reproductive cells (sperm in males and eggs in females) through the process of meiosis.",
      "image": "assets/lesson8/human/gamete.png",
    },
    {
      "question":
          "Which stage involves the physical union of male and female reproductive systems in humans?",
      "answer": "Copulation/Sexual Intercourse",
      "definition":
          "Copulation or sexual intercourse is the stage where the male and female reproductive systems come into contact, allowing for the transfer of sperm from the male to the female reproductive tract.",
      "image": "assets/lesson8/sexeduc.png",
    },
    {
      "question":
          "In human reproduction, which stage marks the fusion of sperm and egg to form a zygote?",
      "answer": "Fertilization",
      "definition":
          "Fertilization is the stage where a sperm cell unites with an egg cell, resulting in the formation of a zygote, marking the beginning of a new organism.",
      "image": "assets/lesson8/human/fertilization.png",
    },
    {
      "question":
          "During which stage does the zygote begin to develop and divide in humans?",
      "answer": "Zygote Development",
      "definition":
          "Zygote development is the stage where the zygote undergoes cell division and begins the process of developing into an embryo and eventually a fully formed organism.",
      "image": "assets/lesson8/human/zygote.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    // Shuffle the questions, if necessary
    questionAnswerPairs.shuffle(Random());
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
                          'Introduction to the AR Fertilization Module',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'In this module, you will learn about the processes of fertilization in humans and plants. Pay attention to the models and try to answer the questions correctly. Good luck!',
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
                          'You will be asked a series of questions related to the processes of fertilization in humans and plants. Tap on the corresponding model to answer each question. Try your best to get them all right!',
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
                child: Text(
                  questionAnswerPairs[currentQuestionIndex]['question']!,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
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
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    String buttonText = questionAnswerPairs[index]['answer']!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: unlockedButtons[index]
                                ? () {
                                    _showDefinition(
                                      context,
                                      buttonText,
                                      questionAnswerPairs[index]['definition']!,
                                      questionAnswerPairs[index]['image']!,
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
            uri:
                "assets/lesson5/organelles/table.gltf", // Change to relevant model path
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

              // Updated sceneNodes list
              List<SceneNode> sceneNodes = [
                // Human Fertilization Process (Bottom Row)
                SceneNode(
                  name: "Gamete Production",
                  modelPath: "assets/lesson8/human/gametes.gltf",
                  position: vector.Vector3(-0.20, 0.05, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Copulation/Sexual Intercourse",
                  modelPath: "assets/lesson8/sexeduc.gltf",
                  position: vector.Vector3(-0.05, 0.05, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Fertilization",
                  modelPath: "assets/lesson8/human/fertilization.gltf",
                  position: vector.Vector3(0.10, 0.05, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Zygote Development",
                  modelPath: "assets/lesson8/human/zygote.gltf",
                  position: vector.Vector3(0.25, 0.05, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),

                // Plant Fertilization Process (Top Row)
                SceneNode(
                  name: "Pollination",
                  modelPath: "assets/lesson8/plants/pollination.gltf",
                  position: vector.Vector3(-0.20, 0.20, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Pollen Germination",
                  modelPath: "assets/lesson8/plants/pollen.gltf",
                  position: vector.Vector3(-0.05, 0.20, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Fertilization (Tube Growth and Double Fertilization)",
                  modelPath: "assets/lesson8/plants/fertilization.gltf",
                  position: vector.Vector3(0.10, 0.20, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Seed and Fruit Formation",
                  modelPath: "assets/lesson8/seedymo.gltf",
                  position: vector.Vector3(0.25, 0.20, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
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
          _showDefinition(
            context,
            nodeName,
            questionAnswerPairs[currentQuestionIndex]['definition']!,
            questionAnswerPairs[currentQuestionIndex]['image']!,
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

  void _showDefinition(
      BuildContext context, String part, String definition, String imagePath) {
    double dialogHeight;

    if (definition.length > 200) {
      dialogHeight = 300.0;
    } else if (definition.length > 100) {
      dialogHeight = 250.0;
    } else {
      dialogHeight = 200.0;
    }

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
                  Text(definition),
                  SizedBox(height: 10),
                  Image.asset(imagePath),
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
    String passOrFail = finalScore >= 5 ? 'Passed' : 'Failed';

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
                // Close the dialog
                Navigator.of(context).pop();
                // Navigate back to the initial screen
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Heredity_TLA_5_2()),
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
