import 'package:flutter/material.dart';

class CustomInkwelltextspan extends StatelessWidget {
  String screenRoute;
  String text1;
  String text2;

  CustomInkwelltextspan({
    super.key,
    required this.screenRoute,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, screenRoute);
      },
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: text1,
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
            TextSpan(
              text: text2,
              style: TextStyle(
                color: const Color.fromARGB(255, 95, 175, 241),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
