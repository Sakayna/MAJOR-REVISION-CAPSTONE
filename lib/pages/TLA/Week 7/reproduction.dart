import 'package:capstone/Module%20Contents/Heredity/Heredity_TLA/Heredity_TLA_5_1.dart';
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
  runApp(MaterialApp(home: ModuleScreen7()));
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

class ModuleScreen7 extends StatefulWidget {
  @override
  _ModuleScreen7Page createState() => _ModuleScreen7Page();
}

class _ModuleScreen7Page extends State<ModuleScreen7> {
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
  int pairProgress = 0; // Track pair progress (e.g., 0/2, 1/2)
  List<bool> unlockedButtons = List.filled(12, false);
  List<String> wrongAnswers = [];
  String feedbackMessage = '';
  bool showFeedback = false;
  Color feedbackColor = Colors.black;
  List<String> correctFeedbackMessages = [
    "Great Job!",
    "You are Amazing!",
    "Wow! Hats off to you!",
  ];

  // List of question-answer pairs
  List<Map<String, dynamic>> questionAnswerPairs = [
    {
      "question":
          "What combination of cells is required to form a zygote in human reproduction?",
      "answers": ["Sperm", "Egg"],
      "definition":
          "The sperm and egg cells are the male and female gametes, respectively. During fertilization, the sperm cell penetrates the egg cell, combining their genetic material to form a zygote. This marks the beginning of embryonic development in humans.",
      "buttonImages": [
        "assets/lesson7/for images/Sperm Cell.jpg",
        "assets/lesson7/for images/egg cell.jpg"
      ],
      "discussionImages": [
        "assets/lesson7/for images/Sperm Cell.jpg",
        "assets/lesson7/for images/egg cell.jpg"
      ],
      "title": "Internal (Sexual Reproduction)"
    },
    {
      "question":
          "Which combination of animals participates in sexual reproduction to produce offspring?",
      "answers": ["Male Chicken", "Female Chicken"],
      "definition":
          "In chickens, sexual reproduction involves the fertilization of the female's eggs by the male's sperm. The fertilized eggs develop into embryos and eventually hatch into chicks. This process ensures genetic diversity in the offspring.",
      "buttonImages": [
        "assets/lesson7/for images/male chiken.jpg",
        "assets/lesson7/for images/female chiken.jpg"
      ],
      "discussionImages": [
        "assets/lesson7/for images/male chiken.jpg",
        "assets/lesson7/for images/female chiken.jpg"
      ],
      "title": "Internal with External (Sexual Reproduction)"
    },
    {
      "question":
          "Which combination of amphibians is involved in external fertilization during sexual reproduction?",
      "answers": ["Male Frog", "Female Frog"],
      "definition":
          "Frogs typically undergo external fertilization, where the female releases eggs into the water, and the male releases sperm over them. This method of reproduction increases the chances of fertilization and the survival of the species in aquatic environments.",
      "buttonImages": [
        "assets/lesson7/for images/male frog.jpg",
        "assets/lesson7/for images/female frog.jpg"
      ],
      "discussionImages": [
        "assets/lesson7/for images/male frog.jpg",
        "assets/lesson7/for images/female frog.jpg"
      ],
      "title": "External (Sexual Reproduction)"
    },
    {
      "question":
          "Which combination of organisms is essential for the process of pollination?",
      "answers": ["Bee", "Flower"],
      "definition":
          "Pollination is the process by which pollen is transferred from the male part (anther) of a flower to the female part (stigma). Bees play a crucial role in pollination by carrying pollen from one flower to another, enabling plants to reproduce and produce seeds.",
      "buttonImages": [
        "assets/lesson7/for images/bee.jpg",
        "assets/lesson7/for images/flowers.jpg"
      ],
      "discussionImages": [
        "assets/lesson7/for images/bee.jpg",
        "assets/lesson7/for images/flowers.jpg"
      ],
      "title": "Pollination (Sexual Reproduction)"
    },
    {
      "question":
          "What bacterial process involves the transfer of genetic material through direct contact?",
      "answers": ["Conjugation"],
      "definition":
          "Conjugation is a method of horizontal gene transfer in bacteria, where genetic material is exchanged between bacterial cells through direct contact. This process often involves the transfer of plasmids, which are small DNA molecules that carry beneficial genes, such as antibiotic resistance.",
      "buttonImages": ["assets/lesson7/for images/Conjugation.png"],
      "discussionImages": ["assets/lesson7/for images/Conjugation.png"],
      "title": "Conjugation (Sexual Reproduction)"
    },
    {
      "question":
          "What bacterial process involves the uptake of foreign DNA from the surrounding environment?",
      "answers": ["Transformation"],
      "definition":
          "Transformation is a process where bacteria take up foreign DNA from their surroundings and incorporate it into their own genome. This can lead to new traits, such as antibiotic resistance, being expressed in the bacterial population.",
      "buttonImages": ["assets/lesson7/for images/transformation.png"],
      "discussionImages": ["assets/lesson7/for images/transformation.png"],
      "title": "Transformation (Sexual Reproduction)"
    },
    {
      "question":
          "What bacterial process involves the transfer of DNA by a virus or viral vector?",
      "answers": ["Transduction"],
      "definition":
          "Transduction is a process where bacterial DNA is transferred from one bacterium to another by a virus, known as a bacteriophage. This method of gene transfer can introduce new genetic material into a bacterial genome, leading to genetic variation.",
      "buttonImages": ["assets/lesson7/for images/transformation.png"],
      "discussionImages": ["assets/lesson7/for images/transformation.png"],
      "title": "Transduction (Sexual Reproduction)"
    },
    // Questions for Asexual Reproduction
    {
      "question":
          "What is the name of the asexual reproduction process where a single organism divides into two parts?",
      "answers": ["Binary Fission"],
      "definition":
          "Binary fission is a common method of asexual reproduction in prokaryotes, such as bacteria. The parent cell divides into two genetically identical daughter cells, ensuring the rapid spread of the organism in favorable environments.",
      "buttonImages": ["assets/lesson7/for images/Binary Fission.png"],
      "discussionImages": ["assets/lesson7/for images/Binary Fission.png"],
      "title": "Binary Fission (Asexual Reproduction)"
    },
    {
      "question":
          "Which asexual reproduction process involves the growth of a new organism from a part of the parent?",
      "answers": ["Budding"],
      "definition":
          "Budding is a type of asexual reproduction in which a new organism grows out of the body of the parent organism. This is commonly seen in yeast and hydra, where the bud eventually detaches and becomes an independent organism.",
      "buttonImages": ["assets/lesson7/for images/budding .png"],
      "discussionImages": ["assets/lesson7/for images/budding .png"],
      "title": "Budding (Asexual Reproduction)"
    },
    {
      "question":
          "Which asexual reproduction process involves a new organism forming from a fragment of the parent?",
      "answers": ["Fragmentation"],
      "definition":
          "Fragmentation occurs when an organism breaks into pieces, each of which can grow into a complete organism. This method of asexual reproduction is seen in organisms like starfish and some types of worms, allowing them to regenerate and reproduce efficiently.",
      "buttonImages": [
        "assets/lesson7/for images/Fragmentation-and-Regeneration1.png"
      ],
      "discussionImages": [
        "assets/lesson7/for images/Fragmentation-and-Regeneration1.png"
      ],
      "title": "Fragmentation (Asexual Reproduction)"
    },
    {
      "question":
          "What is the asexual reproduction process where spores develop into new organisms?",
      "answers": ["Spore Formation"],
      "definition":
          "Spore formation is an asexual reproduction process where an organism produces spores, which are released and can develop into new individuals. This method is commonly used by fungi, algae, and some plants to reproduce in large numbers and spread over wide areas.",
      "buttonImages": ["assets/lesson7/for images/Spore-Formation.png"],
      "discussionImages": ["assets/lesson7/for images/Spore-Formation.png"],
      "title": "Spore Formation (Asexual Reproduction)"
    },
    {
      "question":
          "Which process involves new plants growing from parts of the parent plant in asexual reproduction?",
      "answers": ["Vegetative Propagation"],
      "definition":
          "Vegetative propagation is a form of asexual reproduction in plants where new plants grow from vegetative parts like stems, roots, or leaves. This method is used by many plants, such as potatoes and strawberries, to produce clones of themselves.",
      "buttonImages": ["assets/lesson7/for images/vegetative.png"],
      "discussionImages": ["assets/lesson7/for images/vegetative.png"],
      "title": "Vegetative Propagation (Asexual Reproduction)"
    },
  ];

  @override
  void initState() {
    super.initState();
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
        preferredSize: Size.fromHeight(70.0), // Adjust the height here
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
            SizedBox(width: 48), // To keep the title centered
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
                          'Introduction to the AR Learning Module on Reproduction',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'In this activity, you will explore different types of reproduction through AR models. Pay close attention to the questions and models, and aim to answer them accurately. Good luck!',
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
                          'You will be presented with a series of questions about different types of reproduction. Tap on the correct model to answer each question. If you make a mistake, it will be counted. Do your best to answer them all correctly!',
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
              bottom: 150, // Adjusted to avoid overlapping with buttons
              left: 16,
              right: 16,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "${questionAnswerPairs[currentQuestionIndex]['question']} ($pairProgress/${questionAnswerPairs[currentQuestionIndex]['answers'].length})",
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
                height: 150, // Adjusted to match the height of the buttons
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: questionAnswerPairs.length,
                  itemBuilder: (context, index) {
                    String modelName =
                        questionAnswerPairs[index]['answers']![0];
                    bool hasPair =
                        questionAnswerPairs[index]['answers']!.length > 1;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 100, // Set a fixed height for all buttons
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: unlockedButtons[index]
                                  ? () {
                                      _showDefinition(
                                        context,
                                        modelName,
                                        questionAnswerPairs[index]
                                            ['definition']!,
                                        questionAnswerPairs[index]
                                            ['discussionImages']!,
                                        questionAnswerPairs[index][
                                            'title']!, // Use the title from the question data
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
                                                    ['buttonImages']!
                                                .length >
                                            1)
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: questionAnswerPairs[
                                                        index]['buttonImages']!
                                                    .map<Widget>((imagePath) =>
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      2.0),
                                                          child: Image.asset(
                                                            imagePath,
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                                        ))
                                                    .toList(),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                questionAnswerPairs[index]
                                                    ['title']!,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          )
                                        else
                                          Image.asset(
                                            questionAnswerPairs[index]
                                                ['buttonImages']![0],
                                            width: 60,
                                            height:
                                                60, // Ensure consistent height
                                          ),
                                        if (questionAnswerPairs[index]
                                                    ['buttonImages']!
                                                .length ==
                                            1)
                                          Text(
                                            questionAnswerPairs[index]
                                                ['title']!,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                      ],
                                    )
                                  : Icon(Icons.help_outline, size: 40),
                            ),
                          ],
                        ),
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
            scale: vector.Vector3(1.5, 1.0, 1.0), // Adjusted table width
            position: vector.Vector3(
              translation.x +
                  0.15, // Positioned the table slightly to the right
              translation.y - 0.25, // Keep the table at the same height
              translation.z - 0.20, // Move the table slightly forward
            ),
            rotation: vector.Vector4(
                0, 1, 0, 1.5708), // Rotate 90 degrees around Y-axis
            name: "table",
            canScale: false,
          );

          arObjectManager!.addNode(tableNode).then((didAddTableNode) {
            if (didAddTableNode!) {
              nodes.add(tableNode);

              // Load models for sexual and asexual reproduction questions

              List<SceneNode> sexualReproductionNodes = [
                SceneNode(
                  name: "Sperm",
                  modelPath: "assets/lesson7/spermmy.gltf",
                  position:
                      vector.Vector3(-0.2, 0.05, -0.25), // Moved right slightly
                  scale: vector.Vector3(0.03, 0.03, 0.03), // Smaller scale
                ),
                SceneNode(
                  name: "Male Chicken",
                  modelPath: "assets/lesson7/chicken/brown.gltf",
                  position:
                      vector.Vector3(0.0, 0.05, -0.25), // Moved right slightly
                  scale: vector.Vector3(
                      0.25, 0.25, 0.25), // Larger scale for chickens
                ),
                SceneNode(
                  name: "Egg",
                  modelPath: "assets/lesson7/practice.gltf",
                  position:
                      vector.Vector3(0.2, 0.05, -0.25), // Moved right slightly
                  scale: vector.Vector3(0.03, 0.03, 0.03), // Smaller scale
                ),
                SceneNode(
                  name: "Female Chicken",
                  modelPath: "assets/lesson7/chicken/white.gltf",
                  position:
                      vector.Vector3(0.4, 0.05, -0.25), // Moved right slightly
                  scale: vector.Vector3(
                      0.25, 0.25, 0.25), // Larger scale for chickens
                ),
                SceneNode(
                  name: "Male Frog",
                  modelPath: "assets/lesson7/chicken/malefrog.gltf",
                  position:
                      vector.Vector3(-0.2, 0.05, -0.15), // Moved right slightly
                  scale: vector.Vector3(
                      0.25, 0.25, 0.25), // Larger scale for frogs
                ),
                SceneNode(
                  name: "Female Frog",
                  modelPath: "assets/lesson7/chicken/femalefrog.gltf",
                  position:
                      vector.Vector3(0.0, 0.05, -0.15), // Moved right slightly
                  scale: vector.Vector3(
                      0.25, 0.25, 0.25), // Larger scale for frogs
                ),
                SceneNode(
                  name: "Bee",
                  modelPath: "assets/lesson7/Bee.gltf",
                  position:
                      vector.Vector3(0.2, 0.05, -0.15), // Moved right slightly
                  scale: vector.Vector3(0.03, 0.03, 0.03), // Smaller scale
                ),
                SceneNode(
                  name: "Flower",
                  modelPath: "assets/lesson7/chicken/flower1.gltf",
                  position:
                      vector.Vector3(0.4, 0.05, -0.15), // Moved right slightly
                  scale: vector.Vector3(
                      0.15, 0.15, 0.15), // Scale adjusted for flower
                ),
              ];

              List<SceneNode> asexualReproductionNodes = [
                SceneNode(
                  name: "Binary Fission",
                  modelPath: "assets/lesson7/asexual/binary.gltf",
                  position:
                      vector.Vector3(-0.2, 0.05, -0.05), // Moved right slightly
                  scale: vector.Vector3(0.03, 0.03, 0.03), // Smaller scale
                ),
                SceneNode(
                  name: "Budding",
                  modelPath: "assets/lesson7/asexual/budding.gltf",
                  position:
                      vector.Vector3(0.0, 0.05, -0.05), // Moved right slightly
                  scale: vector.Vector3(0.03, 0.03, 0.03), // Smaller scale
                ),
                SceneNode(
                  name: "Fragmentation",
                  modelPath: "assets/lesson7/asexual/fragmentation.gltf",
                  position:
                      vector.Vector3(0.2, 0.05, -0.05), // Moved right slightly
                  scale: vector.Vector3(0.03, 0.03, 0.03), // Smaller scale
                ),
                SceneNode(
                  name: "Spore Formation",
                  modelPath: "assets/lesson7/asexual/spore.gltf",
                  position:
                      vector.Vector3(0.4, 0.05, -0.05), // Moved right slightly
                  scale: vector.Vector3(0.03, 0.03, 0.03), // Smaller scale
                ),
                SceneNode(
                  name: "Vegetative Propagation",
                  modelPath: "assets/lesson7/asexual/vegetative.gltf",
                  position:
                      vector.Vector3(-0.2, 0.05, 0.05), // Moved right slightly
                  scale: vector.Vector3(0.03, 0.03, 0.03), // Smaller scale
                ),
                SceneNode(
                  name: "Conjugation",
                  modelPath: "assets/lesson7/conjujubels.gltf",
                  position:
                      vector.Vector3(0.0, 0.05, 0.05), // Moved right slightly
                  scale: vector.Vector3(0.03, 0.03, 0.03), // Smaller scale
                ),
                SceneNode(
                  name: "Transformation",
                  modelPath: "assets/lesson7/transformers.gltf",
                  position:
                      vector.Vector3(0.2, 0.05, 0.05), // Moved right slightly
                  scale: vector.Vector3(0.03, 0.03, 0.03), // Smaller scale
                ),
                SceneNode(
                  name: "Transduction",
                  modelPath: "assets/lesson7/transdududu.gltf",
                  position:
                      vector.Vector3(0.4, 0.05, 0.05), // Moved right slightly
                  scale: vector.Vector3(0.03, 0.03, 0.03), // Smaller scale
                ),
              ];

              // Load the models
              loadModels(
                  sexualReproductionNodes, translation, rotationQuaternion);
              loadModels(
                  asexualReproductionNodes, translation, rotationQuaternion);
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
        rotation:
            vector.Vector4(0, 1, 0, 6.2832), // Rotate 360 degrees around Y-axis
        name: sceneNode.name,
        canScale: false, // Ensure models cannot be pinched
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
      surfaceDetected = true; // Set surfaceDetected to true to hide the text
    });
    arObjectManager!.onNodeTap = (tappedNodes) {
      tappedNodes.forEach((nodeName) {
        List<String> answers = List<String>.from(
            questionAnswerPairs[currentQuestionIndex]['answers']!);

        // Check if the tapped node is a correct answer and hasn't been tapped before
        if (answers.contains(nodeName)) {
          setState(() {
            pairProgress++; // Increment pair progress
            answers.remove(
                nodeName); // Remove the tapped node from the answers list

            // Update the question text to reflect the current progress
            feedbackMessage =
                "Correct! ($pairProgress/${questionAnswerPairs[currentQuestionIndex]['answers'].length})";
            feedbackColor = Colors.green;
            showFeedback = true;

            // Show the definition immediately when all correct answers are tapped
            if (pairProgress ==
                questionAnswerPairs[currentQuestionIndex]['answers'].length) {
              correctAnswers++;
              unlockedButtons[currentQuestionIndex] = true;
              _showDefinition(
                context,
                nodeName,
                questionAnswerPairs[currentQuestionIndex]['definition']!,
                questionAnswerPairs[currentQuestionIndex]['discussionImages']!,
                questionAnswerPairs[currentQuestionIndex]
                    ['title']!, // Use the title from the question data
                isLastQuestion:
                    currentQuestionIndex == questionAnswerPairs.length - 1,
              );
              currentQuestionIndex++;
              pairProgress = 0; // Reset pair progress for the next question
            }
          });
        } else {
          setState(() {
            incorrectAnswers++;
            feedbackMessage = 'Wrong! You tapped on $nodeName';
            feedbackColor = Colors.red;
            wrongAnswers.add(
                'Q: ${questionAnswerPairs[currentQuestionIndex]['question']} - Your answer: $nodeName');
            showFeedback = true;
          });
        }

        // Hide feedback after a short delay
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            showFeedback = false;
            feedbackMessage = '';
          });
        });
      });
    };
  }

  void _showDefinition(
      BuildContext context,
      String part,
      String definition,
      List<String> imagePaths,
      String title, // Added title parameter for the custom title
      {bool isLastQuestion = false}) {
    // Define a mapping of image paths to their corresponding labels
    Map<String, String> imageLabels = {
      "assets/lesson7/for images/Sperm Cell.jpg": "Sperm Cell",
      "assets/lesson7/for images/egg cell.jpg": "Egg Cell",
      "assets/lesson7/for images/male chiken.jpg": "Male Chicken",
      "assets/lesson7/for images/female chiken.jpg": "Female Chicken",
      "assets/lesson7/for images/male frog.jpg": "Male Frog",
      "assets/lesson7/for images/female frog.jpg": "Female Frog",
      "assets/lesson7/for images/bee.jpg": "Bee",
      "assets/lesson7/for images/flowers.jpg": "Flower",
      "assets/lesson7/for images/Conjugation.png": "Conjugation",
      "assets/lesson7/for images/transformation.png": "Transformation",
      "assets/lesson7/for images/Binary Fission.png": "Binary Fission",
      "assets/lesson7/for images/budding .png": "Budding",
      "assets/lesson7/for images/Fragmentation-and-Regeneration1.png":
          "Fragmentation",
      "assets/lesson7/for images/Spore-Formation.png": "Spore Formation",
      "assets/lesson7/for images/vegetative.png": "Vegetative Propagation",
      // Add more as needed...
    };

    double dialogHeight;

    // Adjust height based on content length
    if (definition.length > 200) {
      dialogHeight = 300.0; // Fixed height for long discussions
    } else if (definition.length > 100) {
      dialogHeight = 200.0; // Intermediate height for medium discussions
    } else {
      dialogHeight = 150.0; // Slightly larger height for short discussions
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            height:
                dialogHeight, // Adaptive height for the discussion container
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(definition),
                  SizedBox(height: 10),
                  for (var imagePath in imagePaths)
                    Column(
                      children: [
                        Image.asset(imagePath),
                        SizedBox(height: 5), // Space between image and text
                        Text(
                          imageLabels[imagePath] ?? '',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 20), // Space between each image block
                      ],
                    ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                if (isLastQuestion) {
                  _showScore(); // Only show the score after the last question is closed
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
    if (finalScore < 0)
      finalScore = 0; // Ensure the score does not go below zero
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
                // Close the dialog
                Navigator.of(context).pop();
                // Navigate back to the initial screen
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Heredity_TLA_5_1()),
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
