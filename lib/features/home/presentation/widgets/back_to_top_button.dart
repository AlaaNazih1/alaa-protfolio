import 'package:alaa_protfolio/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

class BackToTopButton extends StatefulWidget {
  const BackToTopButton({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<BackToTopButton> createState() => _BackToTopButtonState();
}

class _BackToTopButtonState extends State<BackToTopButton> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_handleScroll);
  }

  @override
  void didUpdateWidget(covariant BackToTopButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController.removeListener(_handleScroll);
      widget.scrollController.addListener(_handleScroll);
      _handleScroll();
    }
  }

  void _handleScroll() {
    if (!widget.scrollController.hasClients) return;

    final shouldShow = widget.scrollController.offset > 400;

    if (shouldShow != _isVisible && mounted) {
      setState(() => _isVisible = shouldShow);
    }
  }

  void _scrollToTop() {
    if (!widget.scrollController.hasClients) return;

    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_handleScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 24,
      bottom: 28,
      child: SafeArea(
        child: AnimatedSlide(
          offset: _isVisible ? Offset.zero : const Offset(0, 1.5),
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          child: AnimatedOpacity(
            opacity: _isVisible ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: IgnorePointer(
              ignoring: !_isVisible,
              child: Material(
                color: AppColors.accent,
                elevation: 5,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: _scrollToTop,
                  customBorder: const CircleBorder(),
                  child: const SizedBox(
                    width: 52,
                    height: 52,
                    child: Icon(
                      Icons.arrow_upward_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
