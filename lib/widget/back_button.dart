import 'package:flutter/material.dart';

class NavigatorBack extends StatelessWidget {
  final Widget child;

  const NavigatorBack({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        child,
        Positioned(
          left: 0,
          top: 0,
          child: SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: const Icon(Icons.arrow_back_ios),
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                color: Colors.white,
                onPressed: () {
                  Navigator.maybePop(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
