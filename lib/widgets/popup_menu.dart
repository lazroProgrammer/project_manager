import 'package:flutter/material.dart';

dynamic showPopupMenu(BuildContext context, GlobalKey key,
    {required Function() edit, required Function() delete}) {
  return showMenu(
      context: context,
      position: calculateBottomRightPosition(context, key),
      items: [
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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ))),
                  );
                });
          },
          child: Text("delete"),
        ),
      ]);
}

RelativeRect calculateBottomRightPosition(BuildContext context, GlobalKey key) {
  if (key.currentContext == null) {
    // If the widget has not been built yet, return null or handle appropriately
    return RelativeRect.fill;
  }
  final RenderBox renderBox =
      key.currentContext!.findRenderObject() as RenderBox;
  final Offset widgetPosition = renderBox.localToGlobal(Offset.zero);
  final Size widgetSize = renderBox.size;
  final Size screenSize = MediaQuery.of(context).size;

  return RelativeRect.fromLTRB(
    widgetPosition.dx + widgetSize.width * 0.75,
    widgetPosition.dy + widgetSize.height * 0.65,
    screenSize.width - widgetPosition.dx - widgetSize.width,
    screenSize.height - widgetPosition.dy - widgetSize.height,
  );
}
