import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget? tabScreenLayout;
  final Widget? mobileScreenLayout;
  final Widget? desktopScreenLayout;

  const ResponsiveLayout({
    super.key,
    this.tabScreenLayout,
    this.mobileScreenLayout,
    this.desktopScreenLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 940) {
          // Desktops and Large Screen Displays
          if (desktopScreenLayout != null) {
            return desktopScreenLayout!;
          }
        } else if (constraints.maxWidth > 480) {
          // Tablets and Medium Screen Displays
          if (tabScreenLayout != null) {
            return tabScreenLayout!;
          }
        } else {
          // Mobiles and Small Screen Displays
          if (mobileScreenLayout != null) {
            return mobileScreenLayout!;
          }
        }
        // Layout Not Provided for Particular Display Size
        return mobileScreenLayout!;
      },
    );
  }
}
