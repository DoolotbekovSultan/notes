import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/notes/domain/entities/note.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/usecases/get_all_notes_usecase.dart';
import 'package:note/features/notes/domain/usecases/insert_note_usecase.dart';
import 'package:note/features/notes/utils/layout_type.dart';

part 'notes_event.dart';
part 'notes_state.dart';

@lazySingleton
class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetAllNotesUsecase _getAllNotesUsecase;
  final InsertNoteUsecase _insertNoteUsecase;
  LayoutType _layoutType = LayoutType.linear;
  NotesBloc(this._getAllNotesUsecase, this._insertNoteUsecase)
    : super(NotesInitial()) {
    on<GetAllNotesEvent>(_onGetAllNotes);
    on<InsertNoteEvent>(_onInsertNote);
    on<ChangeLayoutEvent>(_onChangeLayout);
  }

  Future<void> _onGetAllNotes(
    GetAllNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    logger.d("_onGetAllNotes вызван");
    emit(NotesLoading());
    final result = await _getAllNotesUsecase();

    result.fold(
      (failure) {
        logger.e("Ошибка загрузки Notes", error: failure);
        emit(NotesError(failure));
      },
      (notes) {
        logger.i("Состояние изменено на ${state.runtimeType}");
        emit(NotesLoadedSuccess(notes, _layoutType));
      },
    );
  }

  Future<void> _onInsertNote(
    InsertNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    logger.d("_onInsertNote вызван");
    final result = await _insertNoteUsecase(event.note);

    result.fold(
      (failure) {
        logger.e("Ошибка добавления Note", error: failure);
        emit(NotesError(failure));
      },
      (_) {
        logger.i("Добавлена новая заметка ");
        add(GetAllNotesEvent());
      },
    );
  }

  Future<void> _onChangeLayout(
    ChangeLayoutEvent event,
    Emitter<NotesState> emit,
  ) async {
    logger.d("_onChangeLayout вызван");
    if (_layoutType == LayoutType.linear) {
      _layoutType = LayoutType.grid;
    } else {
      _layoutType = LayoutType.linear;
    }
    logger.d("_layoutType изменен на $_layoutType");
    add(GetAllNotesEvent());
  }
}
