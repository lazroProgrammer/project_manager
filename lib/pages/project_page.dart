import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasks/core/controllers/segments_controller.dart';
import 'package:tasks/core/notifiers/darkmode_notifier.dart';
import 'package:tasks/database/database.dart';
import 'package:tasks/widgets/darkmode_toggle.dart';
import 'package:tasks/widgets/project_widget.dart';

const STATE_LIST = ["draft", "pending", "on going", "completed"];

class ProjectPage extends ConsumerWidget {
  const ProjectPage({super.key});

  // final List<String> names = [
  //   "Drift Database",
  //   "UI/UX Design",
  //   "State management using riverpod + Getx",
  //   "Write Tests",
  //   "Add some Polish",
  //   "Complete Deployement"
  // ];
  // final List<String> types = [
  //   "sqflite",
  //   "UI/UX",
  //   "UI",
  //   "automated testing",
  //   "animations, UI/UX",
  //   "deployment"
  // ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SegmentsController segmentsController = Get.find(
      tag: "project/segments",
    );
    final dark = ref.watch(darkmodeNotifier);
    return Scaffold(
      appBar: AppBar(title: Text("Segments:"), actions: [DarkmodeToggle()]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ProjectWidget(segmentsController: segmentsController),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.all(8),
        child: FloatingActionButton(
          autofocus: true,
          shape: CircleBorder(side: BorderSide.none),
          onPressed: () {
            showSegmenttAddForum(context, ref, segmentsController);
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

void showSegmenttAddForum(
  BuildContext context,
  WidgetRef ref,
  SegmentsController seg, {
  Segment? segment,
}) {
  showDialog(
    context: context,
    builder: (context) {
      String selectedState = STATE_LIST[0];
      DateTime? selectedTime = segment?.startDate;
      DateTime? deadline = segment?.completionDate;
      final formKey = GlobalKey<FormState>();
      final nameTEC = TextEditingController(text: segment?.name);
      final typeTEC = TextEditingController(text: segment?.type);

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
                final newSegment = SegmentsCompanion.insert(
                  segmentID:
                      (segment != null)
                          ? d.Value(segment.segmentID)
                          : d.Value<int>.absent(),
                  projectID: seg.projectID.value,
                  name: nameTEC.text,
                  type: typeTEC.text,
                  state: selectedState,
                  startDate: d.Value<DateTime?>(selectedTime),
                  completionDate: d.Value<DateTime?>(deadline),
                );
                if (segment == null) {
                  seg.insertSegment(newSegment).then((_) {});
                } else {
                  seg.editSegment(newSegment);
                }

                Navigator.pop(context);
              } else if ((selectedTime != null &&
                  deadline != null &&
                  selectedTime!.compareTo(deadline!) >= 0)) {
                Fluttertoast.showToast(
                  msg: "you can't put the deadline before the project start",
                );
              }
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
                      "Segment:",
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
                        controller: typeTEC,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Type",
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
