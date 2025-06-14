import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoToCard extends StatelessWidget {
  const GoToCard({
    super.key,
    required this.title,
    this.subTitle,
    required this.width,
    required this.height,
    required this.backgroundColor,
    this.onPressed,
    required this.buttonIcon,
  });

  final String title;
  final String? subTitle;
  final double width;
  final double height;
  final Color backgroundColor;
  final VoidCallback? onPressed;
  final IconData buttonIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),                  ),
                  const SizedBox(height: 4),
                  Text(
                    subTitle ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onPressed,
              icon: Icon(
                buttonIcon,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
