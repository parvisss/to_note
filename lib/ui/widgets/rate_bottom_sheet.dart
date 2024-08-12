import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_note/bloc/todo/to_do_bloc.dart';
import 'package:to_note/bloc/todo/to_do_event.dart';
import 'package:to_note/data/models/to_do_model.dart';

class RateBottomSheet extends StatefulWidget {
  const RateBottomSheet({super.key, required this.todo});
  final ToDoModel todo;

  @override
  RateBottomSheetState createState() => RateBottomSheetState();
}

class RateBottomSheetState extends State<RateBottomSheet> {
  double _rating = 1; // Initial rating value

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.shade900,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Rate this Task',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Slider(
            value: _rating,
            min: 1,
            max: 5,
            divisions: 4,
            label: _rating.round().toString(),
            onChanged: (value) {
              setState(() {
                _rating = value;
              });
            },
          ),
          const SizedBox(height: 20),
          Text(
            'Rating: ${_rating.toStringAsFixed(1)}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<ToDoBloc>().add(
                  CompleteToDo(rate: _rating.toInt(), toDoId: widget.todo.id));
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
