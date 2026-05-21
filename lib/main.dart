import 'dart:async';

import 'package:docs/views/documentation/data.dart';
import 'package:docs/views/pager.dart';
import 'package:flutter/material.dart';
import 'dart:isolate';

import 'dart:html' as html;
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final contents = <String, String>{};
  for( var item in documentationData ) {
    final data = item as Map<String, dynamic>;
    if (data['ignore'] == true) continue;
    
    final asset = data['asset'] as String;
    contents[asset] = await rootBundle.loadString(asset);
  }
  
  await _processWithWebWorker(contents);
  runApp(const MyApp());
}

Future<void> _processWithWebWorker(Map<String, String> contents) async {
  final workerCode = '''
    self.addEventListener('message', function(e) {
      const contents = e.data;
      const results = {};
      
      for (const [asset, content] of Object.entries(contents)) {
        const lines = content.split('\\n');
        const h1s = [];
        
        for (const line of lines) {
          if(line.startsWith('# ')) {
            h1s.push(line.substring(2).trim());
          }
        }
        
        results[asset] = h1s;
      }
      
      self.postMessage(results);
    });
  ''';
  
  final blob = html.Blob([workerCode], 'application/javascript');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final worker = html.Worker(url);
  
  final completer = Completer<void>();
  
  worker.onMessage.listen((event) {
    final results = event.data as Map;
    
    for (var item in documentationData) {
      final data = item as Map<String, dynamic>;
      if (data['ignore'] == true) continue;
      
      final asset = data['asset'] as String;
      if (results.containsKey(asset)) {
        // Cast the result to List<String>
        final fields = (results[asset] as List).cast<String>();
        data['fields'] = fields;
      }
    }
    
    worker.terminate();
    html.Url.revokeObjectUrl(url);
    completer.complete();
  });
  
  worker.postMessage(contents);
  return completer.future;
}

enum Pages { home, documentation, downloads }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Website(),
        '/docs': (context) => const Website(),
        '/downloads': (context) => const Website(),
      },
    );
  }
}