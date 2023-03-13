import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final safeAreaZone = MediaQuery.of(context).padding.bottom;
    return Material(
      color: const Color(0xFF12151E),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/png/bg1.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF141921).withOpacity(0.75),
                    const Color(0xFF0F0F1A).withOpacity(0.75),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            height: safeAreaZone,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: const Color(0xFF12151E),
            ),
          ),
          Positioned.fill(child: SafeArea(child: child)),
        ],
      ),
    );
  }
}
