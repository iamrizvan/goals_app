import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_goals/tasks/controller/tasks_controller.dart';
import 'package:my_goals/tasks/view/create_task.dart';
import 'package:my_goals/tasks/view/edit_task.dart';

class HomePage extends StatelessWidget {
  TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Center(
          child: buildBody(),
        ));
  }

  Container buildBody() {
    return Container(
      decoration: BoxDecoration(color: Colors.purple),
      child: Obx(() => _taskController.isLoading.value
          ? Container(
              height: Get.height,
              width: Get.width,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  backgroundColor: Colors.white,
                ),
              ),
            )
          : ListView.builder(
              itemCount: _taskController.rxTasks.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(5),
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.purple,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Colors.purple, Colors.blue]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, top: 5, bottom: 5),
                                child: Text(
                                    _taskController.rxTasks[index].title,
                                    style: TextStyle(
                                        fontFamily: 'Neo',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 20)),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                          _taskController
                                              .rxTasks[index].description,
                                          style: TextStyle(
                                              fontFamily: 'Neo',
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w200)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        DateFormat("HH:mm a").format(
                                            DateTime.parse(_taskController
                                                .rxTasks[index].created_date)),
                                        style: TextStyle(
                                            fontFamily: 'Neo',
                                            fontWeight: FontWeight.w100,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 20,
                      child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: GestureDetector(
                            child: Icon(
                              Icons.edit_rounded,
                            ),
                            onTap: () {
                              _taskController.currentIndex.value = index;
                              _taskController.updateCurrentTask();
                              Get.to(EditTask());
                            },
                          )),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: GestureDetector(
                          child: Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.red,
                          ),
                          onTap: () {
                            Get.snackbar(
                                'Delete', 'Do you want to delete this task?',
                                snackPosition: SnackPosition.BOTTOM,
                                mainButton: TextButton(
                                    onPressed: () {
                                      _taskController.deleteTask(index);
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    )));
                          },
                        ),
                      ),
                    ),
                    _taskController.rxTasks[index].completed == null
                        ? SizedBox()
                        : _taskController.rxTasks[index].completed
                            ? Positioned(
                                top: 0,
                                right: 30,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: GestureDetector(
                                    child: Icon(
                                      Icons.check,
                                      size: 20,
                                      color: Colors.green,
                                    ),
                                    onTap: () {
                                      final snackBar = SnackBar(
                                          content: Text(
                                              'This task has been completed!'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                  ),
                                ),
                              )
                            : SizedBox()
                  ]),
                );
              },
            )),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.purple,
        title: Text(
          'Tasks',
          style: TextStyle(
            fontFamily: 'Neo',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: SvgPicture.asset(
              "assets/images/plus.svg",
              width: 22,
              height: 22,
            ),
            onPressed: () {
              Get.to(CreateTask());
            }));
  }
}
