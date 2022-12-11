import 'package:flutter/material.dart';
import 'task.dart';

void main() {
  runApp(const toDoApp());
}

class toDoApp extends StatelessWidget {
  const toDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme= ThemeData();
    return MaterialApp(
      title: 'ToDo List',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.black87,
          secondary: Colors.blue,
        ),
      ),
      home: const MyHomePage(title: 'Add tasks'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
List<Task> tasks=[];
final TextEditingController titleController = TextEditingController();
final TextEditingController detailsController = TextEditingController();
final TextEditingController dateController = TextEditingController();
final TextEditingController timeController = TextEditingController();
class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
        style: const TextStyle(
          fontFamily: 'Courgette',
        ),),
      ),
      body: ListView(children: getItems(),),
      floatingActionButton: FloatingActionButton(
        onPressed: () => displayDialog(context),
        tooltip:'Add Item',
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void addItem(Task task){
    setState(() {
      tasks.add(task);
    });
    titleController.clear();
    detailsController.clear();
    dateController.clear();
    timeController.clear();
  }
  Widget buildItem(Task task,int index){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => description(index)),
        ).then((value) => setState(() {}));
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(20,20,20,0),
        child: Column(children: <Widget>[
          ListTile(
            leading: Checkbox(
              checkColor: Colors.white,
              onChanged: (bool? value){
                setState(() {
                  tasks[index].isFinish= value!;
                });
              },
              value: tasks[index].isFinish,
            ),
            title: Text(task.title,
            style: const TextStyle(
              fontFamily: 'Courgette',
            )),
            subtitle: Text(task.date+" "+task.time,
            style: const TextStyle(
              fontFamily: 'Courgette',
            )),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){
                setState(() {
                  tasks.removeAt(index);
                });
              },
            ),
          )
        ],

        ),
      ),
    );
  }
  Future<Future> displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
        title: const Text('Add a task to your list'),
        content: Column(children: [
          TextField(
            controller: titleController,
          decoration: const InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: detailsController,
            decoration: const InputDecoration(hintText: 'Details'),
          ),
          TextField(
            controller: dateController,
            decoration: const InputDecoration(hintText: 'Date'),
          ),
          TextField(
            controller: timeController,
            decoration: const InputDecoration(hintText: 'Time'),
          ),
        ]),
        actions: <Widget>[
    // add button
        TextButton(
          child: const Text('Add'),
          onPressed: () {
            Navigator.of(context).pop();
            addItem(Task(titleController.text,detailsController.text, dateController.text,timeController.text,false));
          },
        ),
    // Cancel button
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {Navigator.of(context).pop();},
        )
      ],
      );
    });
  }
  List<Widget> getItems() {
    final List<Widget> todo= <Widget>[];
    for (int i = 0; i < tasks.length; i++) {
      todo.add(buildItem(tasks[i],i));
    }
    return todo;
  }
}


class description extends StatefulWidget {
  final int index;
  const description(this.index);

  @override
  State<description> createState() => _descriptionState();
}

class _descriptionState extends State<description> {
  void editItem(
      Task task, int index) {
    setState(() {
      tasks[index]= task;
    });
    titleController.clear();
    detailsController.clear();
    dateController.clear();
    timeController.clear();
  }

  Future<Future> _displayDialog(BuildContext context) async {
    // alter the app state to show a dialog
    titleController.text = tasks[widget.index].title;
    detailsController.text = tasks[widget.index].details;
    dateController.text = tasks[widget.index].date;
    timeController.text = tasks[widget.index].time;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            title: const Text('Edit task'),
            content: Column(children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'title'),
              ),
              TextField(
                controller: detailsController,
                decoration: const InputDecoration(hintText: 'details'),
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(hintText: 'date'),
              ),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(hintText: 'time'),
              ),
            ]),
            actions: <Widget>[
              // add button
              TextButton(
                child: const Text('Edit'),
                onPressed: () {
                  Navigator.of(context).pop();
                  editItem(
                      Task(titleController.text,
                          detailsController.text,
                          dateController.text,
                          timeController.text,
                          false),
                      widget.index);
                },
              ),
              // Cancel button
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(backgroundColor: Colors.grey);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.orange),
      backgroundColor: Colors.blue,
      body: Container(
        height:
        (MediaQuery.of(context).size.height - appBar.preferredSize.height),
        width: MediaQuery.of(context).size.width / 1.05,
        margin: EdgeInsets.all(15),
        child: Container(
            child: Card(
                elevation: 5,
                child: Padding(
                    padding: EdgeInsets.all(25),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(tasks[widget.index].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30,
                                  fontFamily: 'Courgette',
                                )),
                            Text("Due: ${tasks[widget.index].date} ${tasks[widget.index].time}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    fontFamily: 'Courgette',
                                    color: Colors.grey)),
                          ],
                        ),
                        const Divider(
                          thickness: 0.7,
                          color: Colors.black,
                        ),
                        Text(tasks[widget.index].details,
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 24,
                              fontFamily: 'Courgette'
                            )),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7),
                      ],
                    )))),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Edit Item',
          child: Icon(Icons.edit),
          backgroundColor: Colors.pink),
    );
  }
}
