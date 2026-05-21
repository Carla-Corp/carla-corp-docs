import 'package:docs/components/documentation/category_text.dart';
import 'package:docs/components/documentation/content_text.dart';
import 'package:docs/components/documentation/content_title.dart';
import 'package:docs/components/glassed_card.dart';
import 'package:docs/views/documentation/data.dart';
import 'package:docs/views/downloads/downloads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class Overview extends StatelessWidget {
  EdgeInsets common_padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 10);
  final void Function(String, String) d;
  
  Overview({ super.key, required this.d });

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
              SizedBox(height: 20),
              Wrap(
                spacing: 10,
                children: [
                  CommonDownloadEmbed(
                    icon: Icons.terminal, 
                    fn: () => d('Carla', 'Introduction'),
                    os: 'Carla language',
                    description: "Click to go directly to Carla documentation", 
                    url: '',
                    binaryName: 'Carla programming language',
                  ),
                  CommonDownloadEmbed(
                    icon: Icons.edit_document, 
                    fn: () => d('Eva', 'Introduction'),
                    os: 'Eva language',
                    description: "Click to go directly to Eva documentation", 
                    url: '',
                    binaryName: 'Eva declarative configuration language',
                  ),
                ]
              )
            ],
          ),
        )
      ],
    );
  }
}

