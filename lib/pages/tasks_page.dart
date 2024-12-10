import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasks/core/controllers/dark_mode_controller.dart';
import 'package:tasks/core/controllers/tasks_controller.dart';
import 'package:tasks/core/controllers/todo_controller.dart';
import 'package:tasks/core/notifiers/darkmode_notifier.dart';
import 'package:tasks/database/database.dart';
import 'package:tasks/pages/task_page.dart';

const STATE_LIST = ["draft", "pending", "on going", "completed"];

class TasksPage extends ConsumerWidget {
  TasksPage({super.key});
  final TasksController tasks = Get.find(tag: "segments/tasks");
  final ToggleController toggle =
      Get.put(ToggleController(), tag: "play/pause");
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = ref.watch(darkmodeNotifier);
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(darkmodeNotifier.notifier).toggleDarkmode(dark);
            },
            icon: TweenAnimationBuilder(
                curve: Easing.legacyAccelerate,
                tween: Tween<double>(begin: 0, end: dark ? 0 : 2),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, child) {
                  return Transform.rotate(
                      angle: value * 3.14, // Rotation animation
                      child: Opacity(
                        opacity: (1 - (value % 2)).abs(), // Fading effect
                        child: Icon(
                          dark ? Icons.dark_mode : Icons.light_mode,
                          size: 30,
                          color: dark ? Colors.blue[500] : Colors.yellow[700],
                        ),
                      ));
                }),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(0),
        child: Obx(() {
          return ListView.builder(
            itemCount: tasks.tasks.length,
            itemBuilder: (context, index) => InkWell(
              onLongPress: () {
                showMenu(context: context, position: RelativeRect.fill, items: [
                  CheckedPopupMenuItem(
                    onTap: () {},
                    child: Text("edit"),
                  ),
                  CheckedPopupMenuItem(
                    onTap: () {},
                    child: Text("delete"),
                  ),
                ]);
              },
              onTap: () {
                TodoController todos = Get.put(
                    TodoController(tasks.tasks[index]),
                    tag: "tasks/todos");
                todos.getTodosBytaskID(tasks.tasks[index]);
                Get.to(
                  () => TaskPage(),
                  duration: Duration(milliseconds: 400),
                  transition: Transition.fade,
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8),
                color: (tasks.tasks[index].completionDate == null)
                    ? null
                    : dark
                        ? Colors.green[700]
                        : Colors.green[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: (tasks.tasks[index].completionDate == null)
                          ? Icon(
                              Icons.circle_outlined,
                              size: 36,
                            )
                          : Icon(
                              Icons.check_circle_outline,
                              color:
                                  dark ? Colors.green[900]! : Colors.green[700],
                              size: 40,
                            ),
                    ),
                    Expanded(
                        child: Text(
                      "Task ${index + 1}: ${tasks.tasks[index].name}",
                      style: TextStyle(fontSize: 18),
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: tasks.tasks[index].completionDate != null
                          ? Container()
                          : Obx(() {
                              final isPlayed = toggle.isPlayed.value;
                              return IconButton(
                                onPressed: () {
                                  toggle.toggle();
                                },
                                icon: TweenAnimationBuilder(
                                    curve: Easing.legacy,
                                    tween: Tween<double>(
                                        begin: 0, end: isPlayed ? 0 : 2),
                                    duration: const Duration(milliseconds: 80),
                                    builder: (context, value, child) {
                                      return Transform.rotate(
                                          angle: value *
                                              3.14, // Rotation animation
                                          child: Opacity(
                                            opacity: (1 - (value % 2))
                                                .abs(), // Fading effect
                                            child: Icon(
                                              isPlayed
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              size: 30,
                                            ),
                                          ));
                                    }),
                              );
                            }),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.all(8),
        child: FloatingActionButton(
          autofocus: true,
          shape: CircleBorder(side: BorderSide.none),
          onPressed: () {
            showTaskstAddForum(context, ref, tasks);
          },
          backgroundColor:
              dark ? Color.fromARGB(255, 187, 187, 187) : Colors.grey[800],
          // Colors.grey[900],
          // foregroundColor: Colors.white,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

void showTaskstAddForum(
    BuildContext context, WidgetRef ref, TasksController taskCon) {
  showDialog(
      context: context,
      builder: (context) {
        String selectedState = STATE_LIST[0];
        DateTime selectedTime = DateTime.now().copyWith(second: 0, minute: 0);
        DateTime deadline = DateTime.now().copyWith(second: 0, minute: 0);
        final formKey = GlobalKey<FormState>();
        final nameTEC = TextEditingController();
        final descriptTEC = TextEditingController();
        final priorityTEC = TextEditingController();

        return AlertDialog(
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context), child: Text("cancel")),
            ElevatedButton(
                onPressed: () async {
                  bool isValid = formKey.currentState!.validate();
                  if (isValid && selectedTime.compareTo(deadline) < 0) {
                    final newTask = TasksCompanion.insert(
                        segmentID: taskCon.segmentID.value,
                        name: nameTEC.text,
                        description: descriptTEC.text,
                        state: selectedState,
                        priority: int.parse(priorityTEC.text),
                        startDate: drift.Value<DateTime?>(selectedTime),
                        completionDate: drift.Value<DateTime?>(null),
                        createdAt: DateTime.now());
                    await taskCon.insertTask(newTask);
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
                height: 400,
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          "Task:",
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: TextFormField(
                            controller: descriptTEC,
                            maxLines: 2,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: "Description",
                              prefixIcon: const Icon(Icons.type_specimen),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim() == "") {
                                return "add a description";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: TextFormField(
                            controller: priorityTEC,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: "priority",
                              prefixIcon: const Icon(Icons.abc_rounded),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim() == "") {
                                return "insert a number";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: ListTile(
                            title: Text("State:"),
                            trailing: DropdownButton<String>(
                              value: selectedState,
                              onChanged: (String? newValue) {
                                setState(
                                  () {
                                    selectedState = newValue ?? STATE_LIST[0];
                                  },
                                );
                              },
                              items: STATE_LIST.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
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
                        // Container(
                        //   padding:
                        //       EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                        //   child: Row(
                        //     children: [
                        //       Text("Deadline: "),
                        //       Text(DateFormat('d/M/y').format(deadline)),
                        //       IconButton(
                        //           onPressed: () async {
                        //             final now = DateTime.now();
                        //             final DateTime? picked =
                        //                 await showDatePicker(
                        //                     firstDate: now.copyWith(
                        //                         year: now.year - 10),
                        //                     lastDate: now.copyWith(
                        //                         year: now.year + 10),
                        //                     context: context,
                        //                     initialDate: deadline,
                        //                     initialEntryMode:
                        //                         DatePickerEntryMode.input);
                        //             if (picked != null && picked != deadline) {
                        //               setState(() {
                        //                 deadline = picked;
                        //               });
                        //             }
                        //           },
                        //           icon: Icon(Icons.access_time))
                        //     ],
                        //   ),
                        // ),
                      ],
                    )));
          }),
        );
      });
}
