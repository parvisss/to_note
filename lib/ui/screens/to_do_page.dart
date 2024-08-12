import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:to_note/bloc/todo/to_do_bloc.dart';
import 'package:to_note/bloc/todo/to_do_event.dart';
import 'package:to_note/bloc/todo/to_do_state.dart';
import 'package:to_note/data/models/to_do_model.dart';
import 'package:to_note/services/auth/auth_service.dart';
import 'package:to_note/ui/widgets/bottom_sheet.dart';
import 'package:to_note/ui/widgets/rate_bottom_sheet.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  ToDoPageState createState() => ToDoPageState();
}

class ToDoPageState extends State<ToDoPage> {
  @override
  void initState() {
    super.initState();
    // Dispatch LoadToDos event to load the to-do items
    context.read<ToDoBloc>().add(LoadToDos());
  }

  void _showAddToDoDialog(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.96,
          maxChildSize: 1.0,
          minChildSize: 0.4,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.orange.shade900,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              padding: const EdgeInsets.all(16.0),
              child: const AddToDoBottomSheet(),
            );
          },
        );
      },
    );
  }

  void _showRateBottomSheet(BuildContext context, final todo) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          maxChildSize: 0.5,
          minChildSize: 0.3,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return RateBottomSheet(
              todo: todo,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade800,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              await AuthService().logOut();
            },
            icon: const Icon(Icons.logout)),
        backgroundColor: Colors.orange.shade900,
        title: const Text('To-Do List'),
      ),
      body: BlocBuilder<ToDoBloc, ToDoState>(
        builder: (context, state) {
          if (state is ToDoLoading) {
            return Center(
              child: SpinKitThreeInOut(
                itemBuilder: (context, index) {
                  return const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.amber));
                },
              ),
            );
          } else if (state is ToDoLoaded) {
            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: state.toDoList,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitThreeInOut(
                      itemBuilder: (context, index) {
                        return const DecoratedBox(
                            decoration: BoxDecoration(color: Colors.amber));
                      },
                    ),
                  );
                }

                final toDoDocs = snapshot.data?.docs ?? [];
                final toDoItems = toDoDocs.map((doc) {
                  return ToDoModel.fromJson(doc.data());
                }).toList();

                // Separate to-do items by date
                final todayTodos =
                    toDoItems.where((todo) => todo.date).toList();
                final tomorrowTodos =
                    toDoItems.where((todo) => !todo.date).toList();

                return CustomScrollView(
                  slivers: [
                    if (todayTodos.isNotEmpty) ...[
                      const SliverPadding(
                        padding: EdgeInsets.all(16.0),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            "Today",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final todo = todayTodos[index];
                            return ListTile(
                                title: Text(
                                  todo.title,
                                  style: TextStyle(
                                    decoration: todo.isCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                subtitle: Text(todo.time),
                                leading: todo.isCompleted
                                    ? const Icon(
                                        Icons.check_box,
                                      )
                                    : const Icon(
                                        Icons.check_box_outline_blank_outlined),
                                trailing: todo.isCompleted
                                    ? Text(
                                        "Rate : ${todo.rate}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          decoration: todo.isCompleted
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                        ),
                                      )
                                    : null,
                                onTap: () {
                                  _showRateBottomSheet(context, todo);
                                });
                          },
                          childCount: todayTodos.length,
                        ),
                      ),
                    ],
                    if (tomorrowTodos.isNotEmpty) ...[
                      const SliverPadding(
                        padding: EdgeInsets.all(16.0),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            "Tomorrow",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final todo = tomorrowTodos[index];
                            return ListTile(
                              title: Text(
                                todo.title,
                                style: TextStyle(
                                  decoration: todo.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              subtitle: Text(todo.time),
                              leading: todo.isCompleted
                                  ? const Icon(
                                      Icons.check_box,
                                    )
                                  : const Icon(
                                      Icons.check_box_outline_blank_outlined),
                              trailing: todo.isCompleted
                                  ? Text(
                                      "Rate : ${todo.rate}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        decoration: todo.isCompleted
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    )
                                  : null,
                              onTap: () {
                                _showRateBottomSheet(context, todo);
                              },
                            );
                          },
                          childCount: tomorrowTodos.length,
                        ),
                      ),
                    ],
                    if (todayTodos.isEmpty && tomorrowTodos.isEmpty) ...[
                      const SliverFillRemaining(
                        child: Center(child: Text('No to-dos available.')),
                      ),
                    ],
                  ],
                );
              },
            );
          } else if (state is ToDoError) {
            return Center(child: Text(state.errorMessage));
          }
          return const Center(child: Text('No to-dos available.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddToDoDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
