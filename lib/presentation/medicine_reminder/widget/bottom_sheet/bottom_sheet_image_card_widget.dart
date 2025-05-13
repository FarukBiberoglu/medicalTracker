import 'package:flutter/material.dart';

class ImageCardWidget extends StatelessWidget {
  const ImageCardWidget({
    super.key,
    required this.imagePath,
    this.onTap,
    this.isSelected = false,
    required this.title,
  });

  final bool isSelected;
  final String title;
  final String imagePath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              border: isSelected ? Border.all(color: Colors.grey.withValues(alpha: 0.3)) : null,
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: SizedBox(
                width: 45,
                height: 45,
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            title,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
