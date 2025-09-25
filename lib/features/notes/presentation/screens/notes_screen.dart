import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:note/core/di/injection.dart';
import 'package:note/core/routes/route_names.dart';
import 'package:note/core/theme/app_colors.dart';
import 'package:note/core/theme/app_dimens.dart';
import 'package:note/core/theme/app_spacing.dart';
import 'package:note/core/theme/app_text_styles.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:note/features/notes/presentation/widgets/dialogs/ask_to_do_dialog.dart';
import 'package:note/features/notes/presentation/widgets/items/grid_note_item.dart';
import 'package:note/features/notes/presentation/widgets/items/linear_note_item.dart';
import 'package:note/features/notes/utils/layout_type.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController searchController = TextEditingController();
  late final NotesBloc _bloc;

  @override
  void initState() {
    _bloc = getIt<NotesBloc>()..add(LoadAllNotesEvent());
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingMd.w),
          child: BlocConsumer<NotesBloc, NotesState>(
            bloc: _bloc,
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
                              logger.d("[NotesScreen] change layout был нажат");
                              getIt<NotesBloc>().add(ChangeLayoutEvent());
                            },
                            child: Icon(
                              state.layoutType == LayoutType.grid
                                  ? Icons.grid_view_outlined
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
                        borderRadius: BorderRadius.circular(AppDimens.radiusM),
                        color: AppColors.secondarySurface,
                      ),
                      child: TextField(
                        controller: searchController,
                        style: AppTextStyles.poppins12Regular,
                        onChanged: (query) {
                          _bloc.add(SearchNotesEvent(query));
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            size: AppDimens.iconSm,
                            color: AppColors.icon.withValues(alpha: 0.7),
                          ),
                          hint: Text(
                            "Поиск заметок",
                            style: AppTextStyles.poppins10Normal.copyWith(
                              color: AppColors.textPrimary.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    AppSpacing.h12,
                    if (state.notes.isEmpty)
                      Expanded(
                        child: Center(
                          child: Text(
                            'Нету заметок',
                            style: AppTextStyles.poppins15SemiBold.copyWith(
                              color: AppColors.textSS,
                            ),
                          ),
                        ),
                      )
                    else if (state.layoutType == LayoutType.linear)
                      Expanded(
                        child: ListView.separated(
                          itemCount: state.notes.length,
                          separatorBuilder: (context, index) => AppSpacing.h8,
                          itemBuilder: (context, index) {
                            final note = state.notes[index];
                            return GestureDetector(
                              onLongPress: () {
                                logger.d(
                                  "[NotesScreen] Note[$index] был зажат",
                                );
                                _bloc.add(NoteLongPressedEvent(note: note));
                              },
                              onTap: () {
                                logger.d(
                                  "[NotesScreen] Note[$index].id = ${note.id} был нажат",
                                );
                                context.push("${RouteNames.note}/${note.id}");
                              },
                              child: LinearNoteItem(note: note),
                            );
                          },
                        ),
                      )
                    else
                      Expanded(
                        child: GridView.builder(
                          itemCount: state.notes.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: AppDimens.crossSpacingMd.w,
                                mainAxisSpacing: AppDimens.mainSpacingMd.h,
                              ),
                          itemBuilder: (context, index) {
                            final note = state.notes[index];
                            return GestureDetector(
                              onLongPress: () {
                                logger.d(
                                  "[NotesScreen] Note[$index] был зажат",
                                );
                              },
                              onTap: () {
                                logger.d(
                                  "[NotesScreen] Note[$index] был нажат",
                                );
                                context.push("${RouteNames.note}/${note.id}");
                              },
                              child: GridNoteItem(note: note),
                            );
                          },
                        ),
                      ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
            listener: (context, state) {
              switch (state) {
                case NavigateNoteScreen(:final id):
                  logger.d("[NotesScreen] переход на note screen $id");
                  context.push(RouteNames.note + (id != null ? "/$id" : ""));
                  break;
                case ShowAskDeleteDialog(note: final note):
                  logger.d("[NotesScreen] ask delete dialog открыт");
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: AskToDoDialog(
                        ask: "Удалить заметку?",
                        yes: "Удалить",
                        no: 'Отмена',
                        onYes: () {
                          logger.d(
                            "[NotesScreen] delete button был нажат в askDialog",
                          );
                          _bloc.add(DeleteNoteEvent(note: note));
                          Navigator.of(context).pop();
                          _bloc.add(LoadAllNotesEvent());
                        },
                        onNo: () {
                          logger.d(
                            "[NotesScreen] cancel button был нажат в askDialog",
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                default:
                  return;
              }
            },
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logger.d("[NotesScreen] add note button был нажат");
          getIt<NotesBloc>().add(AddNoteButtonClickedEvent());
        },
        backgroundColor: AppColors.primary,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppColors.icon),
      ),
    );
  }
}
