import 'dart:async';

import 'package:flutter/material.dart';

class TypingText extends StatefulWidget {
  const TypingText({
    super.key,
    this.text = 'Flutter Developer',
    this.typingSpeed = const Duration(milliseconds: 110),
    this.deletingSpeed = const Duration(milliseconds: 65),
    this.pauseDuration = const Duration(milliseconds: 1200),
    this.fontSize = 28,
    this.fontWeight = FontWeight.w600,
  });

  final String text;
  final Duration typingSpeed;
  final Duration deletingSpeed;
  final Duration pauseDuration;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> {
  Timer? _timer;
  int _visibleCharacters = 0;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _timer?.cancel();

    if (!_isDeleting && _visibleCharacters == widget.text.length) {
      _timer = Timer(widget.pauseDuration, () {
        if (!mounted) return;

        setState(() {
          _isDeleting = true;
        });

        _startTyping();
      });
      return;
    }

    _timer = Timer(_isDeleting ? widget.deletingSpeed : widget.typingSpeed, () {
      if (!mounted) return;

      setState(() {
        if (_isDeleting) {
          _visibleCharacters--;

          if (_visibleCharacters == 0) {
            _isDeleting = false;
          }
        } else {
          _visibleCharacters++;
        }
      });

      _startTyping();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.text.substring(0, _visibleCharacters)}|',
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight,
      ),
      maxLines: 1,
      overflow: TextOverflow.visible,
    );
  }
}
