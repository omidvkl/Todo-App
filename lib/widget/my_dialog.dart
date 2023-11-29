import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  VoidCallback saveTheTodo;
  final controller;
  MyDialog({super.key,  required this.saveTheTodo,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
          height: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               TextField(
                controller: controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'کار امروزت رو بنویس',
                    hintStyle: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      onPressed: saveTheTodo,
                      child: const Text(
                        'ذخیره کار امروز',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
