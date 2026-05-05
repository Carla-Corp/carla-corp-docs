import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialButton extends StatefulWidget {
  VoidCallback fn;
  IconData icon;
  String label;

  SocialButton({ super.key, required this.fn, required this.icon, required this.label });

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) { setState(() { hover = true; }); },
      onExit: (_) { setState(() { hover = false; }); },
      child: AnimatedSwitcher(
        duration: Duration( milliseconds: 200 ),
        child: SizedBox(
          key: ValueKey(hover),
          child: ElevatedButton(
            onPressed: widget.fn, 
            style: ButtonStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.symmetric( horizontal: 10, vertical: 15 )),
              backgroundColor: WidgetStatePropertyAll(hover ? Color(0xffffffff) : Color(0x88ffffff))
            ),  
            child: Row(
              mainAxisAlignment: .spaceEvenly,
              spacing: 10,
              children: [
                Icon(widget.icon, size: 32, color: Colors.black),
                Text(widget.label, style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: .w500,
                  color: Colors.black
                ))
              ],
            )
          ),
        ),
      ),
    );
  }
} 