import 'package:equatable/equatable.dart';
import 'package:to_note/data/models/to_do_model.dart';

abstract class ToDoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadToDos extends ToDoEvent {}

class AddToDo extends ToDoEvent {
  final ToDoModel toDo;

  AddToDo({required this.toDo});

  @override
  List<Object> get props => [toDo];
}

class CompleteToDo extends ToDoEvent {
  final String toDoId;
  final int rate;
  CompleteToDo({
    required this.rate,
    required this.toDoId,
  });
}
