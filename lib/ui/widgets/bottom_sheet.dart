import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:to_note/bloc/todo/to_do_bloc.dart';
import 'package:to_note/bloc/todo/to_do_event.dart';
import 'package:to_note/bloc/todo/to_do_state.dart';
import 'package:to_note/data/models/to_do_model.dart';

class AddToDoBottomSheet extends StatefulWidget {
  const AddToDoBottomSheet({super.key});

  @override
  AddToDoBottomSheetState createState() => AddToDoBottomSheetState();
}

class AddToDoBottomSheetState extends State<AddToDoBottomSheet> {
  final _titleController = TextEditingController();
  final _timeController = TextEditingController();
  bool _isToday = true;

  void _addToDo() {
    if (_timeController.text.trim() != "" &&
        _timeController.text.trim() != "") {
      context.read<ToDoBloc>().add(
            AddToDo(
              toDo: ToDoModel(
                  id: _titleController
                      .text, // Assuming ID can be the title or use a proper ID generator
                  title: _titleController.text,
                  date: _isToday, // Passing boolean directly
                  time: _timeController.text,
                  isCompleted: false,
                  rate: 0),
            ),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Fill all the details to register")));
    }
    _titleController.clear();
    _timeController.clear();
    Navigator.pop(context);
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade900,
      appBar: AppBar(
        title: const Text("Add ToDo"),
        backgroundColor: Colors.orange.shade900,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: BlocConsumer<ToDoBloc, ToDoState>(
            listener: (context, state) {
              if (state is ToDoLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("New Task Added Successfully!"),
                  ),
                );
              } else if (state is ToDoError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is ToDoLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Add New ToDo",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                  ),
                  const Gap(60),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Title",
                        style: TextStyle(fontSize: 24),
                      ),
                      const Gap(35),
                      Flexible(
                        child: TextField(
                          maxLines: 3,
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: "Title of the Plan",
                            fillColor: Colors.orange
                                .shade200, // Set background color for TextField
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Time",
                        style: TextStyle(fontSize: 24),
                      ),
                      const Gap(20),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            fillColor: Colors.orange
                                .shade200, // Set background color for TextField
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          controller: _timeController,
                          onTap: _selectTime,
                          readOnly: true, // Make text field read-only
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Today",
                        style: TextStyle(fontSize: 24),
                      ),
                      Switch(
                        value: _isToday,
                        onChanged: (value) {
                          setState(() {
                            _isToday = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const Gap(70),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FilledButton(
        onPressed: _addToDo,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 20),
          child: const Text("Add"),
        ),
      ),
    );
  }
}
