import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:login_screen/global/components/animated_button.dart';
import 'package:login_screen/screens/auth_screen/components/staggered_dots_wave.dart';
import 'package:login_screen/utils/responsive_sizer.dart';
import 'package:flutter/material.dart';

enum AuthButtonState { normal, error, authenticating, downloadingData }

class AuthButton extends StatefulWidget {
  final String buttonText;
  final Function onPressed;
  final bool disabled;
  final AuthButtonState authState;
  final Duration authDelay;
  const AuthButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.disabled,
    required this.authState,
    required this.authDelay,
  });

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> with TickerProviderStateMixin {
  late AnimationController _authController,
      _downloadController,
      _waveController,
      _waveVisiblityController;

  @override
  void initState() {
    _authController = AnimationController(vsync: this);
    _downloadController = AnimationController(vsync: this);
    _waveVisiblityController = AnimationController(vsync: this);
    _waveController = AnimationController(vsync: this, duration: 1000.ms);
    super.initState();
  }

  @override
  void dispose() {
    _authController.dispose();
    _downloadController.dispose();
    _waveVisiblityController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  final _waveColor = Colors.green;
  final _waveSize = 40.su;

  @override
  void didUpdateWidget(covariant AuthButton oldWidget) {
    if (oldWidget.authState != widget.authState) {
      switch (widget.authState) {
        case AuthButtonState.authenticating:
          _authController.value = 0.0;
          _authController.animateTo(
            1.0,
            duration: widget.authDelay,
            curve: Curves.easeOut,
          );
          break;
        case AuthButtonState.downloadingData:
          _downloadController.value = 0.0;
          _downloadController.animateTo(1.0, duration: 200.ms);
          break;
        case AuthButtonState.error:
        case AuthButtonState.normal:
          _authController.value = 0.0;
          _downloadController.value = 0.0;
          break;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final oddWaveSize = _waveSize * 0.4;
    final evenWaveSize = _waveSize * 0.7;

    Color borderColor;
    Color containerColor;
    switch (widget.authState) {
      case AuthButtonState.error:
        borderColor = Colors.red;
        containerColor = Colors.red;
        break;
      case AuthButtonState.normal:
        borderColor = context.dividerColor;
        containerColor = Colors.transparent;
        break;
      case AuthButtonState.downloadingData:
      case AuthButtonState.authenticating:
        borderColor = Colors.green;
        containerColor = Colors.transparent;
        break;
    }
    return AnimatedButtonContainer(
      disabled: widget.disabled,
      onPressed: widget.onPressed,
      child: SizedBox(
        height: 40.su,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                color: containerColor,
                borderRadius: BorderRadius.circular(50.su),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50.su),
                    ),
                  )
                      .animate(controller: _authController, autoPlay: false)
                      .scaleX(
                          begin: 0.0,
                          end: 1.0,
                          alignment: Alignment.centerLeft),
                  Text(
                    widget.buttonText,
                    style: context.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
                .animate(
                    controller: _downloadController,
                    autoPlay: false,
                    onComplete: (controller) {
                      _waveVisiblityController.animateTo(1.0, duration: 200.ms);
                    })
                .fadeOut(),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DotContainer(
                    controller: _waveController,
                    heightInterval: const Interval(0.0, 0.1),
                    offsetInterval: const Interval(0.18, 0.28),
                    reverseHeightInterval: const Interval(0.28, 0.38),
                    reverseOffsetInterval: const Interval(0.47, 0.57),
                    color: _waveColor,
                    size: _waveSize,
                    maxHeight: oddWaveSize,
                  ),
                  8.su.widthBox,
                  DotContainer(
                    controller: _waveController,
                    heightInterval: const Interval(0.09, 0.19),
                    offsetInterval: const Interval(0.27, 0.37),
                    reverseHeightInterval: const Interval(0.37, 0.47),
                    reverseOffsetInterval: const Interval(0.56, 0.66),
                    color: _waveColor,
                    size: _waveSize,
                    maxHeight: evenWaveSize,
                  ),
                  8.su.widthBox,
                  DotContainer(
                    controller: _waveController,
                    heightInterval: const Interval(0.18, 0.28),
                    offsetInterval: const Interval(0.36, 0.46),
                    reverseHeightInterval: const Interval(0.46, 0.56),
                    reverseOffsetInterval: const Interval(0.65, 0.75),
                    color: _waveColor,
                    size: _waveSize,
                    maxHeight: oddWaveSize,
                  ),
                  8.su.widthBox,
                  DotContainer(
                    controller: _waveController,
                    heightInterval: const Interval(0.27, 0.37),
                    offsetInterval: const Interval(0.45, 0.55),
                    reverseHeightInterval: const Interval(0.55, 0.65),
                    reverseOffsetInterval: const Interval(0.74, 0.84),
                    color: _waveColor,
                    size: _waveSize,
                    maxHeight: evenWaveSize,
                  ),
                  8.su.widthBox,
                  DotContainer(
                    controller: _waveController,
                    heightInterval: const Interval(0.36, 0.46),
                    offsetInterval: const Interval(0.54, 0.64),
                    reverseHeightInterval: const Interval(0.64, 0.74),
                    reverseOffsetInterval: const Interval(0.83, 0.93),
                    color: _waveColor,
                    size: _waveSize,
                    maxHeight: oddWaveSize,
                  ),
                ],
              )
                  .animate(
                      controller: _waveVisiblityController,
                      autoPlay: false,
                      onComplete: (controller) {
                        _waveController.repeat();
                      })
                  .fadeIn(),
            )
          ],
        ),
      ),
    );
  }
}
