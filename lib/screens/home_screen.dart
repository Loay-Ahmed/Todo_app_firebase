import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_fire/providers/task_provider.dart';
import 'package:todo_fire/providers/theme_provider.dart';
import 'package:todo_fire/services/firestore_service.dart';
import 'package:todo_fire/widgets/custom_input.dart';
import 'package:todo_fire/widgets/list_item.dart';

import '../utils/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController taskController = TextEditingController();

  final TaskProvider taskProvider = TaskProvider();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      taskProvider.getData(user!);
    });
  }

  void refreshList() {
    setState(() {
      taskProvider.tasks.add(Task(task: taskController.text.trim()));
      taskController.text = "";
      taskProvider.setData(user!);
    });
  }

  void updateState() {
    setState(() {
      taskProvider.getData(user!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    final themeProvider = Provider.of<ThemeProvider>(context);
    updateState();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          themeProvider.toggleTheme();
                        });
                      },
                      icon: Icon(
                        Icons.brightness_6,
                        color:
                            themeProvider.isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      "Tasks",
                      style: GoogleFonts.roboto(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color:
                            themeProvider.isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        auth.signOut();
                        Navigator.pushReplacementNamed(context, "Auth");
                      },
                      child: Text(
                        user!.email != "" ? user!.email! : "Guest",
                        style: TextStyle(
                          color: themeProvider.isDark
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
            FutureBuilder<List<Task>>(
              future: taskProvider.getData(user!),
              builder: (context, snapshot) {
                return Expanded(
                  child: ListView.separated(
                    itemCount: taskProvider.tasks.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskName: taskProvider.tasks[index],
                        taskProvider: taskProvider,
                        user: user!,
                        updateParent: updateState,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                taskProvider.clearTasks();
                taskProvider.setData(user!);
              });
            },
            icon: Icon(
              Icons.menu,
              color: themeProvider.isDark ? Colors.white : Colors.black,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    // backgroundColor: themeProvider.isDark
                    //     ? myColors.colorScheme.onPrimaryContainer
                    //     : myColors.colorScheme.onPrimary,
                    title: Text(
                      "Add Task",
                      style: GoogleFonts.roboto(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        // color: themeProvider.isDark
                        //     ? myColors.white
                        //     : myColors.black,
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomInput(
                          label: "Task",
                          controller: taskController,
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          refreshList();
                          taskProvider.printTasks();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          // shadowColor: Colors.black,
                          // backgroundColor: myColors.black,
                        ),
                        child: Text(
                          "Add",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            // color: myColors.white,
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            },
            icon: Icon(
              Icons.add,
              color: themeProvider.colorScheme.primaryFixed,
              size: 45,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.watch_later_rounded,
              color: themeProvider.isDark ? Colors.white : Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
