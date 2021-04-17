import 'package:flutter/material.dart';
import 'package:my_goals/main.dart';
import 'package:my_goals/models/task.dart';
import 'package:my_goals/services/webservice.dart';
import 'package:page_transition/page_transition.dart';

class EditTask extends StatefulWidget {
  final Task task;
  EditTask({Key key, @required this.task}) : super(key: key);

  @override
  _EditTaskState createState() => _EditTaskState(task);
}

class _EditTaskState extends State<EditTask> {
  Task task;
  _EditTaskState(this.task);

  bool _checkboxvalue = false;
  final _formKey = GlobalKey<FormState>();
  String _title;
  String _description;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (task != null) {
      _checkboxvalue = task.completed;
    }
  }

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
                      task == null
                          ? SizedBox()
                          : TextFormField(
                              initialValue: task.title,
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
                              onSaved: (String value) {
                                setState(() {
                                  _title = value;
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Provide task title';
                                }
                                return null;
                              },
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      task == null
                          ? SizedBox()
                          : TextFormField(
                              initialValue: task.description,
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
                              onSaved: (String value) {
                                setState(() {
                                  _description = value;
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Provide task description';
                                }
                                return null;
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
                        checkColor: Colors.white,
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
                              final Map<String, dynamic> newtask = {
                                "title": _title,
                                "description": _description,
                                "completed": _checkboxvalue,
                                "created_date": DateTime.now().toString()
                              };
                              WebService.updateTask(newtask, task.id.toString())
                                  .then((updatedtask) {
                                if (updatedtask != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              updatedtask.title.toString())));
                                  Navigator.pop(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: MyHomePage()));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Task update was failed.')));
                                }
                              });
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
