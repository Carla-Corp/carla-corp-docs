import 'package:docs/views/documentation/document.dart';
import 'package:docs/views/documentation/documentation.dart';
import 'package:flutter/material.dart';


class Carla extends StatefulWidget implements DocumentInterface {
  @override
  String get component => _component;

  @override
  final ScrollController? scrollController;
  
  @override
  final Map<String, GlobalKey> jumpable = makeFieldsGlobalKeysFrom('Carla');
  
  final String _component;
  
  Carla({
    super.key,
    required String component,
    this.scrollController,
  }) : _component = component;
  
  @override
  State<Carla> createState() => DocumentState(data: this);


  @override
  String get markdown => 'assets/documentation/carla.md';
}