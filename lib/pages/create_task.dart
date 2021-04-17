import 'package:flutter/material.dart';
import 'package:my_goals/main.dart';
import 'package:my_goals/models/task.dart';
import 'package:my_goals/services/webservice.dart';
import 'package:page_transition/page_transition.dart';

class CreateTask extends StatefulWidget {
  CreateTask({Key key}) : super(key: key);

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  _CreateTaskState();

  bool _checkboxvalue = false;
  final _formKey = GlobalKey<FormState>();
  String _title;
  String _description;

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
                          onSaved: (String value) {
                            setState(() {
                              _title = value;
                            });
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
                          onSaved: (String value) {
                            setState(() {
                              _description = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CheckboxListTile(
                          title: new Text(
                            'Completed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          activeColor: Colors.green,
                          value: _checkboxvalue,
                          onChanged: (bool newvalue) {
                            setState(() {
                              _checkboxvalue = newvalue;
                            });
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
                                final Map<String, dynamic> newtask = {
                                  "title": _title,
                                  "description": _description,
                                  "completed": _checkboxvalue,
                                  "created_date": DateTime.now().toString()
                                };
                                WebService.createTask(newtask)
                                    .then((createdtask) {
                                  if (createdtask != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                createdtask.title.toString())));
                                    Navigator.pop(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: MyHomePage()));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Task creation was failed.')));
                                  }
                                });
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
