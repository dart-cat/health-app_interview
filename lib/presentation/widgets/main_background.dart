import 'package:flutter/material.dart';

class MainBackground extends StatelessWidget {
  const MainBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Positioned(
      top: 0,
      left: 0,
      child: Image.asset(
        'assets/main/background.png',
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: height > width ? BoxFit.fitHeight : BoxFit.fitWidth,
      ),
    );
  }
}
