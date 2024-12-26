import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasks/core/controllers/projects_controller.dart';
import 'package:tasks/core/notifiers/darkmode_notifier.dart';
import 'package:tasks/database/database.dart';
import 'package:tasks/pages/dashboard.dart';
import 'package:tasks/pages/projects_page.dart';

const SELECTION_COLOR = Colors.blue;
const STATE_LIST = ["draft", "pending", "on going", "completed"];

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int _currentIndex = 0;

  final projects = Get.find<ProjectsController>(tag: "projects");
  @override
  Widget build(BuildContext context) {
    final dark = ref.watch(darkmodeNotifier);
    return Scaffold(
      body: switch (_currentIndex) {
        0 => Dashboard(),
        1 => const ProjectsPage(),
        // 2 => Container(),
        // 3 => Container(),
        int() => null,
      },
      bottomNavigationBar: BottomAppBar(
        height: 76,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                shape: OvalBorder(),
                textColor: (_currentIndex == 0) ? SELECTION_COLOR : Colors.grey,
                child: Column(
                  children: [
                    Icon(Icons.dashboard, size: (_currentIndex == 0) ? 30 : 26),
                    Text(
                      "Dashboard",
                      style: TextStyle(
                        fontSize: (_currentIndex == 0) ? 13 : 12,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              // MaterialButton(
              //     shape: OvalBorder(),
              //     textColor:
              //         (_currentIndex == 1) ? SELECTION_COLOR : Colors.grey,
              //     child: Column(
              //       children: [
              //         const Icon(Icons.bar_chart_sharp),
              //         Text(
              //           "Analytics",
              //           style:
              //               TextStyle(fontSize: (_currentIndex == 1) ? 13 : 12),
              //         ),
              //       ],
              //     ),
              //     onPressed: () {
              //       setState(() {
              //         _currentIndex = 1;
              //       });
              //     }),
              MaterialButton(
                shape: OvalBorder(),
                textColor: (_currentIndex == 1) ? SELECTION_COLOR : Colors.grey,
                child: Column(
                  children: [
                    Icon(
                      Icons.folder_special,
                      size: (_currentIndex == 1) ? 30 : 26,
                    ),
                    Text(
                      "Projects",
                      style: TextStyle(
                        fontSize: (_currentIndex == 1) ? 14 : 12,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              // MaterialButton(
              //     shape: OvalBorder(),
              //     textColor:
              //         (_currentIndex == 3) ? SELECTION_COLOR : Colors.grey,
              //     child: Column(
              //       children: [
              //         const Icon(Icons.person),
              //         Text("Me",
              //             style: TextStyle(
              //                 fontSize: (_currentIndex == 3) ? 13 : 12)),
              //       ],
              //     ),
              //     onPressed: () {
              //       setState(() {
              //         _currentIndex = 3;
              //       });
              //     }),
            ],
          ),
        ),
        // currentIndex: _currentIndex,
        // onTap: (index) {
        //   setState(() {
        //     _currentIndex = index;
        //   });
        // }),
      ),
      floatingActionButton: FloatingActionButton(
        autofocus: true,
        shape: CircleBorder(side: BorderSide.none),
        onPressed: () {
          showProjectAddForum(context, ref, projects);
        },
        backgroundColor:
            dark ? Color.fromARGB(255, 187, 187, 187) : Colors.grey[800],
        // Colors.grey[900],
        // foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

void showProjectAddForum(
  BuildContext context,
  WidgetRef ref,
  ProjectsController p, {
  Project? project,
}) {
  showDialog(
    context: context,
    builder: (context) {
      String selectedState = STATE_LIST[0];
      DateTime? selectedTime = project?.startDate;
      DateTime? deadline = project?.completionDate;
      final formKey = GlobalKey<FormState>();
      final nameTEC = TextEditingController(text: project?.name);
      final descriptTEC = TextEditingController(text: project?.description);

      return AlertDialog(
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              bool isValid = formKey.currentState!.validate();
              if (isValid &&
                  (selectedTime == null ||
                      deadline == null ||
                      selectedTime != null &&
                          deadline != null &&
                          selectedTime!.compareTo(deadline!) < 0)) {
                final newProject = ProjectsCompanion.insert(
                  projectID:
                      (project != null)
                          ? d.Value(project.projectID)
                          : d.Value<int>.absent(),
                  name: nameTEC.text,
                  description: descriptTEC.text,
                  state: selectedState,
                  startDate: d.Value<DateTime?>(selectedTime),
                  completionDate: d.Value<DateTime?>(deadline),
                  createdAt: DateTime.now(),
                );
                if (project == null) {
                  p.insertProject(newProject).then((_) {});
                } else {
                  p.editProject(newProject);
                }
                Navigator.pop(context);
              } else {
                if (selectedTime != null &&
                    deadline != null &&
                    selectedTime!.compareTo(deadline!) >= 0) {
                  Fluttertoast.showToast(
                    msg: "you can't put the deadline before the project start",
                  );
                }
              }
              // ref
              //     .read(mealPeriodsNotifier.notifier)
              //     .insert(MealPeriodsCompanion.insert(
              //       type: selectedMealPeriod.value!,
              //       startTime: DateTime.now().copyWith(
              //           hour: selectedTime.hour,
              //           minute: selectedTime.minute),
              //       endTime: DateTime.now().copyWith(
              //           hour: selectedTime.hour,
              //           minute: selectedTime.minute),
              //     ));
            },
            child: Text("add"),
          ),
        ],
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              width: MediaQuery.of(context).size.width - 120,
              height: 450,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      "Project:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: TextFormField(
                        controller: nameTEC,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "name",
                          prefixIcon: const Icon(Icons.numbers),
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
                          prefixIcon: const Icon(Icons.numbers),
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
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: ListTile(
                        title: Text("State:"),
                        trailing: DropdownButton<String>(
                          value: selectedState,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedState = newValue ?? STATE_LIST[0];
                            });
                          },
                          items:
                              STATE_LIST.map<DropdownMenuItem<String>>((
                                String value,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          Text("Start-Time: "),
                          Text(
                            (selectedTime == null)
                                ? "None"
                                : DateFormat('d/M/y').format(selectedTime!),
                          ),
                          IconButton(
                            onPressed: () async {
                              final now = DateTime.now();
                              final DateTime? picked = await showDatePicker(
                                firstDate: now.copyWith(year: now.year - 1),
                                lastDate: now.copyWith(year: now.year + 10),
                                context: context,
                                initialDate: selectedTime,
                                initialEntryMode: DatePickerEntryMode.input,
                              );
                              if (picked != null && picked != selectedTime) {
                                setState(() {
                                  selectedTime = picked;
                                });
                              }
                            },
                            icon: Icon(Icons.access_time),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          Text("Deadline: "),
                          Text(
                            (deadline == null)
                                ? "None"
                                : DateFormat('d/M/y').format(deadline!),
                          ),
                          IconButton(
                            onPressed: () async {
                              final now = DateTime.now();
                              final DateTime? picked = await showDatePicker(
                                firstDate: now.copyWith(year: now.year - 10),
                                lastDate: now.copyWith(year: now.year + 10),
                                context: context,
                                initialDate: deadline,
                                initialEntryMode: DatePickerEntryMode.input,
                              );
                              if (picked != null && picked != deadline) {
                                setState(() {
                                  deadline = picked;
                                });
                              }
                            },
                            icon: Icon(Icons.access_time),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
