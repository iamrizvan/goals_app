import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_goals/tasks/controller/edittask_controller.dart';
import 'package:my_goals/tasks/controller/tasks_controller.dart';

class EditTask extends StatelessWidget {
  UpdateTaskController _updateTaskController = Get.put(UpdateTaskController());
  TaskController _taskController = Get.find<TaskController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Customer',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(color: Colors.purple),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(children: [
                      _taskController.currentTask() == null
                          ? SizedBox()
                          : Obx(
                              () => TextFormField(
                                initialValue:
                                    _taskController.currentTask.value.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                cursorColor: Colors.white,
                                showCursor: true,
                                decoration: InputDecoration(
                                    hintText: "Title",
                                    hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                    )),
                                onSaved: (String ttl) {
                                  _updateTaskController.title.value = ttl;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Provide task title';
                                  }
                                  return null;
                                },
                              ),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      _taskController.currentTask() == null
                          ? SizedBox()
                          : Obx(
                              () => TextFormField(
                                initialValue: _taskController
                                    .currentTask.value.description,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                cursorColor: Colors.white,
                                showCursor: true,
                                decoration: InputDecoration(
                                    hintText: "Description",
                                    hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                    )),
                                maxLines: 8,
                                onSaved: (String desc) {
                                  _updateTaskController.description.value =
                                      desc;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Provide task description';
                                  }
                                  return null;
                                },
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => CheckboxListTile(
                          title: new Text(
                            'Completed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          activeColor: Colors.green,
                          checkColor: Colors.white,
                          value: _updateTaskController.checkboxvalue.value,
                          onChanged: (bool newvalue) {
                            _updateTaskController.checkboxvalue.value =
                                newvalue;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: MediaQuery.of(context).size.width - 20,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [Colors.purple, Colors.blue])),
                                child: Text(
                                  'Update Task',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ),
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              _updateTaskController.updateTasks();
                            }
                          }),
                    ]),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
