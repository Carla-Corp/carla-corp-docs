import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentRichText extends StatelessWidget {
  final List<InlineSpan> children;

  const ContentRichText({
    super.key,
    required this.children
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: RichText(
        text: TextSpan(
          children: children,
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}