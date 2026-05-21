import 'package:docs/components/documentation/content_code.dart';
import 'package:docs/components/documentation/content_rich_text.dart';
import 'package:docs/components/documentation/content_text.dart';
import 'package:docs/components/documentation/content_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class DocumentInterface {
  Map<String, GlobalKey> get jumpable;
  String get component;
  String get markdown;
  ScrollController? get scrollController;
}

class DocumentState<T extends StatefulWidget> extends State<T> {
  final DocumentInterface data;
  String markdown = '';
  bool _isLoading = true;
  String? _lastLoadedPath;
  
  // Cache estático compartilhado entre todas as instâncias
  static final Map<String, String> _markdownCache = {};
  
  DocumentState({required this.data});

  @override
  void initState() {
    super.initState();
    _loadMarkdownIfNeeded();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Só recarrega se o caminho do markdown mudou
    if (data.markdown != _lastLoadedPath) {
      _loadMarkdownIfNeeded();
    }
  }

  Future<void> _loadMarkdownIfNeeded() async {
    final path = data.markdown;
    
    // Se já carregou o mesmo arquivo, não recarrega
    if (_lastLoadedPath == path && markdown.isNotEmpty) {
      setState(() {
        _isLoading = false;
      });
      _performScroll();
      return;
    }
    
    // Verifica se já está no cache
    if (_markdownCache.containsKey(path)) {
      setState(() {
        markdown = _markdownCache[path]!;
        _lastLoadedPath = path;
        _isLoading = false;
      });
      _performScroll();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Carrega e armazena no cache
    final md = await rootBundle.loadString(path);
    _markdownCache[path] = md;
    
    setState(() {
      markdown = md;
      _lastLoadedPath = path;
      _isLoading = false;
    });
    
    _performScroll();
  }

  void _performScroll() {
    // Só tenta scrollar depois que o markdown foi carregado e renderizado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSection(data.component);
    });
  }

  Future<void> _scrollToSection(String component) async {
    // Aguarda múltiplos frames para garantir que todos os widgets foram construídos
    for (int i = 0; i < 3; i++) {
      await Future.delayed(Duration.zero);
    }
    
    String normalized = component.toLowerCase().trim().replaceAll(' ', '-');
    final targetKey = data.jumpable[normalized];

    if (targetKey?.currentContext != null) {
      await Scrollable.ensureVisible(
        targetKey!.currentContext!,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
        alignment: 0.08,           
      );
    } else {
      // Log para debug (opcional)
      debugPrint('Could not find key: $normalized');
    }
  }

  // Novo método para processar texto inline com código
  List<InlineSpan> _parseInlineMarkdown(String text) {
    final List<InlineSpan> spans = [];
    final RegExp codeRegex = RegExp(r'`([^`]+)`');
    int lastIndex = 0;
    
    for (final match in codeRegex.allMatches(text)) {
      // Adiciona o texto antes do código
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: text.substring(lastIndex, match.start),
          style: const TextStyle(height: 1.5),
        ));
      }
      
      // Adiciona o código com a "caixinha bonitinha"
      final codeContent = match.group(1) ?? '';
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: Color(0xff1d1d1d),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: const Color.fromARGB(255, 130, 57, 232),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric( horizontal: 6, vertical: 3 ),
              child: Text(
                codeContent,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 13.5,
                  color: const Color.fromARGB(255, 130, 57, 232),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      );
      
      lastIndex = match.end;
    }
    
    // Adiciona o texto restante
    if (lastIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastIndex),
        style: const TextStyle(height: 1.5),
      ));
    }
    
    return spans;
  }

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
          key: data.jumpable[keyName],
        ));
        continue;
      }

      if (trimmed.startsWith('## ')) {
        String title = trimmed.substring(3);
        String keyName = title.toLowerCase().replaceAll(' ', '-');
        widgets.add(ContentTitle(
          label: title,
          key: data.jumpable[keyName],
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
        // Agora usa o novo método para processar inline code
        widgets.add(
          ContentRichText(
            children: _parseInlineMarkdown(line),
          ),
        );
      } else if (widgets.isNotEmpty && widgets.last is! SizedBox) {
        widgets.add(const SizedBox(height: 16));
      }
    }
    
    // Se ainda estiver em um code block no final do arquivo, adiciona ele
    if (currentCodeBlock != null && codeLines.isNotEmpty) {
      widgets.add(ContentCode(
        title: codeLanguage.isNotEmpty ? codeLanguage : "Code",
        code: codeLines.join('\n'),
      ));
    }
    
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    if (markdown.isEmpty) {
      return const Center(
        child: Text('No content available'),
      );
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _parseMarkdown(markdown),
      ),
    );
  }
}