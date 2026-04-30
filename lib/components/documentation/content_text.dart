import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentText extends StatelessWidget {
  final String label;

  const ContentText({
    super.key,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Text(label, style: GoogleFonts.poppins(
        fontSize: 18,
        color: Colors.grey
      )),
    );
  }
}