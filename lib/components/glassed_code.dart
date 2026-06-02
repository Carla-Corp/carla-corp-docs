import 'dart:ui';
import 'package:docs/components/animations/typing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlassedCode extends StatefulWidget {
  final String output;
  final String section;
  final String command;
  final double? width;

  GlassedCode({
    super.key,
    this.width,
    required this.output,
    required this.section,
    required this.command,
  });

  @override
  State<GlassedCode> createState() => _GlassedCodeState();
}

class _GlassedCodeState extends State<GlassedCode> {
  bool show = false;
  double percent = 0.4;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width * percent,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff31363B),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xffcccccc),
            width: .5
          )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100)
                    )
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(100)
                    )
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100)
                    )
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff282828),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                width: widget.width ?? (MediaQuery.of(context).size.width * percent) - 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("home@${widget.section} ~ % ", style: GoogleFonts.jetBrainsMono(
                            color: Colors.white,
                            fontSize: 14
                          )),
                          SimpleTyping(sentences: [widget.command], restart: false, style: GoogleFonts.jetBrainsMono(
                            color: Colors.white,
                            fontSize: 14
                          ), then: () => setState(() {
                            show = true;
                          })),
                        ],
                      ),
                      if(show) Text(widget.output, style: GoogleFonts.jetBrainsMono(
                        color: Colors.white70,
                        fontSize: 14
                      ), softWrap: false, overflow: .fade),
              
                      if(show) Text("home@${widget.section} ~ % ", style: GoogleFonts.jetBrainsMono(
                        color: Colors.white,
                        fontSize: 14
                      ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}