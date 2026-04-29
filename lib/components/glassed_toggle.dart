import 'package:flutter/material.dart';
import 'dart:ui';

class Option {
  final String label;
  final VoidCallback? onTap;

  const Option({
    required this.label,
    this.onTap,
  });
}

class GlassedToggle extends StatefulWidget {
  final List<Option> options;
  final int initialIndex;
  final ValueChanged<int>? onChanged;

  const GlassedToggle({
    super.key,
    required this.options,
    this.initialIndex = 0,
    this.onChanged,
  });

  @override
  State<GlassedToggle> createState() => _GlassedToggleState();
}

class _GlassedToggleState extends State<GlassedToggle> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex.clamp(0, widget.options.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: Colors.white.withOpacity(0.18),
              width: 1.4,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.12),
                blurRadius: 16,
                spreadRadius: -4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.options.length, (index) {
              final option = widget.options[index];
              final isSelected = index == _selectedIndex;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                curve: Curves.easeOutCubic,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: isSelected
                      ? const LinearGradient(
                          transform: GradientRotation(0.785398163 * 2),
                          // begin: Alignment(-0.8, -0.8),
                          // end: Alignment(0.8, 0.8),
                          colors: [
                            Color(0x4CFFFFFF),
                            Color(0x1AEC80EE),
                            Color(0xffd900dc),
                          ],
                          // stops: [0.0, 0.5, 1.0],
                        )
                      : null,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Colors.white.withOpacity(0.14),
                    highlightColor: Colors.white.withOpacity(0.08),
                    onTap: () {
                      if (_selectedIndex == index) return;
                      setState(() => _selectedIndex = index);
                      option.onTap?.call();
                      widget.onChanged?.call(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 0),
                        curve: Curves.easeOut,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white70,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          fontSize: 15,
                          letterSpacing: 0.2,
                          shadows: isSelected
                              ? [
                                  Shadow(
                                    color: Colors.white.withOpacity(0.5),
                                    blurRadius: 12,
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          option.label,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}