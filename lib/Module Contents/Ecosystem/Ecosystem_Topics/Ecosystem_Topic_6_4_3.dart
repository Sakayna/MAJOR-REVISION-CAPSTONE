import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_4_2.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_5.dart';
import 'package:capstone/categories/ecosystem.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Ecosystem_Topic_6_4_3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Ecosystem_Screen(),
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
                        Color(0xFFA846A0), // Background color of appbar
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
                                  'Ecosystem', // Title text for the appbar
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
                                  '6.4.3 - Ecological Balance', // Additional text for the appbar
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
                            builder: (context) => Ecosystem_Screen(),
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
                                          'The discussions on food chain and food web provided you with the idea on how energy enters the living system and how it is transferred from one organism to another. Now the discussion will be focused on the question: What would happen if one link or level in the food chain is disturbed, either by natural factors or man-made factors? ',
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
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Every link in the food chain is connected to at least two others. Use the food web shown in Figure 5.14. Let us say for example that the vegetation (grasses) in the ecosystem has declined because the area has been paved over for the building of a shopping mall or a sports complex. How will such human intervention affect the food chain in the area? As the number of autotrophs decline, definitely the herbivore population will be very much affected. There will be fewer foods for rabbits, grasshoppers, and mice. As the herbivores\' population declines, the primary carnivores (lizard and snake) have fewer foods to eat, and the same goes for the topmost consumer (hawk). Thus, when one trophic level in the food chain is disturbed, almost all the other links are affected. Failure to adapt leads to the decline in the biomass of the ecosystem, and as a consequence, the ecosystem becomes out of balance. Biomass is the amount of energy in living organisms. ',
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
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'The loss of biomass can happen not only in the loss or decline in the autotrophs level but even in the second or third level. Consider the following food chain.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(
                                        8.0), // Adjust padding as needed
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colors.blue), // Box outline color
                                    ),
                                    child: Text(
                                      'Rice plants',
                                      style: TextStyle(
                                        fontSize:
                                            14, // Adjust font size as needed
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          10), // Spacing between the text and arrow
                                  Icon(Icons.arrow_forward,
                                      size: 24), // Arrow pointing right
                                  SizedBox(
                                      width:
                                          10), // Spacing between the arrow and text
                                  Container(
                                    padding: EdgeInsets.all(
                                        8.0), // Adjust padding as needed
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colors.blue), // Box outline color
                                    ),
                                    child: Text(
                                      'Mice',
                                      style: TextStyle(
                                        fontSize:
                                            14, // Adjust font size as needed
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          10), // Spacing between the text and arrow
                                  Icon(Icons.arrow_forward,
                                      size: 24), // Arrow pointing right
                                  SizedBox(
                                      width:
                                          10), // Spacing between the arrow and text
                                  Container(
                                    padding: EdgeInsets.all(
                                        8.0), // Adjust padding as needed
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colors.blue), // Box outline color
                                    ),
                                    child: Text(
                                      'Owls',
                                      style: TextStyle(
                                        fontSize:
                                            14, // Adjust font size as needed
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
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
                                          'What do you think will happen if excessive hunting had removed the owls in the food chain? If the owl population will be removed in the food chain, there will be an increase in the population of the mice because of the absence of the owl population that keeps the mice population in check. Consequently, the mice population increases, and the rice plants in the area will be devastated.',
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
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'However, the effect of the removal of one trophic level is not always negative. Consider this food chain in the discussion.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(
                                              8.0), // Adjust padding as needed
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors
                                                    .green), // Box outline color for Vegetable Crop
                                          ),
                                          child: Text(
                                            'Vegetable Crop',
                                            style: TextStyle(
                                              fontSize:
                                                  14, // Adjust font size as needed
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Spacing between the text and arrow
                                        Icon(Icons.arrow_forward,
                                            size: 24), // Arrow pointing right
                                        SizedBox(
                                            width:
                                                10), // Spacing between the arrow and text
                                        Container(
                                          padding: EdgeInsets.all(
                                              8.0), // Adjust padding as needed
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors
                                                    .blue), // Box outline color for Caterpillars
                                          ),
                                          child: Text(
                                            'Caterpillars',
                                            style: TextStyle(
                                              fontSize:
                                                  14, // Adjust font size as needed
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Spacing between the text and arrow
                                        Icon(Icons.arrow_forward,
                                            size: 24), // Arrow pointing right
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            20), // Vertical spacing between rows
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(
                                              8.0), // Adjust padding as needed
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors
                                                    .red), // Box outline color for Birds
                                          ),
                                          child: Text(
                                            'Birds',
                                            style: TextStyle(
                                              fontSize:
                                                  14, // Adjust font size as needed
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Spacing between the text and arrow
                                        Icon(Icons.arrow_forward,
                                            size: 24), // Arrow pointing right
                                        SizedBox(
                                            width:
                                                10), // Spacing between the arrow and text
                                        Container(
                                          padding: EdgeInsets.all(
                                              8.0), // Adjust padding as needed
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors
                                                    .orange), // Box outline color for Fox
                                          ),
                                          child: Text(
                                            'Fox',
                                            style: TextStyle(
                                              fontSize:
                                                  14, // Adjust font size as needed
                                            ),
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
                                          'Suppose excessive hunting had decreased or removed the fox from the food chain, what do you think will happen? Of course, the population of the birds would increase and such an increase would put pressure on the population of the caterpillars. Consequently, the caterpillars\' population will decrease, removing pressure on the vegetable crop so its population will increase.',
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
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Some species are so important to an entire ecosystem. Removing them or seriously impacting them can produce major changes. Species with ecological niches that influence or affect many other species involved in the food web are called keystone species. Examples are sea otters, sea urchins, mussels and other shellfishes.',
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
                                      'Watch this video to learn more about Ecological balance',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      launch(
                                          'https://youtu.be/Je7gFeNX3OA?si=T3X9Wy4R3yulAHkT');
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
                                          'https://youtu.be/Je7gFeNX3OA?si=T3X9Wy4R3yulAHkT')!,
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
                            builder: (context) => Ecosystem_Topic_6_4_2(),
                          ),
                        );
                      },
                      heroTag: 'prevBtn',
                      child: Icon(
                        Icons.navigate_before,
                        color: Colors.white, // Set icon color to white
                      ),
                      backgroundColor: Color(0xFFA846A0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 15.0), // Adjusted right padding
                    child: FloatingActionButton(
                      onPressed: () {
                        globalVariables.setTopic('lesson6', 10, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Ecosystem_Topic_6_5(),
                          ),
                        );
                      },
                      heroTag: 'nextBtn',
                      child: Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                      ),
                      backgroundColor: Color(0xFFA846A0),
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
      body: Ecosystem_Topic_6_4_3(),
    ),
  ));
}
