import 'dart:html' as html;
import 'package:docs/components/glassed_button.dart';
import 'package:docs/components/glassed_card.dart';
import 'package:docs/components/glassed_code.dart';
import 'package:docs/components/glassed_toggle.dart';
import 'package:docs/components/metalic_button.dart';
import 'package:docs/main.dart';
import 'package:docs/strings.dart';
import 'package:docs/utils/proportion.dart';
import 'package:docs/utils/url_launcher.dart';
import 'package:docs/views/pager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final void Function(Pages) navigate;
  const HomePage({ super.key, required this.navigate });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EdgeInsets common_padding = const EdgeInsets.symmetric(vertical: 40, horizontal: 100);
  int selected = 0;

  final GlobalKey _getStartedKey = GlobalKey();

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
    html.document.title = 'Carla & Morgana';
    
    bool isMobile = MediaQuery.of(context).size.width < 800;
    final double bannerHeight = isMobile ? proportional(1080, MediaQuery.of(context).size.width * 0.8, 1920) : 300;

    String? route = html.window.localStorage['route'];
    if( route != null && route != 'nil' ) {
      if(! route.startsWith('/docs/') ) {
        html.window.localStorage['route'] = 'nil';
      }

      widget.navigate(routeToPage(route));
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: isMobile ? EdgeInsetsGeometry.symmetric(vertical: 100) : common_padding,
              child: Container(
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Column(
                        children: [
                          if(! isMobile) Row(
                            mainAxisAlignment: .spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: .start,
                                children: [
                                  Text(
                                    "Carla & Morgana",
                                    softWrap: true,
                                    style: GoogleFonts.stackSansText(
                                      color: Colors.white,
                                      fontSize: isMobile ? 42 : 45,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: isMobile ? .center : .center,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width/2,
                                    child: Text(
                                      "True low-level control, without the noise — Carla compiles with Morgana to deliver predictable binaries, with safety inspired by Rust, without hiding what happens on the metal.",
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment:
                                    isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Version: ",
                                        style: GoogleFonts.poppins(
                                          color: Color(0xffb0a8b9),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "$version",
                                        style: GoogleFonts.poppins(
                                          color: Color.fromARGB(255, 244, 234, 255),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    width: 300,
                                    child: InkWell(
                                      onTap: () => widget.navigate(Pages.downloads),
                                      child: GlassedButton(
                                        icon: Icons.download,
                                        label: "Download",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          if( isMobile ) Column(
                            mainAxisAlignment: .center,
                            children: [
                              Column(
                                crossAxisAlignment: .center,
                                children: [
                                  Text(
                                    "Carla & Morgana",
                                    softWrap: true,
                                    style: GoogleFonts.stackSansText(
                                      color: Colors.white,
                                      fontSize: isMobile ? 42 : 45,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: isMobile ? .center : .center,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "True low-level control, without the noise — Carla compiles with Morgana to deliver predictable binaries, with safety inspired by Rust, without hiding what happens on the metal.",
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                      textAlign: .center,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment:
                                    isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                                children: [
                                 
                                  SizedBox(height: 20),
                                  SizedBox(
                                    width: 300,
                                    child: InkWell(
                                      onTap: () => widget.navigate(Pages.downloads),
                                      child: GlassedButton(
                                        icon: Icons.download,
                                        label: "Download",
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: .center,
                                    children: [
                                      Text(
                                        "Version: ",
                                        style: GoogleFonts.poppins(
                                          color: Color(0xffb0a8b9),
                                        ),
                                      ),
                                      Text(
                                        "$version",
                                        style: GoogleFonts.poppins(
                                          color: Color.fromARGB(255, 244, 234, 255),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: Color(0xff1b1b1b),
                child: Padding(
                  padding: isMobile ? EdgeInsetsGeometry.all(0) : common_padding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Wrap(
                        alignment: .center,
                        runAlignment:.center,
                        crossAxisAlignment: .center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if( isMobile ) Text("Code snippets", style: GoogleFonts.stackSansText(
                                fontSize: 38, fontWeight: FontWeight.bold,
                                color: Colors.white
                              )),

                              if( isMobile ) SizedBox(height: 20),

                              SizedBox(
                                width: isMobile ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * 0.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if(! isMobile ) Spacer(),
                                    if(! isMobile ) Spacer(),
                                    GlassedToggle(
                                      options: [
                                        Option(label: "Carla"),
                                        Option(label: "Morgana"),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          selected = value;
                                        });
                                      },
                                    ),
                                    if(! isMobile ) Spacer(),
                                  ],
                                ),
                              ),

                              SizedBox(height: 10),

                              SizedBox(
                                width: isMobile ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * 0.5,
                                child: Row(
                                  mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
                                  children: [
                                    AnimatedSwitcher(
                                      duration: Duration(milliseconds: 300),
                                      child: selected == 0
                                        ? GlassedCode(
                                            width: isMobile ? MediaQuery.of(context).size.width * 0.8 : null,
                                            key: ValueKey('carla_code'),
                                            output: '''@_start
void main = () {
  puts "Hello, world!";
} ''',
                                            section: "carla-corp",
                                            command: "cat main.crl"
                                          )
                                        : GlassedCode(
                                            width: isMobile ? MediaQuery.of(context).size.width * 0.8 : null,
                                            key: ValueKey('morgana_code'),
                                            output: '''comptime _start
void main() {
  constant_string = constant "Hello, world!"
  puts constant_string
}''',
                                            section: "carla-corp",
                                            command: "cat main.morg"
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 30),
                          SizedBox(
                            width: isMobile ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                              children: [
                                if(! isMobile ) Text("Code snippets", style: GoogleFonts.stackSansText(
                                  fontSize: 38, fontWeight: FontWeight.bold,
                                  color: Colors.white
                                )),
                                if( isMobile ) SizedBox(height: 20),

                                SizedBox(
                                  width: isMobile ? MediaQuery.of(context).size.width * 0.8 : MediaQuery.of(context).size.width,
                                  child: Text( isMobile ? "See small code examples in Carla and Morgana to the above." : "See small code examples in Carla and Morgana to the side.",
                                  textAlign: isMobile ? TextAlign.center : TextAlign.left, style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Colors.grey
                                  )),
                                ),

                                SizedBox(height: isMobile ? 30 : 10),
                                SizedBox(
                                  width: isMobile ?  MediaQuery.of(context).size.width * 0.8 : 200,
                                  child: InkWell(
                                    onTap: () {
                                      WidgetsBinding.instance.addPostFrameCallback((_) {
                                        final context = _getStartedKey.currentContext;
                                        if (context != null) {
                                          Scrollable.ensureVisible(
                                            context,
                                            duration: Duration(seconds: 1),
                                            curve: Curves.fastEaseInToSlowEaseOut,
                                          );
                                        }
                                      });
                                    },
                                    child: MetalicButton(
                                      label: "Get started",
                                      colors: [ Color(0xffffffff), Color(0xffb700a8) ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF000000),
                  Color(0xFF211a22),
                  Color(0xFF2a1e2e),
                ],
                stops: isMobile ? [ 0.0, 0.60, 1.0 ] : [0.0, 0.85, 1.0],
              ),
            ),
              child: Padding(
                padding: isMobile ? EdgeInsetsGeometry.all(0): common_padding,
                child: Column(
                  children: [
                    if( isMobile ) SizedBox(height: 50),
                    Text("Compatibility", style: GoogleFonts.stackSansText(
                      fontSize: 38, fontWeight: FontWeight.bold,
                      color: Colors.white
                    )),

                    Text("Carla and Morgana are compatible with many of architectures.", textAlign: TextAlign.center, style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.grey
                    )),

                    if( isMobile ) SizedBox(height: 20),
                    SizedBox(height: 20),

                    Padding(
                      padding: isMobile ? EdgeInsetsGeometry.all(8.0) : EdgeInsetsGeometry.all(0),
                      child: Center(
                        child: Wrap(
                          direction: Axis.horizontal, 
                          alignment: WrapAlignment.center,
                          spacing: 15,
                          runSpacing: 15,
                          children: [
                            GlassedCard(
                              asset: 'assets/atmega.png',
                              icon: Icons.memory_rounded,
                              title: "Arduino (AVR)",
                              description: "Morgana's extender for AVR assembly has been implemented.",
                            ),
                            GlassedCard(
                              asset: 'assets/xtensa.jpg',
                              icon: Icons.memory_rounded,
                              title: "Tensilica (xTensa)",
                              description: "Morgana's extender for xTensa assembly has been implemented.",
                            ),
                            GlassedCard(
                              asset: 'assets/x86_64.jpg',
                              icon: Icons.memory_rounded,
                              title: "Intel/AMD (x86_64)",
                              description: "Morgana's extender for x86_64 assembly has been implemented.",
                            ),
                            GlassedCard(
                              asset: 'assets/arm.png',
                              icon: Icons.memory_rounded,
                              title: "Qualcomm ... (ARM)",
                              description: "Morgana's extender for ARM assembly has been implemented.",
                            ),
                            GlassedCard(
                              asset: 'assets/risc-v.png',
                              icon: Icons.memory_rounded,
                              title: "SiFive ... (Risc-V)",
                              description: "Morgana's extender for Ricv-V assembly has been implemented.",
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: Color(0xFF2a1e2e),
                child: Padding(
                  padding: isMobile ? EdgeInsetsGeometry.symmetric( vertical: 40, horizontal: 50 ) : common_padding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Extensors & Runa", style: GoogleFonts.stackSansText(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold
                          )),
                          Text("Runa is a minimal Lua interpreter with a C API created for the Morgana Extensors.", style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 18
                          )),
                          SizedBox(height: 20),
                          Text("What is an exensor?", style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 22
                          )),
                          SizedBox(height: 5),
                          Text("Extensors are Lua programs written in Runa syntax that can be downloaded from a repository or created and published by anyone. Their role is to generate the assembly instructions for the target architecture during compilation, or to prepare the code for cross-compilation to another platform. Because extensors handle the entire code generation process, every instruction produced by the compiler can be inspected, modified, or replaced, ensuring fully transparent and completely customizable output.", style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 18
                          )),
                          SizedBox(height: 20),
                          SizedBox(
                            width: isMobile ?  MediaQuery.of(context).size.width * 0.8 : 325,
                            child: InkWell(
                              onTap: () async => await redirectTo(extensors),
                              child: MetalicButton(
                                label: "How to create my own extensor",
                                colors: [ Color(0xffffffff), Color(0xff9d89b3) ],
                              ),
                            ),
                          ),
                        ]
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                key: _getStartedKey,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2a1e2e),
                    Color(0xFF211a22),
                    Color(0xFF000000),
                  ],
                  stops: isMobile ? [ 0.0, 0.60, 1.0 ] : [0.0, 0.3, 1.0],
                ),
                ),
                child: Padding(
                  padding: isMobile ? EdgeInsetsGeometry.all(0) : common_padding,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          if( isMobile ) SizedBox(height: 30),
                          Text("Get Started", style: GoogleFonts.stackSansText(
                            fontSize: 38, fontWeight: FontWeight.bold,
                            color: Colors.white
                          )),
                          Text("Create your first \"Hello World\" program in Carla and compile to your machine.", textAlign: TextAlign.center, style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.grey
                          )),
                          if( isMobile ) SizedBox(height: 30),
                        ],
                      ),
                      Padding(
                        padding: isMobile
                            ? EdgeInsets.all(8)
                            : EdgeInsets.symmetric(horizontal: 120, vertical: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () async => await redirectTo(getStaretdVideo),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                  child: SizedBox(
                                    width: isMobile ? MediaQuery.of(context).size.width * 0.9 : 960,
                                    height: isMobile ? proportional(920, MediaQuery.of(context).size.width * 0.9, 540) : 540,
                                    child: InkWell(
                                      onTap: () async => await redirectTo(getStaretdVideo),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage("assets/thumbnail.png"),
                                            fit: .cover
                                          )
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => widget.navigate(Pages.documentation),
                                child: SizedBox(
                                  width: isMobile ? MediaQuery.of(context).size.width * 0.9 : 960,
                                  child: MetalicButton(
                                      noRoundTop: true,
                                      label: "Go to language Documentation",
                                      colors: [ Color(0xffffffff), Color(0xffb700a8) ],
                                    ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if( isMobile ) SizedBox(height: 30),
            Padding(
              padding: isMobile ? EdgeInsetsGeometry.all(0) : common_padding,
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  SizedBox(
                    width: isMobile ? MediaQuery.of(context).size.width * 0.8 : 1144,
                    height: bannerHeight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: isMobile ? AssetImage("assets/mobile_banner.png") : AssetImage("assets/banner.png"),
                          fit: .cover
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(isMobile ? 20 : 0),
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(isMobile ? 0 : 20),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: .start,
                        crossAxisAlignment: .start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                            child: SizedBox(
                              height: (isMobile ?  bannerHeight : 300) - 40,
                              child: Column(
                                crossAxisAlignment: .start,
                                mainAxisAlignment: isMobile ? .start : .spaceBetween,
                                children: [
                                  SizedBox(
                                    width: isMobile ? MediaQuery.of(context).size.width * 0.7 : 600,
                                    child: Column(
                                      crossAxisAlignment: .start,
                                      children: [
                                        Text("Join to our open-source community!", style: GoogleFonts.stackSansText(
                                          color: Colors.white,
                                          fontSize: 45,
                                          fontWeight: FontWeight.bold
                                        )),
                                        SizedBox(height: 10),
                                        Text("The Carla comunity needs you. Join to make extensors, or PRs in Carla and Morgana!", textAlign: TextAlign.left, style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          color: Colors.white
                                        )),
                                      ],
                                    ),
                                  ),
                                  if( isMobile ) SizedBox(height: 20),
                                  SizedBox(
                                    width: 300,
                                    child: InkWell(
                                      onTap: () async => await redirectTo(discord),
                                      child: MetalicButton(
                                        label: "I want to join",
                                        colors: [ Color(0xffffffff), Color(0xff9d89b3) ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
