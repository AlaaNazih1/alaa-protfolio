import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:alaa_protfolio/core/constant/app_sizes.dart';

class ProjectDemoVideo extends StatefulWidget {
  const ProjectDemoVideo({super.key, required this.videoPath});

  final String videoPath;

  @override
  State<ProjectDemoVideo> createState() => _ProjectDemoVideoState();
}

class _ProjectDemoVideoState extends State<ProjectDemoVideo> {
  late final VideoPlayerController _controller;

  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize()
          .then((_) {
            if (!mounted) return;

            setState(() {});
          })
          .catchError((Object error) {
            debugPrint('Video initialization failed: $error');

            if (!mounted) return;

            setState(() => _hasError = true);
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Project Demo',
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700, maxHeight: 500),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: _controller.value.isInitialized
                      ? _controller.value.aspectRatio
                      : 16 / 9,
                  child: _buildPlayer(context),
                ),
              ),
            ),
          ),
          if (_controller.value.isInitialized && !_hasError) ...[
            const SizedBox(height: 12),
            VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              colors: VideoProgressColors(
                playedColor: colors.secondary,
                bufferedColor: colors.onSurface.withValues(alpha: 0.3),
                backgroundColor: theme.dividerColor,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${_formatDuration(_controller.value.position)}'
                  ' / '
                  '${_formatDuration(_controller.value.duration)}',
                  style: TextStyle(
                    color: colors.onSurface.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                IconButton(
                  tooltip: _controller.value.isPlaying ? 'Pause' : 'Play',
                  onPressed: () {
                    setState(() {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    });
                  },
                  icon: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: colors.secondary,
                    size: 32,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlayer(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (_hasError) {
      return Container(
        color: colors.surfaceContainerHighest,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.video_library_outlined,
              color: colors.onSurface.withValues(alpha: 0.6),
              size: 40,
            ),
            const SizedBox(height: 12),
            Text(
              'Unable to load this video.',
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.onSurface.withValues(alpha: 0.75)),
            ),
          ],
        ),
      );
    }

    if (!_controller.value.isInitialized) {
      return Container(
        color: colors.surfaceContainerHighest,
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: colors.secondary),
      );
    }

    return VideoPlayer(_controller);
  }
}
