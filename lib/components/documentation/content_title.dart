import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentTitle extends StatelessWidget {
  final String label; 
  const ContentTitle({
    super.key,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return Text(label, style: GoogleFonts.stackSansText(
      fontSize: 35,
      color: Colors.white,
      fontWeight: .bold
    ));
  }
}