import 'package:capstone/Module%20Contents/Heredity/Heredity_TLA/Heredity_TLA_5_1.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_Topics/Heredity_Topic_5_2_3.dart';
import 'package:capstone/categories/heredity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Heredity_Topic_5_3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Heredity_Screen(),
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
                        Color(0xFF64B6AC), // Background color of appbar
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
                                  'Heredity', // Title text for the appbar
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
                                  '5.3 - Sexual Reproduction vs. Asexual Reproduction', // Additional text for the appbar
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
                            builder: (context) => Heredity_Screen(),
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
                                          'Reproduction is one of the basic features of all living things. Reproduction may be through the asexual or the sexual method. Many organisms can reproduce involving the two methods: starfish, planaria, aphids, slime molds, social insects, and more. They do not use the two methods simultaneously. They use them alternately, depending on the conditions of the environment. ',
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
                                          'Asexual reproduction is an energy and time-conserving process obviously because there is no need to spend time and energy in gamete production and fertilization. Through asexual reproduction, organisms in isolation can increase their population even in the absence of a mate. When the environmental conditions are favorable, meaning there is an adequate food supply, conducive and adequate shelter, favorable climate, etc., organisms employ the asexual method so their populations grow exponentially so as to exploit the resources and conditions important for their survival. ',
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
                                          'However, although the organisms can rapidly reproduce, the population of offspring will have the same genetic makeup of the parents. In the absence of mutation that will make them different from their parents, all members will have the same attributes or qualities. In the absence of variations, there is little chance for the offspring to quickly adapt to changing environments that can cause their extinction. If something adverse happens in that environment, all members of the population may be affected, and it is likely that not one of them would survive. ',
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
                                          'Organisms that reproduce sexually yield a smaller number of offspring, and the entire reproductive process takes a longer period of time. However, sexual reproduction ensures a mixing of the gene pool of the species. The variations in the genetic makeup provide the offspring with greater and better chances of surviving and adapting to the changing environment. Another important advantage of the sexual method of reproduction is that it reduces the effects of harmful mutations during gene recombination. This recombination of genes, however, has its own disadvantages. When a desirable characteristic already exists, there is the risk of losing it because of the randomness of the recombination process. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Watch this video to learn more about Sexual Reproduction vs. Asexual Reproduction',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      launch(
                                          'https://youtu.be/fcGDUcGjcyk?si=f4ZJaCYAyPE76T5j');
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
                                          'https://www.youtube.com/watch?v=9AIBnaow5a0')!,
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
                            builder: (context) => Heredity_Topic_5_2_3(),
                          ),
                        );
                      },
                      heroTag: 'prevBtn',
                      child: Icon(
                        Icons.navigate_before,
                        color: Colors.white, // Set icon color to white
                      ),
                      backgroundColor: Color(0xFF64B6AC),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 15.0), // Adjusted right padding
                    child: FloatingActionButton(
                      onPressed: () {
                        globalVariables.setTopic('lesson5', 9, true);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Heredity_TLA_5_1(),
                          ),
                        );
                      },
                      heroTag: 'nextBtn',
                      child: Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                      ),
                      backgroundColor: Color(0xFF64B6AC),
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
      body: Heredity_Topic_5_3(),
    ),
  ));
}
