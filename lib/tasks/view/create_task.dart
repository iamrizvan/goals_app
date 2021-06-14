import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_goals/tasks/controller/createtask_controller.dart';

class CreateTask extends StatelessWidget {
  CreateTask({Key key}) : super(key: key);
  CreateTaskController _createTaskController = Get.put(CreateTaskController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Customer')),
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
                    child: Column(
                      children: [
                        TextFormField(
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
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Provide task title';
                            }
                            return null;
                          },
                          onSaved: (String title) {
                            _createTaskController.title.value = title;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
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
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Provide task description';
                            }
                            return null;
                          },
                          onSaved: (String desc) {
                            _createTaskController.description.value = desc;
                          },
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
                                          colors: [
                                            Colors.purple,
                                            Colors.blue
                                          ])),
                                  child: Text(
                                    'Create Task',
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
                                _createTaskController.createTasks();
                              }
                            }),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
