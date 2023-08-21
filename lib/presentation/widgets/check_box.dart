import 'package:flutter/material.dart';

class CheckBox extends StatelessWidget {
  final Function() onTap;
  final bool checked;
  final Widget label;

  const CheckBox({
    super.key,
    required this.onTap,
    required this.checked,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 168, 211, 251),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 1,
                      spreadRadius: 2,
                    )
                  ],
                  borderRadius: BorderRadius.circular(1),
                  gradient: (checked
                      ? const LinearGradient(
                          colors: [
                            Color(0xff62aef3),
                            Color(0xff254cb1),
                            Color(0xff414dbc),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                      : null),
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(left: 8)),
          label,
        ],
      ),
    );
  }
}
