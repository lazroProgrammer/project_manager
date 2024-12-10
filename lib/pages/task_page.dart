import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasks/core/controllers/dark_mode_controller.dart';
import 'package:tasks/core/controllers/todo_controller.dart';
import 'package:tasks/core/notifiers/darkmode_notifier.dart';
import 'package:tasks/database/database.dart';

class TaskPage extends ConsumerWidget {
  TaskPage({super.key});

  final TodoController todo = Get.find(tag: "tasks/todos");
  final ToggleController toggle = Get.find(tag: "play/pause");
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = ref.watch(darkmodeNotifier);
    return Scaffold(
        appBar: AppBar(
          title: Text(todo.task.value.name),
          actions: [
            Obx(() {
              return IconButton(
                onPressed: () {
                  toggle.toggle();
                },
                icon: TweenAnimationBuilder(
                    curve: Easing.legacy,
                    tween: Tween<double>(
                        begin: 0, end: toggle.isPlayed.value ? 0 : 2),
                    duration: const Duration(milliseconds: 50),
                    builder: (context, value, child) {
                      return Transform.rotate(
                          angle: value * 3.14, // Rotation animation
                          child: Opacity(
                            opacity: (1 - (value % 2)).abs(), // Fading effect
                            child: Icon(
                              toggle.isPlayed.value
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 30,
                              // color: isPlayed ? Colors.blue[500] : Colors.yellow[700],
                            ),
                          ));
                    }),
              );
            })
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(0),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.task.value.name,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    Text(todo.task.value.description)
                    // Text(
                    //     "     JSX stands for JavaScript XML. JSX allows us to write HTML elements with JavaScript code. An HTML element has an opening and closing tags, content, and attribute in the opening tag. However, some HTML elements may not have content and a closing tag - they are self closing elements. To create HTML elements in React we do not use the createElement() instead we just use JSX elements. Therefore, JSX makes it easier to write and add HTML elements in React. JSX will be converted to JavaScript on browser using a transpiler - babel.js. Babel is a library which transpiles JSX to pure JavaScript and latest JavaScript to older version. See the JSX code below."),
                  ],
                ),
              ),
              Obx(() {
                return ListView.builder(
                  itemCount: todo.todos.length,
                  itemBuilder: (context, index) {
                    final completedAt = todo.todos[index].completedAt;
                    return CheckboxListTile(
                      value: completedAt != null,
                      onChanged: (value) {
                        todo.toggleTodo(index, value ?? false);
                      },
                      title: Text(todo.todos[index].name),
                      subtitle: Text((completedAt == null)
                          ? "not completed"
                          : "Completed at: ${DateFormat('d/M/y hh:mm').format(completedAt)}"),
                    );
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                );
              }),
            ],
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.all(16),
          child: FloatingActionButton(
            autofocus: true,
            shape: CircleBorder(side: BorderSide.none),
            onPressed: () {
              showTodosAddForum(context, ref, todo);
            },
            backgroundColor:
                dark ? Color.fromARGB(255, 187, 187, 187) : Colors.grey[800],
            // Colors.grey[900],
            // foregroundColor: Colors.white,
            child: Icon(Icons.add),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}

void showTodosAddForum(
    BuildContext context, WidgetRef ref, TodoController todoCon) {
  showDialog(
      context: context,
      builder: (context) {
        DateTime selectedTime = DateTime.now().copyWith(second: 0, minute: 0);
        DateTime deadline = DateTime.now().copyWith(second: 0, minute: 0);
        final formKey = GlobalKey<FormState>();
        final nameTEC = TextEditingController();

        return AlertDialog(
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context), child: Text("cancel")),
            ElevatedButton(
                onPressed: () async {
                  bool isValid = formKey.currentState!.validate();
                  if (isValid && selectedTime.compareTo(deadline) < 0) {
                    final newTodo = TodosCompanion.insert(
                        taskID: todoCon.task.value.taskID,
                        name: nameTEC.text,
                        startedAt: drift.Value<DateTime?>(selectedTime),
                        completedAt: drift.Value<DateTime?>(null));
                    await todoCon.insertTodo(newTodo);
                  } else if (selectedTime.compareTo(deadline) >= 0) {
                    Fluttertoast.showToast(
                        msg:
                            "you can't put the deadline before the project start");
                  }

                  Navigator.pop(context);
                },
                child: Text("add"))
          ],
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                height: 230,
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          "Todo:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: TextFormField(
                            controller: nameTEC,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: "name",
                              prefixIcon: const Icon(Icons.abc_rounded),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim() == "") {
                                return "insert a name";
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                          child: Row(
                            children: [
                              Text("Start-Time: "),
                              Text(DateFormat('d/M/y').format(selectedTime)),
                              IconButton(
                                  onPressed: () async {
                                    final now = DateTime.now();
                                    final DateTime? picked =
                                        await showDatePicker(
                                            firstDate: now.copyWith(
                                                year: now.year - 1),
                                            lastDate: now.copyWith(
                                                year: now.year + 10),
                                            context: context,
                                            initialDate: selectedTime,
                                            initialEntryMode:
                                                DatePickerEntryMode.input);
                                    if (picked != null &&
                                        picked != selectedTime) {
                                      setState(() {
                                        selectedTime = picked;
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.access_time))
                            ],
                          ),
                        ),
                      ],
                    )));
          }),
        );
      });
}
