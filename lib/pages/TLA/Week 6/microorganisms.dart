import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_TLA/Bacteria_TLA_4_1.dart';
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
  runApp(MaterialApp(home: ModuleScreen6()));
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

class ModuleScreen6 extends StatefulWidget {
  @override
  _ModuleScreen6Page createState() => _ModuleScreen6Page();
}

class _ModuleScreen6Page extends State<ModuleScreen6> {
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

  List<Map<String, String>> questionAnswerPairs = [
    {
      "question":
          "It is a beneficial microorganism used in yogurt production. Tap to answer.",
      "answer": "Lactobacillus",
      "definition":
          "Lactobacillus is a genus of bacteria that convert lactose into lactic acid. They are commonly found in the human gut, mouth, and vagina.",
      "questionImage": "assets/lesson6/question/yogurt.jpg",
      "image": "assets/lesson6/beneficial/lactobacillus.png",
    },
    {
      "question":
          "It is a beneficial microorganism that helps in digestion as a probiotic. Tap to answer.",
      "answer": "Bifidobacterium",
      "definition":
          "Bifidobacterium is a genus of anaerobic bacteria that is part of the gut flora and plays a beneficial role in the human digestive system.",
      "questionImage": "assets/lesson6/question/probiotic.png",
      "image": "assets/lesson6/beneficial/Bifidobacterium.png",
    },
    {
      "question":
          "It is a beneficial microorganism used in cheese production. Tap to answer.",
      "answer": "Streptococcus thermophilus",
      "definition":
          "Streptococcus thermophilus is a species of coccus-shaped bacteria used in the production of yogurt and cheese.",
      "questionImage": "assets/lesson6/question/cheese.jpg",
      "image": "assets/lesson6/beneficial/Streptococcus-thermophilus.png",
    },
    {
      "question":
          "It is a beneficial microorganism that forms symbiotic relationships with legumes. Tap to answer.",
      "answer": "Rhizobium",
      "definition":
          "Rhizobium is a genus of bacteria that form symbiotic relationships with legumes to fix nitrogen from the atmosphere.",
      "questionImage": "assets/lesson6/question/legumes.jpg",
      "image": "assets/lesson6/beneficial/Rhizobium1.png",
    },
    {
      "question":
          "It is a beneficial microorganism used as an insecticide. Tap to answer.",
      "answer": "Bacillus",
      "definition":
          "Bacillus is a genus of Gram-positive, rod-shaped bacteria. They are found in diverse environments and are known for their ability to form endospores.",
      "questionImage": "assets/lesson6/question/insecticides.jpg",
      "image": "assets/lesson6/beneficial/Bacillus.png",
    },
    {
      "question":
          "It is a harmful microorganism found in contaminated meat. Tap to answer.",
      "answer": "E. coli",
      "definition":
          "E. coli (Escherichia coli) is a species of bacteria found in the environment, foods, and intestines of people and animals. Some strains can cause illness.",
      "questionImage": "assets/lesson6/question/contaminatedmeat.jpg",
      "image": "assets/lesson6/harmful/ecoli.png",
    },
    {
      "question":
          "It is a harmful microorganism that can cause skin infections. Tap to answer.",
      "answer": "Staphylococcus",
      "definition":
          "Staphylococcus is a genus of bacteria commonly found on the skin and in the respiratory tract, responsible for staph infections.",
      "questionImage": "assets/lesson6/question/skin infection.jpg",
      "image": "assets/lesson6/harmful/sterile_science-staphylococcus_01-2.png",
    },
    {
      "question":
          "It is a harmful microorganism found in raw chicken. Tap to answer.",
      "answer": "Salmonella",
      "definition":
          "Salmonella is a genus of bacteria that are a common cause of food poisoning in humans.",
      "questionImage": "assets/lesson6/question/rawchicken.jpg",
      "image": "assets/lesson6/harmful/salmonella.png",
    },
    {
      "question":
          "It is a harmful microorganism that causes tuberculosis. Tap to answer.",
      "answer": "Mycobacterium",
      "definition":
          "Mycobacterium is a genus of bacteria known for causing tuberculosis and leprosy in humans.",
      "questionImage": "assets/lesson6/question/tuberculosis.jpg",
      "image": "assets/lesson6/harmful/mycobacteria.png",
    },
    {
      "question":
          "It is a harmful microorganism found in contaminated water. Tap to answer.",
      "answer": "Vibrio",
      "definition":
          "Vibrio is a genus of bacteria, some species of which can cause foodborne infection, typically associated with eating undercooked seafood.",
      "questionImage": "assets/lesson6/question/contaminatedwater.jpg",
      "image": "assets/lesson6/harmful/vibrio.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    // Randomize the questions
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
                          'Introduction to the AR Bacteria Learning Module',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'In this module, you will learn about different beneficial and harmful bacteria. Pay attention to the models and try to answer the questions correctly. Good luck!',
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
                          'You will be asked a series of questions related to different types of bacteria. Tap on the corresponding model to answer each question. If you answer incorrectly, it will be counted. Try your best to get them all right!',
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
                child: Column(
                  children: [
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
                  itemCount: 10,
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

              // Updated sceneNodes list with Beneficial bacteria on top of Harmful bacteria
              List<SceneNode> sceneNodes = [
                // Harmful bacteria (Bottom Row)
                SceneNode(
                  name: "E. coli",
                  modelPath: "assets/lesson6/harmful/ecoli.gltf",
                  position: vector.Vector3(-0.15, 0.05, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Mycobacterium",
                  modelPath: "assets/lesson6/harmful/mycob.gltf",
                  position: vector.Vector3(-0.05, 0.05, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Salmonella",
                  modelPath: "assets/lesson6/harmful/salmonella.gltf",
                  position: vector.Vector3(0.05, 0.05, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Staphylococcus",
                  modelPath: "assets/lesson6/harmful/staph.gltf",
                  position: vector.Vector3(0.15, 0.05, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Vibrio",
                  modelPath: "assets/lesson6/harmful/vibrio.gltf",
                  position: vector.Vector3(0.25, 0.05, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),

                // Beneficial bacteria (Top Row - directly above Harmful)
                SceneNode(
                  name: "Bacillus",
                  modelPath: "assets/lesson6/beneficial/bacillus.gltf",
                  position:
                      vector.Vector3(-0.15, 0.15, -0.15), // Moved up on y-axis
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Bifidobacterium",
                  modelPath: "assets/lesson6/beneficial/bifido.gltf",
                  position:
                      vector.Vector3(-0.05, 0.15, -0.15), // Moved up on y-axis
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Lactobacillus",
                  modelPath: "assets/lesson6/beneficial/lacto.gltf",
                  position:
                      vector.Vector3(0.05, 0.15, -0.15), // Moved up on y-axis
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Rhizobium",
                  modelPath: "assets/lesson6/beneficial/rhizobium.gltf",
                  position:
                      vector.Vector3(0.15, 0.15, -0.15), // Moved up on y-axis
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Streptococcus thermophilus",
                  modelPath: "assets/lesson6/beneficial/st.gltf",
                  position:
                      vector.Vector3(0.25, 0.15, -0.15), // Moved up on y-axis
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
                  MaterialPageRoute(builder: (context) => Bacteria_TLA_4_1()),
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
