import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lkarnet/const/constents.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double start;
  final double end;
  final double blurSygmaX;
  final double blurSygmaY;
  final double borderOpacity;
  final Color backgroundColor;
  const GlassContainer({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.transparent,
    this.blurSygmaX = 43,
    this.blurSygmaY = 43,
    this.borderOpacity = 0.1,
    this.start = 0.4,
    this.end = 0.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(start),
                Colors.white.withOpacity(end),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            borderRadius:
                BorderRadius.all(Radius.circular(AppConstants.radius)),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(borderOpacity),
            ),
          ),
          child: Container(
            // color: backgroundColor,
            child: child,
          ),
        ),
      ),
    );
  }
}

class BluredContainer extends StatelessWidget {
  final Widget child;
  final double start;
  final double end;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;

  final double borderColorOpacity;

  const BluredContainer({
    Key? key,
    required this.child,
    this.start = 0.15,
    this.end = 0.15,
    this.width,
    this.height,
    this.margin,
    this.borderColorOpacity = 0.3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(AppConstants.radius)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          margin: margin,
          width: width ?? MediaQuery.of(context).size.width,
          height: height ?? MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(AppConstants.radius)),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(start),
                Colors.white.withOpacity(end),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            border: Border.all(
              width: 1,
              color: Colors.white.withOpacity(borderColorOpacity),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class GlassMaterial extends StatelessWidget {
  final Widget centerWidget;

  final List<Color> gradientColors;

  final Alignment alignment;

  final List<Widget> circleWidgets;
  const GlassMaterial({
    Key? key,
    required this.centerWidget,
    this.alignment = Alignment.center,
    this.gradientColors = const [
      Color(0xD52A76DA),
      Color(0xBDD43FCD),
    ],
    required this.circleWidgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors),
        ),
        child: Stack(
          children: [
            Stack(
              fit: StackFit.expand,
              children: circleWidgets,
            ),
            Align(
              alignment: alignment,
              child: centerWidget,
            ),
          ],
        ),
      ),
    );
  }
}

class FrostedContainer extends StatelessWidget {
  const FrostedContainer({
    Key? key,
    required this.child,
    required this.color,
    required this.blurSygmaX,
    required this.blurSygmaY,
    required this.borderOpacity,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final double blurSygmaX;
  final double blurSygmaY;
  final double borderOpacity;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderOpacity: borderOpacity,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color.withOpacity(0.4),
              color.withOpacity(0.4),
            ],
          ),
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(borderOpacity),
              blurRadius: blurSygmaX,
              spreadRadius: blurSygmaY,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
