import 'package:flutter/material.dart';
import 'package:my_goals/models/task.dart';
import 'package:my_goals/pages/create_task.dart';
import 'package:my_goals/pages/edit_task.dart';
import 'package:my_goals/services/webservice.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO',
      theme: ThemeData(primarySwatch: Colors.purple, fontFamily: 'Neo'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    WebService.getTasks().then((tasks) {
      setState(() {
        _tasks = tasks;
      });
    });
  }

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
      child: RefreshIndicator(
        onRefresh: () => WebService.getTasks().then((tasks) {
          setState(() {
            _tasks = tasks;
          });
        }),
        child: FutureBuilder(
            future: WebService.getTasks(),
            builder: (context, snapshot) {
              return snapshot != null && snapshot.hasData
                  ? ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
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
                                        child: Text(_tasks[index].title,
                                            style: TextStyle(
                                                fontFamily: 'Neo',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                fontSize: 20)),
                                      ),
                                      subtitle: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                  _tasks[index].description,
                                                  style: TextStyle(
                                                      fontFamily: 'Neo',
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w200)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                DateFormat("HH:mm a").format(
                                                    DateTime.parse(_tasks[index]
                                                        .created_date)),
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
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: EditTask(
                                                task: _tasks[index],
                                              ))).then((value) {
                                        setState(() {
                                          WebService.getTasks().then((tasks) {
                                            setState(() {
                                              _tasks = tasks;
                                            });
                                          });
                                        });
                                      });
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
                                    final snackBar1 = SnackBar(
                                      content: Text(
                                          'Do you want to delete this item?'),
                                      action: SnackBarAction(
                                        label: 'Delete',
                                        onPressed: () {
                                          WebService.deleteTask(
                                                  _tasks[index].id.toString())
                                              .then((result) {
                                            final snackBar =
                                                SnackBar(content: Text(result));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);

                                            WebService.getTasks().then((tasks) {
                                              setState(() {
                                                _tasks = tasks;
                                              });
                                            });
                                          });
                                        },
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar1);
                                  },
                                ),
                              ),
                            ),
                            _tasks[index].completed == null
                                ? SizedBox()
                                : _tasks[index].completed
                                    ? Positioned(
                                        top: 0,
                                        right: 30,
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
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
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    );
            }),
      ),
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
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: CreateTask()));
            }));
  }
}
