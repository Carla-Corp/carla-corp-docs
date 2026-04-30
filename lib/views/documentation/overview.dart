import 'package:docs/components/documentation/category_text.dart';
import 'package:docs/components/documentation/content_text.dart';
import 'package:docs/components/documentation/content_title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Overview extends StatelessWidget {
  EdgeInsets common_padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 10);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: common_padding,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              CategoryText(label: "Overview"),
              ContentTitle(label: "Get Started"),
              ContentText(label: "The official Carla language ecosystem documentation, where you can find info about Carla or Morgana, and descover more about their ecosystem."),
            ],
          ),
        )
      ],
    );
  }
}

