import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentTitle extends StatefulWidget {
  final String label; 
  const ContentTitle({
    super.key,
    required this.label
  });

  @override
  State<ContentTitle> createState() => _ContentTitleState();
}

class _ContentTitleState extends State<ContentTitle> {

  @override
  Widget build(BuildContext context) {
    return Text(widget.label, style: GoogleFonts.stackSansText(
      fontSize: 35,
      color: Colors.white,
      fontWeight: .bold
    ));
  }
}