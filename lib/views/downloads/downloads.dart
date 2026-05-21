import 'package:docs/main.dart';
import 'package:docs/utils/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class DownloadsPage extends StatefulWidget {
  final void Function(Pages) navigate;
  const DownloadsPage({ super.key, required this.navigate });

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  EdgeInsets common_padding = const EdgeInsets.only(top: 40, bottom: 40, left: 100, right: 0);
  int selected = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: common_padding,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text("All releases", style: GoogleFonts.stackSansText(
                fontSize: 45,
                fontWeight: .bold,
                color: Colors.white
              )),
              SizedBox(
                width: MediaQuery.of(context).size.width/2,
                child: Text(
                  "You can find all available versions of Carla and Morgana ready for download here. See more about each released version on our Github.",
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
        
              SizedBox(height: 30),
              Text("Commonly downloaded", style: GoogleFonts.stackSansText(
                fontSize: 35,
                fontWeight: .bold,
                color: Color(0xffcccccc)
              )),
        
              SizedBox(height: 10),

              SingleChildScrollView(
                scrollDirection: .horizontal,
                child: Row(
                  spacing: 10,
                  children: [
                    CommonDownloadEmbed(
                      os: "Microsoft Windows",
                      description: "Windows 10 or later with Intel/AMD processor",
                      binaryName: "carla@latest.windows-installer.exe",
                      icon: Icons.window_sharp,
                      url: "https://carla-cdn.vercel.app/carla@latest.windows-installer.exe"
                    ),
                    CommonDownloadEmbed(
                      os: "Linux based systems",
                      description: "Linux 3.6 or later with Intel/AMD processor",
                      binaryName: "carla@latest.linux-installer.sh",
                      icon: Ionicons.logo_tux,
                      url: "https://carla-cdn.vercel.app/carla@latest.linux-installer.sh"
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonDownloadEmbed extends StatelessWidget {
  final String os;
  final String description;
  final String binaryName;
  final String url;
  final IconData icon;
  final VoidCallback? fn;
  const CommonDownloadEmbed({
    super.key,
    this.fn,
    required this.os,
    required this.description,
    required this.binaryName,
    required this.url,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: InkWell(
        onTap: fn ?? () => redirectTo(url),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Color(0xff1d1d1d),
                Color(0xff111111),
              ]
            )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(os, style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 20
                    )),
                    Icon(icon, color: Colors.white, size: 30)
                  ],
                ),
                SizedBox(height: 10),
                Text(description, style: GoogleFonts.roboto(
                  color: Colors.grey,
                  fontSize: 15
                )),
                Text(binaryName, style: GoogleFonts.roboto(
                  color: Colors.blue,
                  fontSize: 15
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
