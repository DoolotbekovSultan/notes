import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  // Poppins
  static final poppins28SemiBold = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 28.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static final poppins24Medium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static final poppins15SemiBold = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // PottaOne
  static final pottaOne24Regular = TextStyle(
    fontFamily: 'PottaOne',
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // Inter
  static final inter28Bold = TextStyle(
    fontFamily: 'Inter',
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static final inter17Normal = TextStyle(
    fontFamily: 'Inter',
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // Roboto
  static final roboto21Bold = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 21.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
}
