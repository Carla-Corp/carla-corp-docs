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
              ),
              SizedBox(height: 50),
              ContentTitle(label: "Runa and Eva libraries"),
              ContentText(label: "Runa and Eva are two important pieces of Carla ecosystem. Runa is the interpreter used by Morgana to run all extensors. You can use it in all C ABI compatible languages — Eva, is a little different."),
              SizedBox(height: 10),
              ContentText(label: "Eva, different than Runa, has some \"high level language\" official support."),
              SizedBox(height: 20),
              Wrap(
                spacing: 10,
                children: [
                  CommonDownloadEmbed(
                    icon: Ionicons.moon, 
                    os: 'Runa interpreter',
                    description: "Click to be redirect to Runa README.md", 
                    url: 'https://github.com/lucasFelixSilveira/runa',
                    binaryName: 'Runa minimal lua interpreter',
                  ),
                  CommonDownloadEmbed(
                    icon: Ionicons.library, 
                    os: 'Eva libraries',
                    description: "Click to be redirect to Eva README.md", 
                    url: 'https://github.com/Carla-Corp/eva#language-support',
                    binaryName: 'Eva libraries references',
                  ),
                ]
              ),
            ],
          ),
        )
      ],
    );
  }
}

