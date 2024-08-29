import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_TLA/Bacteria_TLA_4_1.dart';
import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_Topics/Bacteria_Topic_4_1_1.dart';
import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_Topics/Bacteria_Topic_4_1_5.dart';
import 'package:capstone/categories/bacteria_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Bacteria_Topic_4_2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Bacteria_Screen(),
          ),
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor:
                        Color(0xFFFF6A6A), // Background color of appbar
                    floating: false,
                    pinned: false,
                    snap: false,
                    expandedHeight: 120.0, // Adjusted expanded height
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        final isTop = constraints.biggest.height <=
                            kToolbarHeight + 16.0; // Margin size

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isTop) ...[
                              // Only show when expanded (not at the top)
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 50.0), // Add left padding
                                child: Text(
                                  'Funji, Protists, and Bacteria', // Title text for the appbar
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                    color:
                                        Colors.white, // Set text color to white
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: 5), // Adjusted spacing between texts
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 50.0), // Add left padding
                                child: Text(
                                  'Topics', // Subtitle text for the appbar
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Colors.white, // Set text color to white
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 50.0,
                                    right: 18.0), // Add left padding
                                child: Text(
                                  '4.2 - Protists', // Additional text for the appbar
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Colors.white, // Set text color to white
                                  ),
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(
                        top: 20, // Adjusted top padding of the leading icon
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white, // Back button icon color
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Bacteria_Screen(),
                          ));
                        },
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            25.0,
                            30.0,
                            25.0,
                            80.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Protists, just like fungi, plants, and animals, are eukaryotic organisms. This group consists of diverse groups of organisms that have different cellular structures, with different means of locomotion and belonging to different trophic levels. Protists consist mostly of unicellular organisms. There are multicellular members but with simple cellular organization because they lack specialized tissues. Based on their slight similarities to the organisms of the other three kingdoms, they are subdivided into three distinct groups: the animallike protists, the plantlike protists, and the funguslike protists. This part will present the protists that affect humans and other organisms because they are disease-causing and some beneficial protists as well.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '\u2022 Protozoans',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'The protozoans are the animal-like protists. They are unicellular, and just like animals, they can move about in their environment. They vary in shape and in the kind of locomotor structures they have: flagella, cilia, or pseudopodia.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Amoeba',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          ' is a unicellular protozoan whose shape is irregular. It can move about in its environment using its pseudopodia (false feet). Entamoeba histolytica, a species of amoeba, is parasitic and can cause amebic dystentery. The parasite lives in the intestine of humans and feeds on its intestinal walls causing bleeding ulcers. The disease can spread when the amoeba forms resistant cysts that can pass out of the body through the feces.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 18.0), // Add left padding
                                child: Container(
                                  width: 600, // Adjust width as needed
                                  height: 250, // Adjust height as needed
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          'assets/images/bacteria/entamoeba histolytica.jpg', // Updated image path
                                          fit: BoxFit
                                              .contain, // Ensure the image fits within the container
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'A schematic diagram of a bacterium',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'Drinking contaminated water and eating contaminated food can infect a person. Certain prescribed drugs can treat amebic dsysentery. It can be prevented by proper sewage disposal and sterilization of contaminated utensils.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/bacteria/#1 trypanosoma.png',
                                                width: 200,
                                                height: 100,
                                                fit: BoxFit.contain,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/bacteria/#2 trypanosoma.png',
                                                width: 200,
                                                height: 100,
                                                fit: BoxFit.contain,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Trypanosoma causing sleeping sickness',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Image.asset(
                                      'assets/images/bacteria/t.jpeg',
                                      width: 350,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'The tsetse fly is the vector of Trypanosoma',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Trypanosoma',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          '  is a protozoan that moves about using its flagella. Trypanosomagambianse is the species that can cause sleeping sickness. The parasite is spread to humans and other domestic animals by the bite of an infected tsetse fly. The parasite multiplies in the blood, releasing toxins. The Symptoms of the disease include weakness,sleepiness, and fever. If untreated, the victim usually dies.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Image.asset(
                                      'assets/images/bacteria/trichonympha.jpg',
                                      width: 400, // Adjust width as needed
                                      height: 250, // Adjust height as needed
                                      fit: BoxFit
                                          .contain, // Ensure the image is fully visible
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Trichonympha',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Trichonympha',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          ' is another flagellated protozoan that lives in symbiosis in the digestive tract of termites. Termites are insects that feed on wood but lack the necessary enzymes to break down wood. Thus, the protozoan breaks down the wood eaten by the termite, and both organisms absorb and use the nutrients.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Table(
                                      columnWidths: {
                                        0: FixedColumnWidth(
                                            200), // Adjust width of the 1st column
                                        1: FixedColumnWidth(
                                            200), // Adjust width of the 2nd column
                                      },
                                      border: TableBorder.all(
                                          width: 1.0,
                                          color:
                                              Colors.grey), // Thin grey border
                                      children: [
                                        TableRow(children: [
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/bacteria/plasmodium.jpg',
                                                    width: 200,
                                                    height: 150,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    'Plasmodium',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/bacteria/Anopheles mosquito.jpg',
                                                    width: 200,
                                                    height: 150,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    'Anopheles Mosquito',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Plasmodium',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          ' compared to the two aforementioned protozoans is a non motile organism and all species are parasitic. Plasmodium is the protozoan that causes malarial fever in humans. The malarial disease is spread by the bite of a mosquito of the genus Anopheles.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'This protozoan exhibits a life cycle involving theasexual spore-producing stage and the sexual stage. Thehumans harbor the asexual stage and the spores invade and multiply within the blood cells. Consequently, the blood cells break, causing the characteristic chills and fever in humans. The mosquito, which is the intermediate host, harbors the sexual stage.',
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Image.asset(
                                      'assets/images/bacteria/plantlike.jpg',
                                      width: 300,
                                      height: 200,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'The dinoflagellate is the plantlike protist that causes red tide.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '\u2022 Plantlike protists ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'contain chlorophyll pigments like plants and, therefore, can carry out photosynthesis. The algae, which may be macroscopic and microscopic, represent this group of protists. Phytoplankton is considered the chief producer of the aquatic environment. One microscopic algal group that impacts other organisms including humans is the unicellular phytoplankton known as the dinoflagellates. These protists reproduce by binary fission and their population can double in a limited span of time if the water is polluted. Excessive increase in the population growth of dinoflagellates is a phenomenon called algal bloom, popularly known as red tide. Red tides produce toxins that kill much of the coastal wildlife and can cause paralysis and other illnesses or even death to humans.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '\u2022 Fungi ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'just like plants and animals, are eukaryotic and multicellular. The only unicellular members are the yeasts. Although some members like the mushroom and the bracket fungus are macroscopic, there are also a lot of members that are microscopic.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'Fungi play a key role in nature and are economically important to human:',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- The mycorrhiza is the genus that lives in symbiosis with some vascular plants, providing them with the essential nutrients in exchange for some materials, which the fungus cannot manufacture.',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- Fungi are decomposers; they break down dead remains of organisms to continue the cycle of materials in the ecosystem.',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- Some species (Agaricus) are edible and rich sources of proteins and other essential nutrients.',
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- The yeasts (Saccharomyces cerevisiae) are widely used in the fermentation industry just like some bacteria.',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(
                                        1), // Adjust column widths as needed
                                    1: FlexColumnWidth(1),
                                    2: FlexColumnWidth(1),
                                  },
                                  border: TableBorder.all(
                                      width: 1.0,
                                      color: Colors.grey), // Border properties
                                  children: [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Image.asset(
                                                'assets/images/bacteria/Penicillium notatum.jpg',
                                                height:
                                                    150, // Adjust image height as needed
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                'Penicillium notatum is the source of the antibiotic penicillin',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TableCell(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Image.asset(
                                                'assets/images/bacteria/2.jpg',
                                                height:
                                                    150, // Adjust image height as needed
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                'Aspergillus flavus is the source of Aspergillic acid',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TableCell(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Image.asset(
                                                'assets/images/bacteria/Saccharomyces cerevisiae.png',
                                                height:
                                                    150, // Adjust image height as needed
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                'Yeast Cells are used in the fermentation industry',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'However, despite these vast benefits, fungi also cause food spoilage and several plant and animal diseases. Plant diseases caused by fungi include smuts and rusts that affect leaves, stems, and roots that could cause severe damage to crops. In humans, fungi can cause ringworm, athlete\'s foot, fungal allergies due to the airborne spores they produce and some other serious diseases. Take note that since fungi are more genetically similar to animals than to plants, fungal diseases in humans are more difficult to treat.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(
                                        1), // Adjust column widths as needed
                                    1: FlexColumnWidth(1),
                                    2: FlexColumnWidth(1),
                                  },
                                  border: TableBorder.all(
                                      width: 1.0,
                                      color: Colors.grey), // Border properties
                                  children: [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Image.asset(
                                                'assets/images/bacteria/ring.jpg', // Update image path here
                                                height:
                                                    150, // Adjust image height as needed
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                'Ringworm is caused by fungus Tinea capitis',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TableCell(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Image.asset(
                                                'assets/images/bacteria/fungi.jpg', // Update image path here
                                                height:
                                                    150, // Adjust image height as needed
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                'The fungus Puccinia hemerocallidis causes leaf rust',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TableCell(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Image.asset(
                                                'assets/images/bacteria/mycorrhizal fungi.jpg', // Update image path here
                                                height:
                                                    150, // Adjust image height as needed
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                'The Mycorrhizal Fungi live in symbiosis with the roots of plants',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Watch this video to learn more about Protists.',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      launch(
                                          'https://www.youtube.com/watch?v=0Cbpgoyo6UU');
                                    },
                                    child: Text(
                                      'Click this link to Watch on YouTube',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  YoutubePlayer(
                                    controller: YoutubePlayerController(
                                      initialVideoId: YoutubePlayer.convertUrlToId(
                                          'https://www.youtube.com/watch?v=0Cbpgoyo6UU')!,
                                      flags: YoutubePlayerFlags(
                                        autoPlay: false,
                                        mute: false,
                                      ),
                                    ),
                                    showVideoProgressIndicator: true,
                                    progressIndicatorColor: Colors.amber,
                                    onReady: () {
                                      // Add custom logic if needed
                                    },
                                    onEnded: (metaData) {
                                      // Add custom logic if needed
                                    },
                                  ),
                                  SizedBox(height: 15),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white, // Set the background color to white
              width: double.infinity, // Set the width to fill the screen
              padding: EdgeInsets.symmetric(
                  vertical: 16.0), // Add padding vertically
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0), // Adjusted left padding
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Bacteria_Topic_4_1_5(),
                          ),
                        );
                      },
                      heroTag: 'prevBtn',
                      child: Icon(
                        Icons.navigate_before,
                        color: Colors.white, // Set icon color to white
                      ),
                      backgroundColor: Color(0xFFFF6A6A),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 15.0), // Adjusted right padding
                    child: FloatingActionButton(
                      onPressed: () {
                        globalVariables.setTopic('lesson4', 8, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Bacteria_TLA_4_1(),
                          ),
                        );
                      },
                      heroTag: 'nextBtn',
                      child: Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                      ),
                      backgroundColor: Color(0xFFFF6A6A),
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

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Bacteria_Topic_4_1_1(),
    ),
  ));
}
