// ignore: file_names
// ignore_for_file: file_names

import 'package:qstar/constant.dart';
import 'package:flutter/material.dart';
import 'package:qstar/screen/feed/feed.dart';
import 'package:video_player/video_player.dart';
import 'write_caption_widget.dart';

List _usersd = [
  const Item(
      'Film & Animation',
      Icon(
        Icons.video_collection_sharp,
        color: mPrimaryColor,
      )),
  const Item(
      'Autos & Vehicles',
      Icon(
        Icons.video_collection_sharp,
        color: mPrimaryColor,
      )),
  const Item(
      'Music',
      Icon(
        Icons.video_collection_sharp,
        color: mPrimaryColor,
      )),
  const Item(
      'Pets & Animals',
      Icon(
        Icons.video_collection_sharp,
        color: mPrimaryColor,
      )),
  const Item(
      'Sports',
      Icon(
        Icons.video_collection_sharp,
        color: mPrimaryColor,
      )),
  const Item(
      'Travel & Events',
      Icon(
        Icons.video_collection_sharp,
        color: mPrimaryColor,
      )),
  const Item(
      'Gaming',
      Icon(
        Icons.video_collection_sharp,
        color: mPrimaryColor,
      )),
  const Item(
      '	People & Blogs',
      Icon(
        Icons.video_collection_sharp,
        color: mPrimaryColor,
      )),
  const Item(
      'News & Politics',
      Icon(
        Icons.video_collection_sharp,
        color: mPrimaryColor,
      )),
  const Item(
      'Comedy',
      Icon(
        Icons.video_collection_sharp,
        color: mPrimaryColor,
      )),
  const Item(
      'Entertainment',
      Icon(
        Icons.video_collection_sharp,
        color: mPrimaryColor,
      )),
  const Item(
      'Style',
      Icon(
        Icons.video_collection_sharp,
        color: mPrimaryColor,
      )),
  const Item(
      'Education',
      Icon(
        Icons.video_collection_sharp,
        color: mPrimaryColor,
      )),
  const Item(
      'Science & Technology',
      Icon(
        Icons.video_collection_sharp,
        color: mPrimaryColor,
      )),
  const Item(
      'Nonprofits & Activism',
      Icon(
        Icons.video_collection_sharp,
        color: mPrimaryColor,
      )),
];

class VideoPreview extends StatefulWidget {
  final String imagePath;

  // ignore: use_key_in_widget_constructors
  const VideoPreview({required this.imagePath});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<VideoPreview> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(widget.imagePath);

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: mPrimaryColor,
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text(
          "Preview video",
          style: TextStyle(
            color: mPrimaryColor,
            fontSize: 27,
            fontFamily: 'font1',
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            iconSize: 30.0,
            color: mPrimaryColor,
            onPressed: () {},
          ),
        ],
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: SingleChildScrollView(
        child: Stack(children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return Expanded(
                  // Use the VideoPlayer widget to display the video.
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: VideoPlayer(_controller)),
                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              height: 700,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const WriteCaptionWidget(),
                  const Divider(
                    height: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: ListTile(
                      title: const Text(
                        'Tag People',
                        style: TextStyle(color: Colors.white),
                      ),
                      dense: true,
                      onTap: () {},
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            children: [
                              DropdownButton(
                                items: _usersd
                                    .map(
                                      (user) => DropdownMenuItem(
                                        value: user,
                                        child: Row(
                                          children: [
                                            user.icon,
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              user.name,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    value;
                                  });
                                },
                                hint: const Text(
                                  "Select Categories ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: ListTile(
                      title: const Text(
                        'Setting',
                        style: TextStyle(color: Colors.white),
                      ),
                      dense: true,
                      onTap: () {},
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
            ),
          )
        ]),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
