import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_fire/providers/theme_provider.dart';

class CustomContainer extends StatefulWidget {
  const CustomContainer({
    super.key,
    required this.page,
    required this.pageAnimation,
    required this.title,
    required this.alignment,
    required this.border,
  });

  final String title;
  final bool page;
  final bool pageAnimation;
  final AlignmentDirectional alignment;
  final BorderRadius border;

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  // Animation Functions
  double appBarHeight(bool page, bool pageAnimation) {
    if (pageAnimation == true && page == true) {
      return MediaQuery.sizeOf(context).height / 8;
    } else if (page == true && pageAnimation == false) {
      return MediaQuery.sizeOf(context).height / 3;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: widget.border,
        color: provider.isDark
            ? provider.colorScheme.surfaceContainerLow
            : provider.colorScheme.surfaceContainerLow,
      ),
      height: appBarHeight(widget.page, widget.pageAnimation),
      width: MediaQuery.sizeOf(context).width,
      alignment: widget.alignment,
      duration: const Duration(
        seconds: 1,
      ),
      curve: Curves.easeOut,
      child: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
          color: provider.isDark
              ? provider.colorScheme.onPrimaryContainer
              : provider.colorScheme.primary,
          fontSize: 35,
        ),
      ),
    );
  }
}
