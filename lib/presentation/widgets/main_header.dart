import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Image.asset(
        'assets/main/header.png',
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
