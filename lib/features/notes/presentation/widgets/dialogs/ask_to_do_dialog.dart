import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/core/theme/app_colors.dart';
import 'package:note/core/theme/app_dimens.dart';
import 'package:note/core/theme/app_spacing.dart';
import 'package:note/core/theme/app_text_styles.dart';

class AskToDoDialog extends StatelessWidget {
  final String ask;
  final String yes;
  final String no;
  final Function() onYes;
  final Function() onNo;
  const AskToDoDialog({
    required this.ask,
    required this.yes,
    required this.no,
    required this.onYes,
    required this.onNo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = Size(100.w, 44.h);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(AppDimens.radiusMl),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimens.paddingMD),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(ask, style: AppTextStyles.poppins14SemiBold),
            AppSpacing.h16,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: buttonSize,
                    backgroundColor: AppColors.primarySurface,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: AppColors.textPrimary.withValues(alpha: 0.7),
                        width: AppDimens.strokeWidth.r,
                      ),
                      borderRadius: BorderRadius.circular(AppDimens.radiusM.r),
                    ),
                  ),
                  onPressed: onNo,
                  child: Text(no, style: AppTextStyles.roboto14Normal),
                ),
                AppSpacing.w24,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: buttonSize,
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radiusM.r),
                    ),
                  ),
                  onPressed: onYes,
                  child: Text(yes),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
