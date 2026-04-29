import 'package:url_launcher/url_launcher.dart';

Future<void> redirectTo(String urlString) async {
  final Uri uri = Uri.parse(urlString);
  if(! await launchUrl(uri) ) {
    throw 'Could not launch $uri';
  }
}
