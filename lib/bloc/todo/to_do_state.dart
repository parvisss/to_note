import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class ToDoState extends Equatable {
  @override
  List<Object> get props => [];
}

class ToDoInitial extends ToDoState {}

class ToDoLoading extends ToDoState {}

class ToDoLoaded extends ToDoState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> toDoList;

  ToDoLoaded({required this.toDoList});

  @override
  List<Object> get props => [toDoList];
}

class ToDoError extends ToDoState {
  final String errorMessage;

  ToDoError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
