import 'package:capstone/Module%20Contents/Microscopy/Microscopy_Topics/Microscopy_Topic_1_1.dart';
import 'package:capstone/categories/microscopy_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:video_player/video_player.dart';

class MicroscopyILOScreen extends StatefulWidget {
  @override
  _MicroscopyILOScreenState createState() => _MicroscopyILOScreenState();
}

class _MicroscopyILOScreenState extends State<MicroscopyILOScreen> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    // Initialize the video controller
    _videoController = VideoPlayerController.asset(
      'assets/videos/microscopy/x2mate.com-How to Focus a Microscope & How the Field of View Changes.mp4',
    )..initialize().then((_) {
        // Ensure the first frame is displayed
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MicroscopyScreen(),
          ),
          (Route<dynamic> route) => false,
        );
        return false;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xFFFFA551), // Background color of appbar
              pinned: true, // Make the appbar pinned
              expandedHeight: 120.0, // Height of the appbar
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 50, // Adjusted left padding
                  right: 10, // Adjusted right padding
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:
                      MainAxisAlignment.end, // Align title at the bottom
                  children: [
                    Text(
                      'Microscopy', // Title text for the appbar
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                    SizedBox(height: 5), // Adjusted spacing between texts
                    Text(
                      'Intended Learning Outcomes', // Subtitle text for the appbar
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'ILO 1.1  I   Identify the parts of the microscope and their function', // Additional text for the appbar
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                  ],
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(
                  top: 20, // Adjusted top padding of the leading icon
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios), // Back button icon
                  color: Colors.white, // Back button icon
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MicroscopyScreen(),
                      ),
                    );
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
                      20.0,
                    ), // Padding for content
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ILO: At the end of this lesson, students should attain the following:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        Text(
                            '• Identify parts of the microscope and their functions;',
                            style: TextStyle(fontSize: 14)),
                        SizedBox(height: 12),
                        Text('• Focus specimens using the compound microscope;',
                            style: TextStyle(fontSize: 14)),
                        SizedBox(height: 30),
                        Text(
                          'Watch the Video Below:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        _videoController.value.isInitialized
                            ? Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio:
                                        _videoController.value.aspectRatio,
                                    child: VideoPlayer(_videoController),
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _videoController.value.isPlaying
                                                ? _videoController.pause()
                                                : _videoController.play();
                                          });
                                        },
                                        icon: Icon(
                                          _videoController.value.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            globalVariables.setTopic('lesson1', 1, true);
            // Navigate to Microscopy_Topic_1_1
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Microscopy_Topic_1_1(),
              ),
            );
          },
          child: const Icon(
            Icons.navigate_next,
            color: Colors.white, // Set icon color to white
          ),
          backgroundColor: Color(0xFFFFA551), // Button color set to hex #729B79
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.endFloat, // Positioning the button
      ),
    );
  }
}
