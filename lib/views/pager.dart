import 'dart:html' as html;
import 'package:docs/components/animations/animated_load.dart';
import 'package:docs/components/metalic_button.dart';
import 'package:docs/main.dart';
import 'package:docs/strings.dart';
import 'package:docs/utils/url_launcher.dart';
import 'package:docs/views/downloads/downloads.dart';
import 'package:docs/views/home/home.dart';
import 'package:flutter/material.dart';

class Website extends StatefulWidget {
  const Website({super.key});

  @override
  State<Website> createState() => WebsiteData();
}

Pages routeToPage(String? route) {
  switch (route) {
    case '/docs': return Pages.documentation;
    case '/downloads': return Pages.downloads;
    case '/':
    default: return Pages.home;
  }
}

String pageToRoute(Pages page) {
  switch (page) {
    case Pages.home: return '/';
    case Pages.documentation: return '/docs';
    case Pages.downloads: return '/downloads';
  }
}

late VoidCallback data;

class WebsiteData extends State<Website> with SingleTickerProviderStateMixin {
  Pages currentPage = Pages.home;
  bool _initialized = false;
  bool _loading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    html.window.onPopState.listen((event) {
      final path = html.window.location.pathname;

      setState(() {
        currentPage = routeToPage(path);
      });
      
      _animationController.reset();
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _fake_load() async {
    setState(() { _loading = true; });
    await Future.delayed(const Duration(milliseconds: 300));
    if(mounted) {
      setState(() { _loading = false; });
      _animationController.reset();
      _animationController.forward();
    }
  }

  void _navigate(Pages page) {
    if( currentPage == page ) return;
    final route = pageToRoute(page);

    html.window.history.pushState(null, '', route);
    
    setState(() {
      currentPage = page;
    });
    
    _fake_load();
  }

  Widget getPage() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: currentPage == Pages.home 
          ? HomePage(navigate: _navigate)
          : currentPage == Pages.downloads 
          ? DownloadsPage(navigate: _navigate)
          : const Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    "Documentation",
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  Text(
                    "coming soon",
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      final path = html.window.location.pathname;
      currentPage = routeToPage(path);
      _initialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _animationController.forward();
        }
      });
    }

    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          if(!_loading) Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: InkWell(
                      onTap: () => _navigate(Pages.home),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xffcccccc),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage('assets/carla.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    height: 40,
                    child: InkWell(
                      onTap: () => _navigate(Pages.documentation),
                      child: MetalicButton(
                        label: "Documentation",
                        colors: const [
                          Color(0xffffffff),
                          Color(0xff9d89b3),
                        ],
                      ),
                    ),
                  ),

                  if (!isMobile) const SizedBox(width: 10),

                  if (!isMobile)
                    SizedBox(
                      height: 40,
                      child: InkWell(
                        onTap: () => _navigate(Pages.downloads),
                        child: MetalicButton(
                          label: "Download",
                          colors: const [
                            Color(0xffffffff),
                            Color(0xffb700a8),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: _loading
                  ? const Center(
                      key: ValueKey('loading'),
                      child: AnimatedLoadingIndicator(),
                    )
                  : Container(
                      key: ValueKey(currentPage),
                      child: getPage(),
                    ),
            ),
          ),
        ]
      ),
    );
  }
}