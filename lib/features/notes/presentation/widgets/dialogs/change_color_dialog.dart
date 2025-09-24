import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/core/di/injection.dart';
import 'package:note/core/theme/app_colors.dart';
import 'package:note/core/theme/app_dimens.dart';
import 'package:note/core/theme/app_spacing.dart';
import 'package:note/core/theme/app_text_styles.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:note/features/notes/utils/note_colors.dart';

class ChangeColorDialog extends StatelessWidget {
  const ChangeColorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      bloc: getIt<NotesBloc>(),
      builder: (context, state) {
        if (state is NoteLoadedSuccess) {
          return Stack(
            children: [
              Positioned(
                top: AppDimens.appBarHeight.h,
                right: AppDimens.paddingMmd.w,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 152.w,
                    height: 140.h,
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(AppDimens.radiusXs),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.paddingSmm.w,
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              logger.d(
                                "[NoteScreen] delete note button был нажат",
                              );
                              //TODO: delete note logic
                            },
                            child: SizedBox(
                              height: 30.h,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 0.5,
                                      color:
                                          AppColors.secondarySurfaceSecondary,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Удалить",
                                      style: AppTextStyles.poppins12Regular
                                          .copyWith(color: Colors.red),
                                    ),
                                    const Expanded(child: SizedBox.shrink()),
                                    Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: AppDimens.iconSm,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          AppSpacing.h8,
                          GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 3,
                            crossAxisSpacing: AppDimens.paddingXs.w,
                            mainAxisSpacing: AppDimens.paddingXs.h,

                            children: List.generate(
                              noteColors.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  logger.d("[NoteScreen] color[$index] нажат");
                                  getIt<NotesBloc>().add(
                                    NoteEditedEvent(color: noteColors[index]),
                                  );
                                },
                                child: Container(
                                  width: 40.w,
                                  height: 32.h,
                                  decoration: BoxDecoration(
                                    color: noteColors[index],
                                    borderRadius: BorderRadius.circular(
                                      AppDimens.radiusXs,
                                    ),
                                    border:
                                        state.note.color == noteColors[index]
                                        ? Border.all(
                                            width: 1,
                                            color: AppColors.primary,
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
