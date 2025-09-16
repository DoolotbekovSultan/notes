import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:note/core/theme/app_dimens.dart';
import 'package:note/core/theme/app_spacing.dart';
import 'package:note/core/theme/app_text_styles.dart';
import 'package:note/features/onboard/domain/entities/onboard_entity.dart';

class OnboardPage extends StatelessWidget {
  final OnboardEntity entity;

  const OnboardPage({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: AppDimens.paddingXll),
      child: Column(
        children: [
          Lottie.asset(entity.lottiePath, width: 280.w, height: 260.h),
          AppSpacing.h48,
          Text(entity.title, style: AppTextStyles.inter28Bold),
          AppSpacing.h8,
          Text(
            entity.description,
            textAlign: TextAlign.center,
            style: AppTextStyles.inter17Normal,
          ),
        ],
      ),
    );
  }
}
