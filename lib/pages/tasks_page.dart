import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasks/core/controllers/tasks_controller.dart';
import 'package:tasks/core/notifiers/darkmode_notifier.dart';
import 'package:tasks/database/database.dart';
import 'package:tasks/widgets/tasks_widget.dart';

const STATE_LIST = ["draft", "pending", "on going", "completed"];

class TasksPage extends ConsumerWidget {
  TasksPage({super.key});
  final TasksController tasks = Get.find(tag: "segments/tasks");
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = ref.watch(darkmodeNotifier);
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(darkmodeNotifier.notifier).toggleDarkmode(!dark);
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
          margin: EdgeInsets.all(0), child: TasksWidget(tasks: tasks)),
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
    BuildContext context, WidgetRef ref, TasksController taskCon,
    {Task? task}) {
  showDialog(
      context: context,
      builder: (context) {
        String selectedState = STATE_LIST[0];
        DateTime? selectedTime = task?.startDate;
        DateTime? deadline = task?.completionDate;
        final formKey = GlobalKey<FormState>();
        final nameTEC = TextEditingController(text: task?.name);
        final descriptTEC = TextEditingController(text: task?.description);
        final priorityTEC =
            TextEditingController(text: task?.priority.toString());

        return AlertDialog(
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context), child: Text("cancel")),
            ElevatedButton(
                onPressed: () {
                  bool isValid = formKey.currentState!.validate();
                  if (isValid &&
                      (selectedTime == null ||
                          deadline == null ||
                          selectedTime != null &&
                              deadline != null &&
                              selectedTime!.compareTo(deadline!) < 0)) {
                    final newTask = TasksCompanion.insert(
                        taskID: (task != null)
                            ? d.Value(task.taskID)
                            : d.Value<int>.absent(),
                        segmentID: taskCon.segmentID.value,
                        name: nameTEC.text,
                        description: descriptTEC.text,
                        state: selectedState,
                        priority: int.parse(priorityTEC.text),
                        startDate: d.Value<DateTime?>(selectedTime),
                        completionDate: d.Value<DateTime?>(null),
                        createdAt: DateTime.now());
                    if (task == null) {
                      taskCon.insertTask(newTask).then((_) {});
                    } else {
                      taskCon.editTask(newTask);
                    }
                    Navigator.pop(context);
                  } else {
                    if (selectedTime != null &&
                        deadline != null &&
                        selectedTime!.compareTo(deadline!) >= 0) {
                      Fluttertoast.showToast(
                          msg:
                              "you can't put the deadline before the project start");
                    }
                  }
                },
                child: Text("add"))
          ],
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                height: 470,
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
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: "priority",
                              prefixIcon: const Icon(Icons.abc_rounded),
                            ),
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
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                          child: Row(
                            children: [
                              Text("Deadline: "),
                              Text((deadline == null)
                                  ? "None"
                                  : DateFormat('d/M/y').format(deadline!)),
                              IconButton(
                                  onPressed: () async {
                                    final now = DateTime.now();
                                    final DateTime? picked =
                                        await showDatePicker(
                                            firstDate: now.copyWith(
                                                year: now.year - 10),
                                            lastDate: now.copyWith(
                                                year: now.year + 10),
                                            context: context,
                                            initialDate: deadline,
                                            initialEntryMode:
                                                DatePickerEntryMode.input);
                                    if (picked != null && picked != deadline) {
                                      setState(() {
                                        deadline = picked;
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
