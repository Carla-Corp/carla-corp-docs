import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KeyboardIcon extends StatelessWidget {
  final String text;
  const KeyboardIcon({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Row(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [ 
            Text(text, style: GoogleFonts.poppins(
              color: Colors.white,
            )) 
          ],
        ),
      ),
    );
  }
}