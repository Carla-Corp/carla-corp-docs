import 'package:docs/views/documentation/document.dart';
import 'package:docs/views/documentation/documentation.dart';
import 'package:flutter/material.dart';

class Eva extends StatefulWidget implements DocumentInterface {
  @override
  String get component => _component;

  @override
  final ScrollController? scrollController;
  
  @override
  final Map<String, GlobalKey> jumpable = makeFieldsGlobalKeysFrom('Eva');
  
  final String _component;
  
  Eva({
    super.key,
    required String component,
    this.scrollController,
  }) : _component = component;
  
  @override
  State<Eva> createState() => DocumentState(data: this);


  @override
  String get markdown => 'assets/documentation/eva.md';
}