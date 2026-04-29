import 'package:flutter/material.dart';

import 'dart:ui';

class GlassedButton extends StatelessWidget {
  final VoidCallback? fn;
  final String? label;
  final IconData icon;

  const GlassedButton({
    super.key,
    this.fn,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return GestureDetector(
      onTap: fn,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.25),
                  Colors.white.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 28),
                if(! isMobile ) const SizedBox(width: 12),
                if( isMobile ) Spacer(),
                Text(
                  label ?? "Button",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if( isMobile ) const SizedBox(width: 27),
                if( isMobile ) Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}