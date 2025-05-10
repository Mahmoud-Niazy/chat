import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

import '../../../utils/app_constance.dart';
import '../manager/video_player_cubit/video_player_cubit.dart';

class CustomVideoPlayer extends StatelessWidget {
  final String videoUrl;
  final bool autoPlay;
  final bool looping;
  final bool showControls;
  final double aspectRatio;
  final bool isFullscreen;
  final Duration? startAt;

  const CustomVideoPlayer({
    super.key,
    required this.videoUrl,
    this.autoPlay = false,
    this.looping = false,
    this.showControls = true,
    this.aspectRatio = 16 / 12,
    this.isFullscreen = false,
    this.startAt,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value:  context.read<VideoPlayerCubit>()
        ..initializePlayer(
          videoUrl: videoUrl,
          autoPlay: autoPlay,
          looping: looping,
          startAt: startAt,
        ),
      child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
        builder: (context, state) {
          if (state is VideoPlayerInitial || state is VideoPlayerLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is VideoPlayerError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }

          if (state is VideoPlayerReady) {
            return _VideoPlayerContent(
              state: state,
              showControls: showControls,
              aspectRatio: aspectRatio,
              isFullscreen: isFullscreen,
            );
          }

          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }
}

class _VideoPlayerContent extends StatelessWidget {
  final VideoPlayerReady state;
  final bool showControls;
  final double aspectRatio;
  final bool isFullscreen;

  const _VideoPlayerContent({
    required this.state,
    required this.showControls,
    required this.aspectRatio,
    required this.isFullscreen,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VideoPlayerCubit>();

    return PopScope(
      onPopInvokedWithResult: (p, n) async {
        if (isFullscreen) Navigator.pop(context);
      },
      child: GestureDetector(
        onTap: () => cubit.toggleOverlay(),
        child: AspectRatio(
          aspectRatio: isFullscreen
              ? MediaQuery.of(context).size.aspectRatio
              : aspectRatio,
          child: Stack(
            children: [
              Positioned.fill(child: VideoPlayer(state.controller)),
              if (showControls && state.showOverlay)
                _VideoPlayerOverlay(
                  state: state,
                  isFullscreen: isFullscreen,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VideoPlayerOverlay extends StatelessWidget {
  final VideoPlayerReady state;
  final bool isFullscreen;

  const _VideoPlayerOverlay({
    required this.state,
    required this.isFullscreen,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VideoPlayerCubit>();

    return Container(
      color: Colors.black45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                    color: Colors.white,
                  ),
                  onPressed: () => _toggleFullScreen(context),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              state.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 48,
            ),
            onPressed: () => cubit.togglePlayPause(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                VideoProgressIndicator(
                  state.controller,
                  allowScrubbing: true,
                  colors:  VideoProgressColors(
                    playedColor: AppConstance.primaryColor,
                    bufferedColor: Colors.grey,
                    backgroundColor: Colors.white24,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(state.currentPosition),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      _formatDuration(state.totalDuration),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.replay_10, color: Colors.white),
                      onPressed: () => cubit.seekRelative(const Duration(seconds: -10)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.forward_10, color: Colors.white),
                      onPressed: () => cubit.seekRelative(const Duration(seconds: 10)),
                    ),
                    IconButton(
                      icon: Icon(
                        state.isLooping ? Icons.loop : Icons.loop_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () => cubit.toggleLooping(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleFullScreen(BuildContext context) async {
    final cubit = context.read<VideoPlayerCubit>();
    final wasPlaying = state.isPlaying;

    if (isFullscreen) {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      Navigator.pop(context);
    } else {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              top: false,
              bottom: false,
              child: CustomVideoPlayer(
                videoUrl: state.controller.dataSource,
                autoPlay: wasPlaying,
                looping: state.isLooping,
                showControls: true,
                aspectRatio: MediaQuery.of(context).size.aspectRatio,
                isFullscreen: true,
                startAt: state.currentPosition,
              ),
            ),
          ),
        ),
      ).then((_) async {
        await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      });
    }
    cubit.toggleFullScreen(!isFullscreen);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$minutes:$seconds';
  }
}



// import 'package:e_learning/core/widgets/video_player/manager/video_player_cubit/video_player_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:video_player/video_player.dart';
// import 'package:flutter/services.dart';
//
// extension DurationClampExtension on Duration {
//   Duration clamp(Duration min, Duration max) {
//     if (this < min) return min;
//     if (this > max) return max;
//     return this;
//   }
// }
//
// class CustomVideoPlayer extends StatefulWidget {
//   final String videoUrl;
//   final bool autoPlay;
//   final bool looping;
//   final bool showControls;
//   final double aspectRatio;
//   final bool isFullscreen;
//   final Duration? startAt; // 👈 NEW to handle seek position
//
//   const CustomVideoPlayer({
//     Key? key,
//     required this.videoUrl,
//     this.autoPlay = false,
//     this.looping = false,
//     this.showControls = true,
//     this.aspectRatio = 16 / 12,
//     this.isFullscreen = false,
//     this.startAt, // 👈 receive starting position
//   }) : super(key: key);
//
//   @override
//   State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
// }
//
// class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;
//   bool _isInitialized = false;
//   bool _disposed = false;
//   bool _showOverlay = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeVideoPlayer();
//   }
//
//   @override
//   void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.videoUrl != widget.videoUrl) {
//       _controller.dispose();
//       _initializeVideoPlayer();
//     }
//   }
//
//   @override
//   void dispose() {
//     _disposed = true;
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Future<void> _initializeVideoPlayer() async {
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
//       ..addListener(_videoListener)
//       ..setLooping(widget.looping);
//
//     try {
//       await _controller.initialize();
//       if (!_disposed && mounted) {
//         if (widget.startAt != null) {
//           await _controller.seekTo(widget.startAt!.clamp(
//               Duration.zero, _controller.value.duration));
//         }
//         if (widget.autoPlay) {
//           _controller.play();
//           _isPlaying = true;
//         }
//         setState(() {
//           _isInitialized = true;
//         });
//       }
//     } catch (e) {
//       if (!_disposed && mounted) {
//         setState(() {
//           _isInitialized = false;
//         });
//       }
//     }
//   }
//
//   void _videoListener() {
//     if (!_disposed && mounted) {
//       var cubit = context.read<VideoPlayerCubit>();
//       cubit.setPosition(_controller.value.position);
//       setState(() {
//         _isPlaying = _controller.value.isPlaying;
//       });
//     }
//   }
//
//   void _toggleFullscreen(BuildContext context) async {
//     final currentPosition = _controller.value.position;
//     final wasPlaying = _controller.value.isPlaying;
//
//     if (widget.isFullscreen) {
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//       Navigator.pop(context);
//     } else {
//       await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) =>
//               Scaffold(
//             backgroundColor: Colors.black,
//             body: SafeArea(
//               top: false,
//               bottom: false,
//               child: CustomVideoPlayer(
//                 videoUrl: widget.videoUrl,
//                 autoPlay: wasPlaying,
//                 looping: widget.looping,
//                 showControls: widget.showControls,
//                 aspectRatio: MediaQuery.of(context).size.aspectRatio,
//                 isFullscreen: true,
//                 startAt: currentPosition, // 👈 pass the saved position
//               ),
//             ),
//           ),
//         ),
//       ).then((_) async {
//         SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//       });
//     }
//   }
//
//   void _togglePlayPause() {
//     if (_controller.value.isPlaying) {
//       _controller.pause();
//     } else {
//       _controller.play();
//     }
//   }
//
//   void _seekRelative(Duration offset) {
//     final position = _controller.value.position + offset;
//     _controller.seekTo(position.clamp(Duration.zero, _controller.value.duration));
//   }
//
//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return '${twoDigits(duration.inHours)}:$minutes:$seconds';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       onPopInvokedWithResult: (p, n) async {
//         if (widget.isFullscreen) Navigator.pop(context);
//       },
//       child: AspectRatio(
//         aspectRatio: widget.isFullscreen
//             ? MediaQuery.of(context).size.aspectRatio
//             : widget.aspectRatio,
//         child: GestureDetector(
//           onTap: () {
//             setState(() {
//               _showOverlay = !_showOverlay;
//             });
//           },
//           child: Stack(
//             children: [
//               if (_isInitialized)
//                 Positioned.fill(child: VideoPlayer(_controller))
//               else
//                 const Center(child: CircularProgressIndicator()),
//
//               if (widget.showControls && _showOverlay && _isInitialized)
//                 Positioned.fill(
//                   child: Container(
//                     color: Colors.black45,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               IconButton(
//                                 icon: Icon(
//                                   widget.isFullscreen
//                                       ? Icons.fullscreen_exit
//                                       : Icons.fullscreen,
//                                   color: Colors.white,
//                                 ),
//                                 onPressed: () => _toggleFullscreen(context),
//                               ),
//                             ],
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             _controller.value.isPlaying
//                                 ? Icons.pause
//                                 : Icons.play_arrow,
//                             color: Colors.white,
//                             size: 48,
//                           ),
//                           onPressed: _togglePlayPause,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             children: [
//                               VideoProgressIndicator(
//                                 _controller,
//                                 allowScrubbing: true,
//                                 colors: const VideoProgressColors(
//                                   playedColor: Colors.red,
//                                   bufferedColor: Colors.grey,
//                                   backgroundColor: Colors.white24,
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     _formatDuration(_controller.value.position),
//                                     style: const TextStyle(color: Colors.white),
//                                   ),
//                                   Text(
//                                     _formatDuration(_controller.value.duration),
//                                     style: const TextStyle(color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 8),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   IconButton(
//                                     icon: const Icon(Icons.replay_10, color: Colors.white),
//                                     onPressed: () => _seekRelative(const Duration(seconds: -10)),
//                                   ),
//                                   IconButton(
//                                     icon: const Icon(Icons.forward_10, color: Colors.white),
//                                     onPressed: () => _seekRelative(const Duration(seconds: 10)),
//                                   ),
//                                   IconButton(
//                                     icon: Icon(
//                                       _controller.value.isLooping
//                                           ? Icons.loop
//                                           : Icons.loop_outlined,
//                                       color: Colors.white,
//                                     ),
//                                     onPressed: () {
//                                       _controller.setLooping(!_controller.value.isLooping);
//                                       setState(() {});
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
