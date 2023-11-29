import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {
  TodoWidget({
    super.key,
    required this.todoState,
    required this.todoTitle,
    required this.onChanged,
    required this.deleteTodo,
  });

  final String todoTitle;
  final bool todoState;
  Function(bool?)? onChanged;
  VoidCallback? deleteTodo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            IconButton(
                onPressed: deleteTodo,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                  size: 30,
                )),
            Checkbox(value: todoState, onChanged: onChanged),
            Expanded(
              child: Text(
                todoTitle,
                style: TextStyle(
                  //وقتی todoState تیک خورد یه خط روش بکشه در عیر اینصورت هیچی
                  decoration: todoState
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
