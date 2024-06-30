import 'package:flutter/material.dart';
 
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/local/storage_service.dart';
import '../domain/providers/shared_preferences_storage_provider.dart';
import '../globals.dart';
import 'app_colors.dart';
import 'dimensions.dart';

final appThemeProvider = StateNotifierProvider<AppThemeModeNotifier, ThemeMode>(
  (ref) {
    final storage = ref.watch(storageServiceProvider);
    return AppThemeModeNotifier(storage);
  },
);

class AppThemeModeNotifier extends StateNotifier<ThemeMode> {
  final StorageService storageService;

  ThemeMode currentTheme = ThemeMode.light;

  AppThemeModeNotifier(this.storageService) : super(ThemeMode.light) {
    getCurrentTheme();
  }

  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    storageService.set(APP_THEME_STORAGE_KEY, state.name);
  }

  void getCurrentTheme() async {
    final theme = await storageService.get(APP_THEME_STORAGE_KEY);
    final value = ThemeMode.values.byName('${theme ?? 'light'}');
    state = value;
  }
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
        primaryColor: AppColors.primaryColorDark,
        scaffoldBackgroundColor: AppColors.primaryColorDark.withOpacity(0.5),
        appBarTheme: const AppBarTheme().copyWith(
            elevation: 1,
            color: AppColors.primaryColorDark,
            titleTextStyle: GoogleFonts.poppins(
                color: Colors.white, fontSize: Dimensions.appbarTextSize)),
        primaryColorLight: const Color(0xFFF0F4F8),
        primaryColorDark: const Color(0xFF10324A),
        secondaryHeaderColor: const Color(0xFF9BB8DA),
        disabledColor: const Color(0xFF8797AB),
        brightness: Brightness.dark,
        hintColor: const Color(0xFFC0BFBF),
        focusColor: const Color(0xFF484848),
        hoverColor: const Color(0x400461A5),
        shadowColor: const Color(0x33e2f1ff),
        cardColor: const Color(0xFF151417),
        iconTheme: const IconThemeData(color: Colors.white),
        iconButtonTheme: const IconButtonThemeData(
            style:
                ButtonStyle(iconColor: MaterialStatePropertyAll(Colors.white))),
        dividerColor: Colors.black.withOpacity(0.06),
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          bodySmall: GoogleFonts.poppins(
              fontSize: Dimensions.fontSizeNormal, color: Colors.white),
          bodyMedium: GoogleFonts.poppins(
              fontSize: Dimensions.fontSizeMedium, color: Colors.white),
          bodyLarge: GoogleFonts.poppins(
              fontSize: Dimensions.fontSizeLarge, color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColorLight,
                foregroundColor: Colors.white,
                textStyle: GoogleFonts.poppins(
                    fontSize: Dimensions.fontSizeMedium, color: Colors.white),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)))),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.primaryColorDark,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.white),
        // checkboxTheme: const CheckboxThemeData(
        //     side: BorderSide(color: Colors.grey),
        //     fillColor: MaterialStatePropertyAll(Colors.grey),
        //     checkColor: MaterialStatePropertyAll(Colors.white)),
        sliderTheme: const SliderThemeData(
            activeTrackColor: Colors.grey,
            inactiveTrackColor: AppColors.primaryColorDark,
            thumbColor: Colors.grey,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10)),
        textButtonTheme: TextButtonThemeData(
            style:
                TextButton.styleFrom(foregroundColor: const Color(0xFFFFFFFF))),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryColorDark,
          secondary: Color(0xFFf57d00),
          tertiary: (Color(0xFFFF6767)),
          onPrimary: Color(0xff1c3c5d),
        )
            .copyWith(error: const Color(0xFFdd3135))
            .copyWith(background: Colors.black38),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: AppColors.primaryColorLight));
  }

  /// Light theme data of the app
  static ThemeData get lightTheme {
    return ThemeData(
     useMaterial3: true,
        primaryColor: AppColors.primaryColorLight,
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        appBarTheme: const AppBarTheme().copyWith(
            elevation: 3,
            color: AppColors.primaryColorLight,
            titleTextStyle: GoogleFonts.poppins(
                color: Colors.white, fontSize: Dimensions.appbarTextSize)),
        primaryColorLight: const Color(0xFFF6F6F6),
        primaryColorDark: const Color(0xFF10324A),
        secondaryHeaderColor: const Color(0xFF9BB8DA),
        disabledColor: const Color(0xFF8797AB),
        brightness: Brightness.light,
        hintColor: const Color(0xFFC0BFBF),
        focusColor: const Color(0xFFFFF9E5),
        hoverColor: const Color(0xFFF1F7FC),
        shadowColor: Colors.grey[300],
        cardColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        iconButtonTheme: const IconButtonThemeData(
            style:
                ButtonStyle(iconColor: MaterialStatePropertyAll(Colors.white))),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.black),
        dividerColor: Colors.black.withOpacity(0.06),
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          bodySmall: GoogleFonts.poppins(
              fontSize: Dimensions.fontSizeNormal, color: Colors.black),
          bodyMedium: GoogleFonts.poppins(
              fontSize: Dimensions.fontSizeMedium, color: Colors.black),
          bodyLarge: GoogleFonts.poppins(
              fontSize: Dimensions.fontSizeLarge, color: Colors.black),
        ),
        // checkboxTheme: const CheckboxThemeData(
        //     side: BorderSide(color: Colors.grey),
        //     fillColor: MaterialStatePropertyAll(Colors.white),
        //     checkColor: MaterialStatePropertyAll(ColorRes.primaryColorLight)),
        sliderTheme: const SliderThemeData(
            activeTrackColor: AppColors.primaryColorLight,
            inactiveTrackColor: Colors.grey,
            thumbColor: AppColors.primaryColorLight,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10)),
        textButtonTheme: TextButtonThemeData(
            style:
                TextButton.styleFrom(foregroundColor: const Color(0xFF0461A5))),
        colorScheme: const ColorScheme.light(
                primary: AppColors.primaryColorLight,
                secondary: Color(0xFFFF9900),
                outline: Color(0xFFFDCC0D),
                error: Color(0xFFFF6767),
                background: Color(0xffFCFCFC),
                tertiary: Color(0xFFd35221))
            .copyWith(background: const Color(0xffFCFCFC))
            .copyWith(error: const Color(0xFFFF6767)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColorLight,
                foregroundColor: Colors.white,
                textStyle: GoogleFonts.poppins(
                    fontSize: Dimensions.fontSizeMedium, color: Colors.white),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)))),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.primaryColorLight),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: AppColors.primaryColorLight));
  }
}
