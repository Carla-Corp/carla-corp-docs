import 'dart:html' as html;
import 'package:docs/components/documentation/keyboard.dart';
import 'package:docs/main.dart';
import 'package:docs/views/documentation/carla.dart';
import 'package:docs/views/documentation/data.dart';
import 'package:docs/views/documentation/overview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:html' as html;
import 'package:docs/components/documentation/keyboard.dart';
import 'package:docs/main.dart';
import 'package:docs/views/documentation/carla.dart';
import 'package:docs/views/documentation/data.dart';
import 'package:docs/views/documentation/overview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooserPage extends StatefulWidget {
  final void Function(Pages) navigate;
  const ChooserPage({super.key, required this.navigate});

  @override
  State<ChooserPage> createState() => _ChooserPageState();
}

class _ChooserPageState extends State<ChooserPage> {
  EdgeInsets commonPadding = const EdgeInsets.only(
    top: 40,
    bottom: 40,
    left: 100,
    right: 0,
  );

  int selected = 0;
  final searchBaseBackground = Color(0xff181818);
  final searchBaseBackgroundHover = Color(0xff1d1d1d);
  Color? searchBackground;

  String current = "Overview";
  String component = '';

  final ScrollController _contentScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    searchBackground = searchBaseBackground;
  }

  @override
  void dispose() {
    _contentScrollController.dispose();
    super.dispose();
  }

  void _changeContent(String newCategory, String newComponent) {
    setState(() {
      current = newCategory;
      component = newComponent;
    });

    if( newCategory == "Carla" ) {
      Future.delayed(const Duration(milliseconds: 80), () {
        _scrollToSection(newComponent);
      });
    }
  }

  void _scrollToSection(String section) {
  }

  List<Widget> _generateFields() {
    List<Widget> result = [];

    for (final Map<String, dynamic> data in documentationData) {
      final fields = data['fields'] as List<String>;
      final category = data['category'] as String;
      final icon = data['icon'] as IconData;

      List<Widget> children = [];

      for (String field in fields) {
        children.add(
          DocumentationField(
            label: field,
            fn: () => _changeContent(category, field),
          ),
        );
      }

      result.add(
        Category(
          icon: icon,
          name: category,
          children: children, 
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 76,
                width: MediaQuery.of(context).size.width * 0.15,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MouseRegion(
                        onEnter: (_) => setState(
                          () => searchBackground = searchBaseBackgroundHover,
                        ),
                        onExit: (_) => setState(
                          () => searchBackground = searchBaseBackground,
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: searchBackground,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.search_outlined,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Search",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      spacing: 5,
                                      children: const [
                                        KeyboardIcon(text: "Ctrl"),
                                        KeyboardIcon(text: "K"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      ..._generateFields(),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 60 - 16,
                    child: SingleChildScrollView(
                      key: ValueKey(current),
                      controller: _contentScrollController,
                      child: current == "Overview"
                          ? Overview()
                          : current == "Carla"
                          ? Carla(
                              component: component,
                              scrollController: _contentScrollController,
                            )
                          : SizedBox(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DocumentationField extends StatefulWidget {
  final String label;
  final VoidCallback fn;

  const DocumentationField({super.key, required this.label, required this.fn});
  @override
  State<DocumentationField> createState() => _DocumentationFieldState();
}

class _DocumentationFieldState extends State<DocumentationField> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        hover = true;
      }),
      onExit: (_) => setState(() {
        hover = false;
      }),
      child: InkWell(
        onTap: widget.fn,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 30, vertical: 10),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: Text(
              widget.label,
              key: ValueKey(hover),
              style: GoogleFonts.poppins(
                color: hover ? Colors.white : Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String name;
  final IconData icon;
  final List<Widget> children;
  const Category({
    super.key,
    required this.icon,
    required this.name,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            crossAxisAlignment: .center,
            spacing: 10,
            children: [
              Icon(icon, color: Color(0xffcccccc), size: 18),
              Text(
                name,
                style: GoogleFonts.poppins(
                  color: Color(0xffcccccc),
                  fontSize: 15,
                  fontWeight: .w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(crossAxisAlignment: .start, children: children),
        ],
      ),
    );
  }
}
