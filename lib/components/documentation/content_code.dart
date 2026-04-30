import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentCode extends StatelessWidget {
  final String title;
  final String code;

  const ContentCode({ super.key, required this.title, required this.code });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff1d1d1d),
          borderRadius: BorderRadius.circular(10)
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(title, style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 13,
                )),
                SizedBox(height: 10),
                Text(code, style: GoogleFonts.jetBrainsMono(
                  color: Colors.grey,
                  fontSize: 15,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}