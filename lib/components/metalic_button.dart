import 'package:flutter/material.dart';

class MetalicButton extends StatelessWidget {
  
  final VoidCallback? fn;
  final String? label;
  final List<Color> colors;
  final bool? noRoundTop;
  const MetalicButton({ super.key, this.fn, this.noRoundTop,  this.label, required this.colors });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fn,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            transform: GradientRotation(-2.00713)
          ),
          borderRadius: (noRoundTop ?? false) == false ? BorderRadius.circular(100) : BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 9,
        ),
        child: Center(
          child: Text(
            label ?? "Button",
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}