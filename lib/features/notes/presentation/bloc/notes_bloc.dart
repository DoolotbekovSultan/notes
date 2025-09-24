import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/notes/domain/entities/note.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/mappers/note_extentions.dart';
import 'package:note/features/notes/domain/usecases/get_all_notes_usecase.dart';
import 'package:note/features/notes/domain/usecases/get_note_usecase.dart';
import 'package:note/features/notes/domain/usecases/insert_note_usecase.dart';
import 'package:note/features/notes/utils/layout_type.dart';

part 'notes_event.dart';
part 'notes_state.dart';

@lazySingleton
class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetAllNotesUsecase _getAllNotesUsecase;
  final InsertNoteUsecase _insertNoteUsecase;
  final GetNoteUsecase _getNoteUsecase;

  LayoutType _layoutType = LayoutType.linear;
  Note? _note;
  Note? _oldNote;

  NotesBloc(
    this._getAllNotesUsecase,
    this._insertNoteUsecase,
    this._getNoteUsecase,
  ) : super(NotesInitial()) {
    on<LoadAllNotesEvent>(_onLoadAllNotes);
    on<LoadNoteEvent>(_onLoadNote);
    on<SaveNoteEvent>(_onSaveNote);
    on<ChangeLayoutEvent>(_onChangeLayout);
    on<NoteEditedEvent>(_onNoteEdited);
    on<AddNoteButtonClickedEvent>(_onAddNoteButtonClicked);
    on<BackNavigateEvent>(_onBackButtonClicked);
    on<ChangeColorButtonClickedEvent>(_onChangeColorButtonClicked);
    on<ChangeColorDialogClosedEvent>(_onChangeColorDialogClosed);
  }

  Future<void> _onLoadAllNotes(
    LoadAllNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    logger.d("_onLoadAllNotes вызван");
    emit(NotesLoading());
    final result = await _getAllNotesUsecase();

    result.fold(
      (failure) {
        logger.e("Ошибка загрузки Notes", error: failure);
        emit(NotesError(failure));
      },
      (notes) {
        emit(NotesLoadedSuccess(notes, _layoutType));
        logger.i("Состояние изменено на ${state.runtimeType}");
      },
    );
  }

  Future<void> _onLoadNote(
    LoadNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    logger.d("_onLoadNote вызван");

    emit(NotesLoading());
    if (event.id != null) {
      final result = await _getNoteUsecase(event.id!);

      result.fold(
        (failure) {
          logger.e("Ошибка загрузки Note", error: failure);
          emit(NotesError(failure));
        },
        (note) {
          _note = note;
          _oldNote = note;
        },
      );
    } else {
      _note = Note(title: "", description: "", dateTime: DateTime.now());
    }
    emit(NoteLoadedSuccess(_note!));
    logger.i("Состояние изменено на ${state.runtimeType}");
  }

  Future<void> _onSaveNote(
    SaveNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    logger.d("_onSaveNote вызван");
    _note = _note!.copyWith(dateTime: DateTime.now());
    final result = await _insertNoteUsecase(_note!);

    result.fold(
      (failure) {
        logger.e("Ошибка сохранения Note", error: failure);
        emit(NotesError(failure));
      },
      (_) {
        logger.i("Сохранена новая заметка");
        add(BackNavigateEvent());
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
    add(LoadAllNotesEvent());
  }

  Future<void> _onNoteEdited(
    NoteEditedEvent event,
    Emitter<NotesState> emit,
  ) async {
    logger.d("_onNoteEdited вызван");
    _note = _note?.copyWith(
      title: event.title,
      description: event.description,
      color: event.color,
    );
    emit(NoteLoadedSuccess(_note!, showReadyText: _oldNote != _note));
    logger.i("Состояние изменено на ${state.runtimeType}");
  }

  Future<void> _onAddNoteButtonClicked(
    AddNoteButtonClickedEvent event,
    Emitter<NotesState> emit,
  ) async {
    logger.d("_onAddNoteButtonClicked вызван");
    emit(NavigateNoteScreen());
  }

  Future<void> _onBackButtonClicked(
    BackNavigateEvent event,
    Emitter<NotesState> emit,
  ) async {
    logger.d("_onBackButtonClicked вызван");
    emit(NavigateNotesScreen());
    add(LoadAllNotesEvent());
  }

  Future<void> _onChangeColorButtonClicked(
    ChangeColorButtonClickedEvent event,
    Emitter<NotesState> emit,
  ) async {
    logger.d("_onChangeColorButtonClicked вызван");
    emit(ShowColorChangeDialog());
    logger.i("Состояние изменено на ${state.runtimeType}");
    emit(
      NoteLoadedSuccess(
        _note!,
        isChangeColor: true,
        showReadyText: _oldNote != _note,
      ),
    );
    logger.i("Состояние изменено на ${state.runtimeType}");
  }

  Future<void> _onChangeColorDialogClosed(
    ChangeColorDialogClosedEvent event,
    Emitter<NotesState> emit,
  ) async {
    logger.d("_onChangeColorDialogClosed вызван");
    emit(NoteLoadedSuccess(_note!, showReadyText: _oldNote != _note));
    logger.i("Состояние изменено на ${state.runtimeType}");
  }
}
