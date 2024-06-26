import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_fire/providers/task_provider.dart';
import 'package:todo_fire/providers/theme_provider.dart';
import 'package:todo_fire/utils/task.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.taskName,
    required this.taskProvider,
    required this.user,
    required this.updateParent,
  });

  final Task taskName;
  final TaskProvider taskProvider;
  final User user;
  final Function() updateParent;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool checked = false;
  ThemeProvider provider = ThemeProvider();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
      ),
      decoration: BoxDecoration(
        color: provider.colorScheme.primary,
        border: Border.all(
          width: 1,
          // color: Colors.black12,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
              value: checked,
              onChanged: (value) {
                setState(() {
                  checked = value!;
                  if (value == true) {
                    Timer(const Duration(seconds: 3), () {
                      // widget.deleteItem(() {
                      widget.taskProvider.removeTask(widget.taskName.id);
                      widget.taskProvider.setData(widget.user);
                      widget.updateParent();
                      // });
                    });
                  }
                });
              },
              shape: const CircleBorder(),
              checkColor: provider.isDark ? Colors.black : Colors.white,
              // activeColor:
              //     provider.isDark ? Colors.white : Colors.grey.shade800,
              // overlayColor: WidgetStateProperty.all(
              //   provider.isDark ? Colors.white : Colors.black,
              hoverColor: Colors.white,
              side: const BorderSide(color: Colors.white, width: 1.5),
            ),
          ),
          Text(
            widget.taskName.task,
            style: GoogleFonts.roboto(
              color: provider.colorScheme.onPrimary,
              decoration:
                  !checked ? TextDecoration.none : TextDecoration.lineThrough,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
