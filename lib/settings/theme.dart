import 'package:lkarnet/components.dart';
import  'package:flutter/material.dart';

class MThemeData {
  const MThemeData._();
  /////// light theme
  static const primaryColor = Color.fromARGB(255, 255, 136, 0);
  static const primaryVarient = Color(0xFFCA950F);
  static const secondaryColor = Color.fromARGB(255, 235, 166, 150);
  static const secondaryVarient = Color(0xFF7E3BC1);
  static const hintColor = Color.fromARGB(255, 43, 43, 43);
  static const almostWhiteColor = Color(0xFFF6FBFF);
  static const errorColor = Color(0xFFE17979);
  ////// Dark Theme
  static const primaryColorDark = Color.fromARGB(255, 255, 136, 0);
  static const primaryVarientDark = Color(0xFFCA950F);
  static const secondaryColorDark = Color.fromARGB(255, 235, 166, 150);
  static const secondaryVarientDark = Color(0xFF7E3BC1);
  static const hintColorDark = Color(0xFF757575);
  static const almostBlackColorDark = Color(0xFF221e23);
  static const errorColorDark = Color(0xFF9b374d);

  ////////////////////
  //static const accentColor = Color(0xFFEAB93C);
  //static const primaryColor = Color(0xFF121212);
  //static const secondaryColor = Color(0xFF262626);
// black and white
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const grey = Color(0xFFF0F0F0);
  static final blurWhite = Colors.white.withOpacity(0.5);
  /////////////////////
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: primaryColor,
    primaryContainer: primaryVarient,
    secondary: secondaryColor,
    secondaryContainer: secondaryVarient,
    background: almostWhiteColor,
    surface: white,
    onBackground: black,
    error: errorColor,
    onError: white,
    onPrimary: almostWhiteColor,
    onSecondary: almostBlackColorDark,
    onSurface: black,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: primaryColorDark,
    primaryContainer: primaryVarientDark,
    secondary: secondaryColorDark,
    secondaryContainer: secondaryVarientDark,
    background: black,
    surface: almostBlackColorDark,
    onBackground: white,
    error: errorColor,
    onError: white,
    onPrimary: white,
    onSecondary: almostWhiteColor,
    onSurface: white,
    brightness: Brightness.dark,
  );

  static final ButtonStyle raisedButtonStyleCancel = TextButton.styleFrom(
    textStyle: _textTheme.button!.copyWith(color: primaryColor),
    backgroundColor: Colors.transparent,
    minimumSize: const Size(100, 30),
    elevation: 0,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: MThemeData.primaryColor),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
  );
  static final ButtonStyle raisedButtonStyleSave = TextButton.styleFrom(
    textStyle: _textTheme.button,
    minimumSize: const Size(100, 30),
    elevation: 0,
    backgroundColor: Colors.transparent,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
  );
  static final textButtonStyleSave = TextButton.styleFrom(
    maximumSize: const Size(100, 30),
    minimumSize: const Size(100, 30),
    textStyle: _textTheme.headline3,
    backgroundColor: primaryColor,
    elevation: 0,
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: primaryColor),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
  );
  static final textButtonStyleCancel = TextButton.styleFrom(
    maximumSize: const Size(100, 30),
    minimumSize: const Size(100, 30),
    textStyle: _textTheme.headline3,
    elevation: 0,
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: primaryColor),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
  );
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      dialogBackgroundColor: colorScheme.secondary,
      colorScheme: colorScheme,
      backgroundColor: colorScheme.background,
      typography: Typography(),
      buttonTheme: ButtonThemeData(
        minWidth: 88,
        height: 36,
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.normal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
      ),
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: colorScheme.background,
      appBarTheme: AppBarTheme(
        titleTextStyle: _textTheme.headline6!.copyWith(
          color: colorScheme.onPrimary,
        ),
        color: colorScheme.secondary,
        elevation: 8,
        iconTheme: IconThemeData(color: colorScheme.onBackground),
      ),
      hintColor: hintColor,

      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(primaryColor),
        trackColor: MaterialStateProperty.all(secondaryColor),
      ),
      // tabBarTheme: TabBarTheme(labelColor: ),
      //iconTheme: IconThemeData(color: ),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      cardColor: colorScheme.surface,
      cardTheme: CardTheme(
        elevation: 0,
        color: colorScheme.surface,
      ),
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.subtitle1!.apply(color: _darkFillColor),
      ),
      //cardTheme: CardTheme(color: colorScheme.primary),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: _textTheme.bodyText2!.apply(color: primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        waitDuration: const Duration(milliseconds: 100),
        showDuration: const Duration(milliseconds: 50),
        preferBelow: true,
      ),
    );
  }

  static const _bold = FontWeight.bold;
  static const _semiBold = FontWeight.w600;
  static const _medium = FontWeight.w500;
  static const _regular = FontWeight.w400;
  static const _light = FontWeight.w300;

  static final TextTheme _textTheme = TextTheme(
      headline1: GoogleFonts.sansita(
          fontWeight: _bold, fontSize: 28.0, color: Colors.black),
      /***************************** */
      headline2: GoogleFonts.sansita(
          fontWeight: _semiBold, fontSize: 24.0, color: Colors.black),
      /***************************** */
      headline3: GoogleFonts.sansita(
          fontWeight: _semiBold, fontSize: 20.0, color: Colors.black),
      /***************************** */
      headline4: GoogleFonts.sansita(
          fontWeight: _medium, fontSize: 18.0, color: Colors.black),
      /***************************** */
      headline5: GoogleFonts.sansita(
          fontWeight: _regular, fontSize: 16.0, color: Colors.black),
      /***************************** */
      headline6: GoogleFonts.sansita(
          fontWeight: _regular, fontSize: 16.0, color: Colors.black),
      /***************************** */
      subtitle1: GoogleFonts.sansita(
          fontWeight: _regular, fontSize: 14.0, color: Colors.black),
      /***************************** */
      subtitle2: GoogleFonts.sansita(
          fontWeight: _light, fontSize: 12.0, color: hintColor),
      /***************************** */
      caption: GoogleFonts.sansita(
          fontWeight: _light, fontSize: 12.0, color: Colors.black),
      /***************************** */
      overline: GoogleFonts.sansita(
          fontWeight: _light, fontSize: 12.0, color: hintColor),
      /***************************** */
      bodyText1: GoogleFonts.sansita(
          fontWeight: _regular, fontSize: 16.0, color: Colors.black),
      /***************************** */
      bodyText2: GoogleFonts.robotoMono(
          fontWeight: _regular, fontSize: 14.0, color: Colors.black),
      /***************************** */

      button: GoogleFonts.sansita(
        fontWeight: _semiBold,
        fontSize: 16.0,
      ));
}

//**

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class GalleryThemeData {
//   static const _lightFillColor = Colors.black;
//   static const _darkFillColor = Colors.white;

//   static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
//   static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

//   static ThemeData lightThemeData =
//       themeData(lightColorScheme, _lightFocusColor);
//   static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

//   static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
//     return ThemeData(
//       colorScheme: colorScheme,
//       textTheme: _textTheme,
//       // Matches manifest.json colors and background color.
//       primaryColor: const Color(0xFF030303),
//       appBarTheme: AppBarTheme(
//         backgroundColor: colorScheme.background,
//         elevation: 0,
//         iconTheme: IconThemeData(color: colorScheme.primary),
//       ),
//       iconTheme: IconThemeData(color: colorScheme.onPrimary),
//       canvasColor: colorScheme.background,
//       scaffoldBackgroundColor: colorScheme.background,
//       highlightColor: Colors.transparent,
//       focusColor: focusColor,
//       snackBarTheme: SnackBarThemeData(
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: Color.alphaBlend(
//           _lightFillColor.withOpacity(0.80),
//           _darkFillColor,
//         ),
//         contentTextStyle: _textTheme.subtitle1.apply(color: _darkFillColor),
//       ),
//     );
//   }

//   static const ColorScheme lightColorScheme = ColorScheme(
//     primary: Color(0xFFB93C5D),
//     primaryVariant: Color(0xFF117378),
//     secondary: Color(0xFFEFF3F3),
//     secondaryVariant: Color(0xFFFAFBFB),
//     background: Color(0xFFE6EBEB),
//     surface: Color(0xFFFAFBFB),
//     onBackground: Colors.white,
//     error: _lightFillColor,
//     onError: _lightFillColor,
//     onPrimary: _lightFillColor,
//     onSecondary: Color(0xFF322942),
//     onSurface: Color(0xFF241E30),
//     brightness: Brightness.light,
//   );

//   static const ColorScheme darkColorScheme = ColorScheme(
//     primary: Color(0xFFFF8383),
//     primaryVariant: Color(0xFF1CDEC9),
//     secondary: Color(0xFF4D1F7C),
//     secondaryVariant: Color(0xFF451B6F),
//     background: Color(0xFF241E30),
//     surface: Color(0xFF1F1929),
//     onBackground: Color(0x0DFFFFFF), // White with 0.05 opacity
//     error: _darkFillColor,
//     onError: _darkFillColor,
//     onPrimary: _darkFillColor,
//     onSecondary: _darkFillColor,
//     onSurface: _darkFillColor,
//     brightness: Brightness.dark,
//   );

//   static const _regular = FontWeight.w400;
//   static const _medium = FontWeight.w500;
//   static const _semiBold = FontWeight.w600;
//   static const _bold = FontWeight.w700;

//   static final TextTheme _textTheme = TextTheme(
//     headline4: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 20.0),
//     caption: GoogleFonts.oswald(fontWeight: _semiBold, fontSize: 16.0),
//     headline5: GoogleFonts.oswald(fontWeight: _medium, fontSize: 16.0),
//     subtitle1: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 16.0),
//     overline: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 12.0),
//     bodyText1: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 14.0),
//     subtitle2: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 14.0),
//     bodyText2: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 16.0),
//     headline6: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 16.0),
//     button: GoogleFonts.montserrat(fontWeight: _semiBold, fontSize: 14.0),
//   );
// }