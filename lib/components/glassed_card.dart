import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlassedCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final String asset;

  const GlassedCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.asset,
  });

  @override
  State<GlassedCard> createState() => _GlassedCardState();
}

class _GlassedCardState extends State<GlassedCard> {
  final GlobalKey _key = GlobalKey();
  OverlayEntry? _overlay;

  bool isHovering = false;

  void _showOverlay() {
    final renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlay = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: position.dx,
          top: position.dy,
          width: size.width,
          height: size.height,
          child: IgnorePointer(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                final scale = 1 + (0.02 * value);
                final translateY = -2.0 * value;

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..translate(0.0, translateY)
                    ..scale(scale),
                  child: child,
                );
              },
              child: Material(
                color: Colors.transparent,
                child: _buildOriginalCard(),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlay!);
  }

  void _hideOverlay() {
    _overlay?.remove();
    _overlay = null;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovering = true);
        _showOverlay();
      },
      onExit: (_) {
        setState(() => isHovering = false);
        _hideOverlay();
      },
      child: Opacity(
        opacity: isHovering ? 0 : 1,
        child: Container(key: _key, child: _buildOriginalCard()),
      ),
    );
  }

  Widget _buildOriginalCard() {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return SizedBox(
      width: isMobile ? MediaQuery.of(context).size.width * 0.8 : 580,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1d1d1d), Color(0xff111111)],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0x66cccccc), width: 0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  if (isMobile)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(widget.icon, color: Colors.white, size: 26),
                          SizedBox(width: 5),
                          Text(
                            widget.title,
                            style: GoogleFonts.stackSansText(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (isMobile)
                    Text(
                      widget.description,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),

                  if (isMobile) SizedBox(height: 80),

                  if (isMobile)
                    SizedBox(
                      height: 160,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(widget.asset),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                  if (!isMobile)
                    SizedBox(
                      width: 380,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  widget.icon,
                                  color: Colors.white,
                                  size: 26,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  widget.title,
                                  style: GoogleFonts.stackSansText(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              widget.description,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  if (!isMobile)
                    SizedBox(
                      width: 170,
                      height: 120,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(widget.asset),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
