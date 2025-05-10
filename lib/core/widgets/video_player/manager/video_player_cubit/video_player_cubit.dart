import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

extension DurationClampExtension on Duration {
  Duration clamp(Duration min, Duration max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }
}

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerController? controller;
  bool _showOverlay = true;
  Timer? _overlayTimer;

  VideoPlayerCubit() : super(VideoPlayerInitial());

  void initializePlayer({
    required String videoUrl,
    bool autoPlay = false,
    bool looping = false,
    Duration? startAt,
  }) async {
    emit(VideoPlayerLoading());
    try {
      controller?.dispose();
      controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
        ..addListener(_videoListener)
        ..setLooping(looping);

      await controller!.initialize();

      if (startAt != null) {
        await controller!.seekTo(startAt.clamp(
            Duration.zero,
            controller!.value.duration
        ));
      }

      if (autoPlay) {
        controller!.play();
      }

      emit(VideoPlayerReady(
        controller: controller!,
        isPlaying: controller!.value.isPlaying,
        isFullScreen: false,
        showOverlay: _showOverlay,
        currentPosition: controller!.value.position,
        totalDuration: controller!.value.duration,
        isLooping: looping,
      ));
    } catch (e) {
      emit(VideoPlayerError(errorMessage: e.toString()));
    }
  }

  void _videoListener() {
    if (controller != null && controller!.value.isInitialized) {
      emit(state.copyWith(
        currentPosition: controller!.value.position,
        isPlaying: controller!.value.isPlaying,
      ));
    }
  }

  void togglePlayPause() {
    if (controller == null) return;
    if (controller!.value.isPlaying) {
      controller!.pause();
    } else {
      controller!.play();
      _startOverlayTimer();
    }
  }

  void toggleOverlay() {
    _showOverlay = !_showOverlay;
    emit(state.copyWith(showOverlay: _showOverlay));
    if (_showOverlay) {
      _startOverlayTimer();
    } else {
      _overlayTimer?.cancel();
    }
  }

  void _startOverlayTimer() {
    _overlayTimer?.cancel();
    _overlayTimer = Timer(const Duration(seconds: 3), () {
      _showOverlay = false;
      emit(state.copyWith(showOverlay: false));
    });
  }

  void seekRelative(Duration offset) {
    if (controller == null) return;
    final position = controller!.value.position + offset;
    controller!.seekTo(position.clamp(
        Duration.zero,
        controller!.value.duration
    ));
    _startOverlayTimer();
  }

  void toggleLooping() {
    if (controller == null) return;
    controller!.setLooping(!controller!.value.isLooping);
    emit(state.copyWith(isLooping: controller!.value.isLooping));
    _startOverlayTimer();
  }

  void toggleFullScreen(bool isFullScreen) {
    if (state is! VideoPlayerReady) return;
    emit((state as VideoPlayerReady).copyWith(isFullScreen: isFullScreen));
    _startOverlayTimer();
  }

  void dispose() {
    _overlayTimer?.cancel();
    controller?.removeListener(_videoListener);
    controller?.dispose();
    controller = null;
    emit(VideoPlayerInitial());
  }

  @override
  Future<void> close() {
    dispose();
    return super.close();
  }
}

abstract class VideoPlayerState {
  const VideoPlayerState();

  VideoPlayerState copyWith({
    Duration? currentPosition,
    bool? isPlaying,
    bool? isFullScreen,
    bool? showOverlay,
    bool? isLooping,
  });
}

class VideoPlayerInitial extends VideoPlayerState {
  @override
  VideoPlayerState copyWith({
    Duration? currentPosition,
    bool? isPlaying,
    bool? isFullScreen,
    bool? showOverlay,
    bool? isLooping,
  }) {
    return this;
  }
}

class VideoPlayerLoading extends VideoPlayerState {
  @override
  VideoPlayerState copyWith({
    Duration? currentPosition,
    bool? isPlaying,
    bool? isFullScreen,
    bool? showOverlay,
    bool? isLooping,
  }) {
    return this;
  }
}

class VideoPlayerReady extends VideoPlayerState {
  final VideoPlayerController controller;
  final bool isPlaying;
  final bool isFullScreen;
  final bool showOverlay;
  final Duration currentPosition;
  final Duration totalDuration;
  final bool isLooping;

  const VideoPlayerReady({
    required this.controller,
    required this.isPlaying,
    required this.isFullScreen,
    required this.showOverlay,
    required this.currentPosition,
    required this.totalDuration,
    required this.isLooping,
  });

  @override
  VideoPlayerState copyWith({
    Duration? currentPosition,
    bool? isPlaying,
    bool? isFullScreen,
    bool? showOverlay,
    bool? isLooping,
  }) {
    return VideoPlayerReady(
      controller: controller,
      isPlaying: isPlaying ?? this.isPlaying,
      isFullScreen: isFullScreen ?? this.isFullScreen,
      showOverlay: showOverlay ?? this.showOverlay,
      currentPosition: currentPosition ?? this.currentPosition,
      totalDuration: totalDuration,
      isLooping: isLooping ?? this.isLooping,
    );
  }
}

class VideoPlayerError extends VideoPlayerState {
  final String errorMessage;

  const VideoPlayerError({required this.errorMessage});

  @override
  VideoPlayerState copyWith({
    Duration? currentPosition,
    bool? isPlaying,
    bool? isFullScreen,
    bool? showOverlay,
    bool? isLooping,
  }) {
    return this;
  }
}