import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen(this.link, {Key key}) : super(key: key);

  final String link;

  @override
  State<StatefulWidget> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;

  Duration videoLength = Duration(days: 365);
  Duration videoPosition;
  double videoVolume = 0.5;
  bool isVideoMute = false;
  bool isFullscreen = false;

  bool isBeingHovered = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.link)
      ..addListener(() => setState(() {
            videoPosition = _controller.value.position;
          }))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          videoLength = _controller.value.duration;
          videoVolume = _controller.value.volume;
        });
      }, onError: (error) {
        print('Unexpected error onVideoPlayerController: $error');
      });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: _controller.value.initialized
                ? InkWell(
                    borderRadius: BorderRadius.circular(4),
                    enableFeedback: true,
                    onHover: (v) {
                      if (kIsWeb)
                        setState(() {
                          isBeingHovered = v;
                        });
                    },
                    onTap: () {
                      if (kIsWeb)
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      else
                        setState(() {
                          isBeingHovered = !isBeingHovered;
                        });
                    },
                    child:
                        Stack(alignment: Alignment.center, children: <Widget>[
                      VideoPlayer(_controller),
                      Visibility(
                          visible: isBeingHovered,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOutQuint,
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                  Colors.black.withAlpha(0),
                                  Colors.black.withAlpha(0),
                                  Colors.black.withAlpha(0),
                                  Colors.black.withAlpha(0),
                                  Colors.black12,
                                  Colors.black45
                                ],
                              ),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  VideoProgressIndicator(
                                    _controller,
                                    allowScrubbing: true,
                                    padding: EdgeInsets.all(10),
                                    colors: VideoProgressColors(
                                        //playedColor: theme.accentColor,
                                        bufferedColor: Colors.white24,
                                        backgroundColor: Colors.white12),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(
                                          _controller.value.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _controller.value.isPlaying
                                                ? _controller.pause()
                                                : _controller.play();
                                          });
                                        },
                                      ),
                                      Text(
                                          '${convertToMinutesSeconds(videoPosition)} / ${convertToMinutesSeconds(videoLength)}',
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                      Spacer(
                                        flex: 1,
                                      ),
                                      IconButton(
                                          icon: Icon(
                                            isVideoMute
                                                ? Icons.volume_off
                                                : animatedVolumeIcon(
                                                    videoVolume),
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              isVideoMute = !isVideoMute;
                                              _controller.setVolume(isVideoMute
                                                  ? 0.0
                                                  : videoVolume);
                                            });
                                          }),
                                      Container(
                                          width: 100,
                                          child: Slider(
                                              activeColor: Colors.white,
                                              inactiveColor: Colors.white24,
                                              value: videoVolume,
                                              min: 0.0,
                                              max: 1.0,
                                              onChanged: (_volume) {
                                                setState(() {
                                                  videoVolume = _volume;
                                                  isVideoMute = false;
                                                  _controller
                                                      .setVolume(_volume);
                                                });
                                              })),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      IconButton(
                                          icon: Icon(
                                            isFullscreen
                                                ? Icons.fullscreen_exit
                                                : Icons.fullscreen,
                                            color: Colors.white24,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              isFullscreen = !isFullscreen;
                                            });
                                          })
                                    ],
                                  )
                                ]),
                          )),
                    ]))
                : Center(
                    child: Container(
                      //color: Colores.principal,
                      margin: EdgeInsets.all(50),
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(),
                    ),
                  )));
  }

  String convertToMinutesSeconds(Duration duration) {
    final minutes = duration.inMinutes < 10
        ? '0${duration.inMinutes}'
        : duration.inMinutes.toString();

    final parsedSeconds = duration.inSeconds % 60;

    final seconds =
        parsedSeconds < 10 ? '0$parsedSeconds' : parsedSeconds.toString();

    return '$minutes:$seconds';
  }

  IconData animatedVolumeIcon(double volume) {
    if (volume == 0)
      return Icons.volume_mute;
    else if (volume < 0.5)
      return Icons.volume_down;
    else
      return Icons.volume_up;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
