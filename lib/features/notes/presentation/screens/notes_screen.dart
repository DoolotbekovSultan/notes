import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/core/di/injection.dart';
import 'package:note/core/theme/app_colors.dart';
import 'package:note/core/theme/app_dimens.dart';
import 'package:note/core/theme/app_spacing.dart';
import 'package:note/core/theme/app_text_styles.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/notes/data/mock_data.dart';
import 'package:note/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:note/features/notes/presentation/widgets/grid_note_item.dart';
import 'package:note/features/notes/presentation/widgets/linear_note_item.dart';
import 'package:note/features/notes/utils/layout_type.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingMd),
          child: BlocProvider(
            create: (_) => getIt<NotesBloc>()..add(GetAllNotesEvent()),
            child: BlocBuilder<NotesBloc, NotesState>(
              builder: (context, state) {
                if (state is NotesLoadedSuccess) {
                  return Column(
                    children: [
                      SizedBox(
                        height: AppDimens.appBarHeight.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.menu,
                              color: AppColors.icon.withValues(alpha: 0.7),
                            ),
                            Text(
                              "Все заметки",
                              style: AppTextStyles.poppins16SemiBold,
                            ),
                            GestureDetector(
                              onTap: () {
                                logger.d(
                                  "[NotesScreen] change layout был нажат",
                                );
                                getIt<NotesBloc>().add(ChangeLayoutEvent());
                              },
                              child: Icon(
                                state.layoutType == LayoutType.grid
                                    ? Icons.grid_view
                                    : Icons.list,
                                color: AppColors.icon.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.h16,
                      Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppDimens.radiusM,
                          ),
                          color: AppColors.secondarySurface,
                        ),
                      ),
                      AppSpacing.h12,
                      if (state.layoutType == LayoutType.linear)
                        Expanded(
                          child: ListView.separated(
                            itemCount: notesMockData.length,
                            separatorBuilder: (context, index) => AppSpacing.h8,
                            itemBuilder: (context, index) {
                              return LinearNoteItem(note: notesMockData[index]);
                            },
                          ),
                        )
                      else
                        Expanded(
                          child: GridView.builder(
                            itemCount: notesMockData.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                            itemBuilder: (context, index) {
                              return GridNoteItem(note: notesMockData[index]);
                            },
                          ),
                        ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logger.d("[NotesScreen] add note button был нажат");
        },
        backgroundColor: AppColors.primary,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppColors.icon),
      ),
    );
  }
}
