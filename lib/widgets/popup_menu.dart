import 'package:flutter/material.dart';

dynamic showPopupMenu(BuildContext context,
    {required Function() edit, required Function() delete}) {
  return showMenu(context: context, position: RelativeRect.fill, items: [
    CheckedPopupMenuItem(
      onTap: edit,
      child: Text("edit"),
    ),
    CheckedPopupMenuItem(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("cancel")),
                  ElevatedButton(
                      onPressed: () {
                        delete();
                        Navigator.pop(context);
                      },
                      child: Text("ok"))
                ],
                content: SizedBox(
                    height: 100,
                    child: Center(
                        child: Text(
                      "Are you sure?",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ))),
              );
            });
      },
      child: Text("delete"),
    ),
  ]);
}
