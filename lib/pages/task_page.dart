import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("task 1"),
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
                    "Create a flutter App",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  Text(
                      "     JSX stands for JavaScript XML. JSX allows us to write HTML elements with JavaScript code. An HTML element has an opening and closing tags, content, and attribute in the opening tag. However, some HTML elements may not have content and a closing tag - they are self closing elements. To create HTML elements in React we do not use the createElement() instead we just use JSX elements. Therefore, JSX makes it easier to write and add HTML elements in React. JSX will be converted to JavaScript on browser using a transpiler - babel.js. Babel is a library which transpiles JSX to pure JavaScript and latest JavaScript to older version. See the JSX code below."),
                ],
              ),
            ),
            ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => CheckboxListTile(
                value: true,
                onChanged: (value) {},
                title: Text("Todo $index:"),
                subtitle: Text("Completed at: 8-11-2024 at 20:00"),
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }
}
