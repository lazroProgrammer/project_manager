import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasks/core/controllers/tasks_controller.dart';
import 'package:tasks/core/controllers/todo_controller.dart';
import 'package:tasks/core/notifiers/darkmode_notifier.dart';
import 'package:tasks/database/database.dart';
import 'package:tasks/widgets/popup_menu.dart';

class TaskPage extends ConsumerWidget {
  TaskPage({super.key, required this.taskCtrller, required this.taskIndex});
  final TasksController taskCtrller;
  final TodoController todo = Get.find(tag: "tasks/todos");

  final int taskIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = ref.watch(darkmodeNotifier);
    return Scaffold(
        appBar: AppBar(
          title: Text(taskCtrller.tasks[taskIndex].name),
          actions: [
            Obx(() {
              final isPlayed = taskCtrller.tasks[taskIndex].startDate != null;

              return IconButton(
                onPressed: () {
                  taskCtrller.togglePlayTask(taskIndex, !isPlayed);
                },
                icon: TweenAnimationBuilder(
                    curve: Easing.legacy,
                    tween: Tween<double>(begin: 0, end: isPlayed ? 0 : 2),
                    duration: const Duration(milliseconds: 50),
                    builder: (context, value, child) {
                      return Transform.rotate(
                          angle: value * 3.14, // Rotation animation
                          child: Opacity(
                            opacity: (1 - (value % 2)).abs(), // Fading effect
                            child: Icon(
                              isPlayed ? Icons.pause : Icons.play_arrow,
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
                      taskCtrller.tasks[taskIndex].name,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    Text(taskCtrller.tasks[taskIndex].description)
                    // Text(
                    //     "     JSX stands for JavaScript XML. JSX allows us to write HTML elements with JavaScript code. An HTML element has an opening and closing tags, content, and attribute in the opening tag. However, some HTML elements may not have content and a closing tag - they are self closing elements. To create HTML elements in React we do not use the createElement() instead we just use JSX elements. Therefore, JSX makes it easier to write and add HTML elements in React. JSX will be converted to JavaScript on browser using a transpiler - babel.js. Babel is a library which transpiles JSX to pure JavaScript and latest JavaScript to older version. See the JSX code below."),
                  ],
                ),
              ),
              Obx(() {
                final posKeys =
                    List.generate(todo.todos.length, (_) => GlobalKey());
                return ListView.builder(
                  itemCount: todo.todos.length,
                  itemBuilder: (context, index) {
                    final completedAt = todo.todos[index].completedAt;
                    return Obx(() {
                      final isPlayed =
                          taskCtrller.tasks[taskIndex].startDate != null;
                      return InkWell(
                        onLongPress: () {
                          showPopupMenu(
                            context,
                            posKeys[index],
                            edit: () {
                              showTodosAddForum(context, ref, todo,
                                  todo: todo.todos[index]);
                            },
                            delete: () {
                              todo.deleteTodoById(todo.todos[index].todoID);
                            },
                          );
                        },
                        child: CheckboxListTile(
                          value: completedAt != null,
                          onChanged: !isPlayed
                              ? null
                              : (value) {
                                  todo.toggleTodo(index, value ?? false);
                                },
                          title: Text(todo.todos[index].name),
                          subtitle: Text((completedAt == null)
                              ? "not completed"
                              : "Completed at: ${DateFormat('d/M/y hh:mm').format(completedAt)}"),
                        ),
                      );
                    });
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
    BuildContext context, WidgetRef ref, TodoController todoCon,
    {Todo? todo}) {
  showDialog(
      context: context,
      builder: (context) {
        DateTime? selectedTime = todo?.startedAt;
        final formKey = GlobalKey<FormState>();
        final nameTEC = TextEditingController(text: todo?.name);
        return AlertDialog(
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context), child: Text("cancel")),
            ElevatedButton(
                onPressed: () async {
                  bool isValid = formKey.currentState!.validate();
                  if (isValid) {
                    final newTodo = TodosCompanion.insert(
                        todoID: (todo != null)
                            ? d.Value(todo.todoID)
                            : d.Value<int>.absent(),
                        taskID: todoCon.taskID.value,
                        name: nameTEC.text,
                        startedAt: d.Value<DateTime?>(selectedTime),
                        completedAt: d.Value<DateTime?>(todo?.completedAt));

                    if (todo == null) {
                      todoCon.insertTodo(newTodo).then((_) {});
                    } else {
                      todoCon.editTodo(newTodo);
                    }
                    Navigator.pop(context);
                  }
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
                              Text((selectedTime == null)
                                  ? "None"
                                  : DateFormat('d/M/y').format(selectedTime!)),
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
