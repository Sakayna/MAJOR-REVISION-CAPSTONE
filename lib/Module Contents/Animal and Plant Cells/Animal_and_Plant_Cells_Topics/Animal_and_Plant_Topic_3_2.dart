import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_Topics/Animal_and_Plant_Topic_3_1.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_Topics/Animal_and_Plant_Topic_3_3.dart';
import 'package:capstone/categories/animal_and_plant_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Animal_and_Plant_Topic_3_2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Animal_and_Plant_Screen(),
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
                        Color(0xFFA1C084), // Background color of appbar
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
                                  'Animal and Plant Cells', // Title text for the appbar
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
                                  '3.2: Parts and Functions of Typical Cell', // Additional text for the appbar
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
                            builder: (context) => Animal_and_Plant_Screen(),
                          ));
                        },
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 80.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(width: 40),
                                    ),
                                    TextSpan(
                                      text:
                                          'Cells of eukaryotes are complex and highly organized. This is because of the presence of numerous and varied structures called ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'organelles. ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    TextSpan(
                                      text:
                                          'Organelles are small membrane-bound structures that perform specific functions that make life possible. The functions of the organelles are much like the functions of the different organs in multicellular organisms. Organelles exist in various shapes and sizes, and they are embedded in the cytoplasm. Below shows the schematic diagram of the ultrastructure of a plant cell and an animal cell.',
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
                                    WidgetSpan(
                                      child: SizedBox(width: 40),
                                    ),
                                    TextSpan(
                                      text:
                                          'The numbered parts in the figure are the different organelles. The table below identifies and gives the functions of the different numbered organelles.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 30),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'The Parts of a Typical Cell and Their Function ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Table(
                                    columnWidths: {
                                      0: FixedColumnWidth(
                                          120), // Width of the 1st column
                                      1: FixedColumnWidth(
                                          200), // Width of the 2nd column
                                      2: FixedColumnWidth(
                                          300), // Width of the 3rd column
                                    },
                                    border: TableBorder.all(),
                                    children: [
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text('Organelle')),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text('Structure')),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                                Center(child: Text('Function')),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('1. Cell wall'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'It is a nonliving component composed of cellulose, a polysaccharide.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Provides mechanical support and maintains cell shape in plant cells.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('2. Plasma membrane'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'It is flexible and elastic. It is composed of double layers of phospholipid, proteins, carbohydrates, and steroids.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Selectively permeable; regulates the entry and exit of materials like ions and organic molecules.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('3. Mitochondrion'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'It is a double-membrane structure. The inner membrane is folded forming cristae.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Provides energy for the cell in the form of Adenosine Triphosphate (ATP).'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('4. Vacuole'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'A compartment covered by a single membrane called tonoplast.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Stores water, food, or waste for the cells.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('5. Golgi apparatus'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Consists of stacks of single membranes that are connected to the plasma membrane and endoplasmic reticulum.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Sorts, packages, and modifies proteins for secretion.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('6. Cytoplasm'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'The complex fluid that fills the cell. The outer cytoplasm (exoplasm) is gel-like, while the inner cytoplasm is fluid (sol-like). The fluid part is capable of streaming (cyclosis).'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Matrix of the different cellular organelles; distribution of materials throughout the cell due to cyclosis.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('7. Nuclear membrane'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'It is a double-layered membrane that encloses the nucleus. The outer membrane is porous.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Separates the nuclear contents from the contents of the cytoplasm.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('8. Nucleolus'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'It is the dense, spherical body inside the nucleus. It contains the nucleic acid RNA.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Synthesis of RNA and production of ribosomes.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                '9. Nucleoplasm/Nuclear sap'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'It is the gel-like material that fills the nucleus.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Functions as the matrix of the chromosomes and nucleolus.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('10. Chromosomes'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'They are highly coiled structures that form a network over the nucleoplasm.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Carriers of genes responsible for transmitting hereditary characteristics.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('11. Nucleus'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'It is the spherical body that is composed of organelles 7 to 10.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'The control center of the cell; directs and coordinates all cellular activities.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                '12. Endoplasmic reticulum'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'It is the network of channels composed of a single membrane that may be bumpy if it contains ribosomes (Rough ER) or smooth (SER) if it does not contain ribosomes.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'They play an important role in the formation of the skeletal framework.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('13. Chloroplastid'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'It is the double-membrane structure that contains chlorophyll pigments.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Provides the green color of plants; functions for photosynthesis.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('14. Centrioles'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'They are two small rods that lie at right angles to each other. Each rod is surrounded with tiny microtubules arranged like the spokes of a wheel.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Formation of spindle fibers during cell division; function as the anchor for the cytoskeletons.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('15. Lysosome'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'It is a single membrane compartment containing powerful hydrolytic enzymes. It is referred to as the "suicide bag" of the cell.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Simplifies/Breaks down complex materials.'),
                                          ),
                                        )
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(width: 40),
                                    ),
                                    TextSpan(
                                      text:
                                          'The numbered parts in the figure are the different organelles. The table below identifies and gives the functions of the different numbered organelles.',
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
                                    WidgetSpan(
                                      child: SizedBox(width: 40),
                                    ),
                                    TextSpan(
                                      text:
                                          '1. Ribosomes that are found attached to the endoplasmic reticulum or free floating in the cytoplasm (free ribosomes). They use the RNA synthesized by the nucleolus in making specific amino acid, They are referred to as the "protein factories."',
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
                                    WidgetSpan(
                                      child: SizedBox(width: 40),
                                    ),
                                    TextSpan(
                                      text:
                                          '2. Cytoskeletons are the network of fibers that are scattered throughout the entire cytoplasm and interconnecting some organelles. One type, the microtubules, functions in maintaining the shape of the cells and aids in the movement of some organelles. The second type are the microfilaments, which provide contractility to some cells and aid in the changing of shapes of some cells.',
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
                                    WidgetSpan(
                                      child: SizedBox(width: 40),
                                    ),
                                    TextSpan(
                                      text:
                                          '3. Microbodies are the very tiny, membrane-bound organelles that are scattered throughout the cytoplasm together with the free ribosomes. They contain enzymes that are essential in neutralizing toxic materials that are products of cellular metabolism. Examples are the enzymes peroxisomes that break down hydrogen peroxide and proteasomes that break down damaged or unwanted proteins in the cell.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                  height:
                                      20), // Space between cells and the text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Watch this video to learn more about why the cell is considered the basic structural and functional unit of all organisms',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      launch(
                                          'https://www.youtube.com/watch?v=-TkC7BmdGcY');
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
                                          'https://www.youtube.com/watch?v=-TkC7BmdGcY')!,
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
                            builder: (context) => Animal_and_Plant_Topic_3_1(),
                          ),
                        );
                      },
                      heroTag: 'prevBtn',
                      child: Icon(
                        Icons.navigate_before,
                        color: Colors.white, // Set icon color to white
                      ),
                      backgroundColor: Color(0xFFA1C084),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 15.0), // Adjusted right padding
                    child: FloatingActionButton(
                      onPressed: () {
                        globalVariables.setTopic('lesson3', 3, true);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Animal_and_Plant_Topic_3_3(),
                          ),
                        );
                      },
                      heroTag: 'nextBtn',
                      child: Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                      ),
                      backgroundColor: Color(0xFFA1C084),
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
      body: Animal_and_Plant_Topic_3_2(),
    ),
  ));
}