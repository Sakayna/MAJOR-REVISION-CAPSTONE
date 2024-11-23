import 'package:capstone/Module%20Contents/Microscopy/Microscopy_Topics/Microscopy_Topic_1_1.dart';
import 'package:capstone/categories/microscopy_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class MicroscopyILOScreen extends StatefulWidget {
  @override
  _MicroscopyILOScreenState createState() => _MicroscopyILOScreenState();
}

class _MicroscopyILOScreenState extends State<MicroscopyILOScreen> {
  late VideoPlayerController _videoController;
  Timer? _sliderTimer;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(
      'assets/videos/microscopy/microscope1.mp4',
    )..initialize().then((_) {
        setState(() {});
      });

    // Start a timer to update the slider when the video is playing
    _sliderTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!_isDragging && _videoController.value.isInitialized) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _sliderTimer?.cancel(); // Stop the timer when the widget is disposed
    _videoController.dispose(); // Dispose the video controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    return WillPopScope(
      onWillPop: () async {
        if (_videoController.value.isPlaying) {
          _videoController.pause();
        }
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
              backgroundColor: Color(0xFFFFA551),
              pinned: true,
              expandedHeight: 120.0,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 50,
                  right: 10,
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Microscopy',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Intended Learning Outcomes',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'ILO 1.1  I   Identify the parts of the microscope and their function',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    if (_videoController.value.isPlaying) {
                      _videoController.pause();
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MicroscopyScreen()),
                    );
                  },
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 20.0),
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
                                  Slider(
                                    value: _isDragging
                                        ? _videoController
                                            .value.position.inSeconds
                                            .toDouble()
                                        : _videoController
                                            .value.position.inSeconds
                                            .toDouble(),
                                    min: 0.0,
                                    max: _videoController
                                        .value.duration.inSeconds
                                        .toDouble(),
                                    onChanged: (value) {
                                      setState(() {
                                        _isDragging = true;
                                        _videoController.seekTo(
                                          Duration(seconds: value.toInt()),
                                        );
                                      });
                                    },
                                    onChangeEnd: (value) {
                                      _isDragging = false;
                                    },
                                  ),
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
                                      Text(
                                        "${_videoController.value.position.inMinutes}:${(_videoController.value.position.inSeconds % 60).toString().padLeft(2, '0')}",
                                      ),
                                      Text(
                                        " / ${_videoController.value.duration.inMinutes}:${(_videoController.value.duration.inSeconds % 60).toString().padLeft(2, '0')}",
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
            if (_videoController.value.isPlaying) {
              _videoController.pause();
            }
            globalVariables.setTopic('lesson1', 1, true);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Microscopy_Topic_1_1(),
              ),
            );
          },
          child: const Icon(Icons.navigate_next, color: Colors.white),
          backgroundColor: Color(0xFFFFA551),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
