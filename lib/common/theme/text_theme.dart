import 'package:clean_arch_with_riverpod/common/theme/text_style.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class TextThemes {
  /// Main text theme

  static TextTheme get textTheme {
    return const TextTheme(
      bodyLarge: AppTextStyles.bodyLg,
      bodyMedium: AppTextStyles.body,
      titleMedium: AppTextStyles.bodySm,
      titleSmall: AppTextStyles.bodyXs,
      displayLarge: AppTextStyles.h1,
      displayMedium: AppTextStyles.h2,
      displaySmall: AppTextStyles.h3,
      headlineMedium: AppTextStyles.h4,
    );
  }

  /// Dark text theme

  static TextTheme get darkTextTheme {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLg.copyWith(color: AppColors.white),
      bodyMedium: AppTextStyles.body.copyWith(color: AppColors.white),
      titleMedium: AppTextStyles.bodySm.copyWith(color: AppColors.white),
      titleSmall: AppTextStyles.bodyXs.copyWith(color: AppColors.white),
      displayLarge: AppTextStyles.h1.copyWith(color: AppColors.white),
      displayMedium: AppTextStyles.h2.copyWith(color: AppColors.white),
      displaySmall: AppTextStyles.h3.copyWith(color: AppColors.white),
      headlineMedium: AppTextStyles.h4.copyWith(color: AppColors.white),
    );
  }

  /// Primary text theme

  static TextTheme get primaryTextTheme {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLg.copyWith(color: Colors.black),
      bodyMedium: AppTextStyles.body.copyWith(color: Colors.black),
      titleMedium: AppTextStyles.bodySm.copyWith(color: Colors.black),
      titleSmall: AppTextStyles.bodyXs.copyWith(color: Colors.black),
      displayLarge: AppTextStyles.h1.copyWith(color: Colors.black),
      displayMedium: AppTextStyles.h2.copyWith(color: Colors.black),
      displaySmall: AppTextStyles.h3.copyWith(color: Colors.black),
      headlineMedium: AppTextStyles.h4.copyWith(color: Colors.black),
    );
  }
}
