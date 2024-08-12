import 'package:bloc/bloc.dart';
import 'package:to_note/bloc/todo/to_do_event.dart';
import 'package:to_note/bloc/todo/to_do_state.dart';
import 'package:to_note/services/firestore/to_do_firestore.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final ToDoFirestore _toDoFirestore;

  ToDoBloc(this._toDoFirestore) : super(ToDoInitial()) {
    on<LoadToDos>(_onLoadToDos);
    on<AddToDo>(_onAddToDo);
    on<CompleteToDo>(_onComleteToDo);
  }

  Future<void> _onLoadToDos(LoadToDos event, Emitter<ToDoState> emit) async {
    emit(ToDoLoading());
    try {
      final toDoList = _toDoFirestore.getTodos();
      emit(ToDoLoaded(toDoList: toDoList));
    } catch (e) {
      emit(ToDoError(errorMessage: 'Failed to load to-do items: $e'));
    }
  }

  Future<void> _onAddToDo(AddToDo event, Emitter<ToDoState> emit) async {
    emit(ToDoLoading());
    try {
      await _toDoFirestore.addToDo(event.toDo);
      // Refresh the to-do list after adding a new to-do
      add(LoadToDos());
    } catch (e) {
      emit(ToDoError(errorMessage: 'Failed to add to-do item: $e'));
    }
  }

  Future<void> _onComleteToDo(
      CompleteToDo event, Emitter<ToDoState> emit) async {
    emit(ToDoLoading());
    try {
      await _toDoFirestore.compliteToDo(event.toDoId, event.rate);
      add(LoadToDos());
    } catch (e) {
      emit(ToDoError(errorMessage: "Failed to compete to-do item: $e"));
    }
  }
}
