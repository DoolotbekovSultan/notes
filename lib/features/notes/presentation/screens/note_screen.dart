import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:note/core/di/injection.dart';
import 'package:note/core/theme/app_colors.dart';
import 'package:note/core/theme/app_dimens.dart';
import 'package:note/core/theme/app_spacing.dart';
import 'package:note/core/theme/app_text_styles.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:note/features/notes/presentation/widgets/dialogs/change_color_dialog.dart';
import 'package:note/features/notes/utils/date_formatter.dart';

class NoteScreen extends StatefulWidget {
  final int? id;

  const NoteScreen({this.id, super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _titleEditingController = TextEditingController();
  final _descriptionEditingController = TextEditingController();
  late final NotesBloc _bloc;

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();

  @override
  void initState() {
    _bloc = getIt<NotesBloc>()..add(LoadNoteEvent(widget.id));
    super.initState();
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _titleFocus.dispose();
    _descriptionEditingController.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: AppDimens.paddingMl.h,
            left: AppDimens.paddingMd.w,
            right: AppDimens.paddingMd.w,
          ),
          child: BlocConsumer<NotesBloc, NotesState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is NotesLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is NoteLoadedSuccess) {
                if (_titleEditingController.text.isEmpty &&
                    _descriptionEditingController.text.isEmpty) {
                  _titleEditingController.text = state.note.title;
                  _descriptionEditingController.text = state.note.description;
                }
                return KeyboardListener(
                  focusNode: FocusNode(),
                  onKeyEvent: (event) {
                    if (event is KeyDownEvent) {
                      if (event.logicalKey == LogicalKeyboardKey.enter &&
                          _titleFocus.hasFocus) {
                        FocusScope.of(context).requestFocus(_descriptionFocus);
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          // Убираем первый символ, если это \n
                          final text = _descriptionEditingController.text;
                          if (text.isNotEmpty && text.startsWith('\n')) {
                            _descriptionEditingController.text = text.substring(
                              1,
                            );
                          }

                          _descriptionEditingController.selection =
                              const TextSelection.collapsed(offset: 0);
                        });
                      } else if (event.logicalKey ==
                              LogicalKeyboardKey.backspace &&
                          _descriptionFocus.hasFocus &&
                          _descriptionEditingController.selection.isCollapsed &&
                          _descriptionEditingController.selection.baseOffset ==
                              0) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          FocusScope.of(context).requestFocus(_titleFocus);
                          _titleEditingController.selection =
                              TextSelection.collapsed(
                                offset: _titleEditingController.text.length,
                              );
                        });
                      }
                    }
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              logger.d("[NoteScreen] back button был нажат");
                              getIt<NotesBloc>().add(BackNavigateEvent());
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.icon.withValues(alpha: 0.7),
                            ),
                          ),
                          AppSpacing.w16,
                          Text(
                            "${dateTimeFormatter.date(state.note.dateTime)} ",
                            style: AppTextStyles.poppins14SemiBold.copyWith(
                              color: AppColors.textPrimary.withValues(
                                alpha: 0.8,
                              ),
                            ),
                          ),
                          Text(
                            dateTimeFormatter.time(state.note.dateTime),
                            style: AppTextStyles.poppins14SemiBold.copyWith(
                              color: AppColors.textPrimary.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                          Expanded(child: const SizedBox()),
                          GestureDetector(
                            onTap: () {
                              logger.d(
                                "[NoteScreen] change color button был нажат",
                              );
                              getIt<NotesBloc>().add(
                                ChangeColorButtonClickedEvent(),
                              );
                            },
                            child: Container(
                              width: AppDimens.iconContainer.w,
                              height: AppDimens.iconContainer.h,
                              decoration: BoxDecoration(
                                color: state.note.color,
                                border: Border.all(
                                  color: state.isChangeColor
                                      ? AppColors.primarySurface
                                      : AppColors.primary,
                                  width: AppDimens.strokeWidth.r,
                                ),
                                borderRadius: BorderRadius.circular(
                                  AppDimens.radiusS,
                                ),
                              ),
                              child: Icon(
                                Icons.color_lens,
                                size: AppDimens.iconSm,
                                color: state.isChangeColor
                                    ? AppColors.primarySurface
                                    : AppColors.primary,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: state.showReadyText,
                            child: Row(
                              children: [
                                AppSpacing.w12,
                                GestureDetector(
                                  onTap: () {
                                    logger.d(
                                      "[NoteScreen] ready text был нажат",
                                    );
                                    _bloc.add(SaveNoteEvent());
                                  },
                                  child: Text(
                                    "Готово",
                                    style: AppTextStyles.poppins15SemiBold
                                        .copyWith(color: AppColors.primary),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.h16,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimens.paddingSm,
                        ),
                        child: TextField(
                          cursorColor: AppColors.primary,
                          controller: _titleEditingController,
                          focusNode: _titleFocus,
                          maxLines: null,
                          style: AppTextStyles.poppins24SemiBold.copyWith(
                            color: AppColors.textPrimary.withValues(alpha: 0.7),
                          ),
                          decoration: InputDecoration(border: InputBorder.none),
                          onChanged: (title) =>
                              _bloc.add(NoteEditedEvent(title: title)),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimens.paddingSm,
                          ),
                          child: TextField(
                            cursorColor: AppColors.primary,
                            controller: _descriptionEditingController,
                            focusNode: _descriptionFocus,
                            keyboardType: TextInputType.multiline,
                            expands: true,
                            maxLines: null,
                            minLines: null,
                            style: AppTextStyles.poppins12SemiBold.copyWith(
                              color: AppColors.textPrimary.withValues(
                                alpha: 0.7,
                              ),
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            onChanged: (description) => getIt<NotesBloc>().add(
                              NoteEditedEvent(description: description),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
            listener: (context, state) {
              if (state is NavigateNotesScreen) {
                logger.d("[NotesScreen] переход на notes screen");
                context.pop();
              } else if (state is ShowColorChangeDialog) {
                logger.d("[NoteScreen] change color dialog открыт");
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: "Закрыть",
                  barrierColor: Colors.black54.withValues(alpha: 0.1),
                  transitionDuration: Duration(milliseconds: 300),
                  pageBuilder: (context, firstAnim, secondAnim) =>
                      ChangeColorDialog(),
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                ).then((_) {
                  logger.d("[NoteScreen] change color dialog закрыт");
                  _bloc.add(ChangeColorDialogClosedEvent());
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
