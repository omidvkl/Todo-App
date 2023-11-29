import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../widget/my_dialog.dart';
import '../widget/todo_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myTodoBox = Hive.box('MyTodoBox');
  final myController = TextEditingController();
  List mytodos = [];

  // create the database function ...
  // اولین باری که کاربر وارد اپ ما شده و این اطلاعات نمایش داده میشه
  void firstTimeAppRuns(){
    mytodos = [
      ["انجام دادن تکالیف", false],
      ["ورزش کردن در فضای باز", true],
    ];
  }

  //نمایش اطلاعات به یوزر
  void receiveData(){
    mytodos = myTodoBox.get('MyTodoBox');
  }

  void detectTheChanges(){
   myTodoBox.put("MyTodoBox", mytodos);
  }

  void ChangeCheckBoxValue(bool? value, int index) {
    setState(() {
      //این مقدار هر چی که بود برعکسش کن برای تیک
      mytodos[index][1] = !mytodos[index][1];
    });
    detectTheChanges();
  }

  @override
  void initState() {
    if(myTodoBox.get('MyTodoBox')==null){
     return firstTimeAppRuns();
    }else{
      return receiveData();
    }
    super.initState();
  }

  void saveTheTodo() {
    setState(() {
      mytodos.add([myController.text, false]);
      myController.clear();
    });
    detectTheChanges();
    Navigator.of(context).pop();
  }

  void createATodo() {
    showDialog(
      context: context,
      builder: (context) {
        return MyDialog(
          controller: myController,
          saveTheTodo: saveTheTodo,
        );
      },
    );
    detectTheChanges();
  }

  void deleteATodo(int index) {
    setState(() {
      mytodos.removeAt(index);
    });
    detectTheChanges();
  }
  void deleteAllTodos(){
    setState(() {
      mytodos = [];
    });
    detectTheChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('کارهای روزانه من'),
        actions: [
          IconButton(
              onPressed: () => createATodo(),
              icon: const Icon(
                Icons.add,
                size: 30,
              )),IconButton(
              onPressed: () => deleteAllTodos(),
              icon: const Icon(
                Icons.delete,
                size: 30,
              )),
        ],
      ),
      body: ListView.builder(
        itemCount: mytodos.length,
        itemBuilder: (context, index) {
          return TodoWidget(
            todoState: mytodos[index][1],
            todoTitle: mytodos[index][0],
            onChanged: (value) => ChangeCheckBoxValue(value, index),
            deleteTodo: () => deleteATodo(index),
          );
        },
      ),
    );
  }
}
