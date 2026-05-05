import 'package:flutter/material.dart';
import 'package:docs/components/documentation/category_text.dart';
import 'package:docs/components/documentation/content_code.dart';
import 'package:docs/components/documentation/content_text.dart';
import 'package:docs/components/documentation/content_title.dart';

class Carla extends StatefulWidget {
  final String component;
  final ScrollController? scrollController;   
  
  const Carla({
    super.key,
    required this.component,
    this.scrollController,
  });

  @override
  State<Carla> createState() => _CarlaState();
}

class _CarlaState extends State<Carla> {
  final Map<String, GlobalKey> _sectionKeys = {
    'introduction': GlobalKey(),
    'hello-world': GlobalKey(),
    'declarations': GlobalKey(),
    'functions': GlobalKey(),
    'puts': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSection(widget.component);
    });
  }

  @override
  void didUpdateWidget(covariant Carla oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.component != widget.component) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSection(widget.component);
      });
    }
  }

  void _scrollToSection(String component) {
    String normalized = component.toLowerCase().trim().replaceAll(' ', '-');
    final targetKey = _sectionKeys[normalized];

    if (targetKey?.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey!.currentContext!,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
        alignment: 0.08,           
      );
    }
  }

  final String markdownContent = '''''';

  List<Widget> _parseMarkdown(String markdown) {
    final List<Widget> widgets = [];
    final lines = markdown.trim().split('\n');
    String? currentCodeBlock;
    String codeLanguage = '';
    List<String> codeLines = [];

    for (String line in lines) {
      final trimmed = line.trim();

      if (trimmed.startsWith('# ') && !trimmed.startsWith('##')) {
        String title = trimmed.substring(2);
        String keyName = title.toLowerCase().replaceAll(' ', '-');
        widgets.add(ContentTitle(
          label: title,
          key: _sectionKeys[keyName],
        ));
        continue;
      }

      if (trimmed.startsWith('## ')) {
        String title = trimmed.substring(3);
        String keyName = title.toLowerCase().replaceAll(' ', '-');
        widgets.add(ContentTitle(
          label: title,
          key: _sectionKeys[keyName],
        ));
        continue;
      }

      if (trimmed.startsWith('```')) {
        if (currentCodeBlock == null) {
          currentCodeBlock = '';
          codeLanguage = trimmed.length > 3 ? trimmed.substring(3).trim() : 'carla';
          codeLines.clear();
        } else {
          widgets.add(ContentCode(
            title: codeLanguage.isNotEmpty ? codeLanguage : "Code",
            code: codeLines.join('\n'),
          ));
          currentCodeBlock = null;
          codeLines.clear();
        }
        continue;
      }

      if (currentCodeBlock != null) {
        codeLines.add(line);
        continue;
      }

      if (trimmed.isNotEmpty) {
        widgets.add(ContentText(label: trimmed));
      } else if (widgets.isNotEmpty && widgets.last is! SizedBox) {
        widgets.add(const SizedBox(height: 16));
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _parseMarkdown(markdownContent),
      ),
    );
  }
}