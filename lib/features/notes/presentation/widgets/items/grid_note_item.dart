import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/core/theme/app_colors.dart';
import 'package:note/core/theme/app_dimens.dart';
import 'package:note/core/theme/app_text_styles.dart';
import 'package:note/features/notes/domain/entities/note.dart';
import 'package:note/features/notes/utils/date_formatter.dart';

class GridNoteItem extends StatelessWidget {
  final Note note;
  const GridNoteItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: 151.w,
      decoration: BoxDecoration(
        color: note.color,
        borderRadius: BorderRadius.circular(AppDimens.radiusMl.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingMmd.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              note.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.poppins12SemiBold.copyWith(
                color: Colors.black,
              ),
            ),
            Text(
              note.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.poppins10Normal.copyWith(
                color: Colors.black,
              ),
            ),
            Text(
              dateTimeFormatter.dateTime(note.dateTime),
              style: AppTextStyles.poppins8Bold.copyWith(
                color: AppColors.textSS,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
