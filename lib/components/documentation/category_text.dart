import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryText extends StatelessWidget {
  final String label;
  const CategoryText({
    super.key,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return Text(label, style: GoogleFonts.poppins(
      fontSize: 18,
      color: Colors.white,
      fontWeight: .bold
    ));
  }
}