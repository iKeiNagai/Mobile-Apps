import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager',
        home: TaskList(),
    );
  }
}

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final TextEditingController _taskcontroller = TextEditingController();
  
  final CollectionReference _maintasks = FirebaseFirestore.instance.collection('Main Tasks');


  Future<void> addTask (String mainTask) async {
    if(mainTask.isEmpty) return;

    try {
      await _maintasks.add({
        'mainTask' : mainTask,
        'isCompleted' : false
      });
      const Text('Succesful');
    } catch (e) {
      Text('error adding task: $e' );
    }
  }

  Future<void> deleteTask(String taskid) async {
    try{
      await _maintasks.doc(taskid).delete();
    } catch(e){
      Text('Error deleting: $e');
    }
  }

  Future<void> toggleCompletion(String taskid, bool currentStatus) async {
    try{
      await _maintasks.doc(taskid).update({
        'isCompleted': !currentStatus,
      });
    } catch(e){
      Text('error toggling; $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: <Widget> [
              TextField(
                controller: _taskcontroller,
                decoration: InputDecoration(labelText: 'Task Name'),
              ),
              OutlinedButton(
                onPressed:() => addTask(_taskcontroller.text), 
                child: const Text('add')
              ),
              const SizedBox(height: 50),
              Expanded(
                child: StreamBuilder(
                  stream: _maintasks.snapshots(), 
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                    if(streamSnapshot.hasData){
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index){
                          final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                          final bool isCompleted = documentSnapshot['isCompleted'];
                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              leading: Checkbox(
                                value: isCompleted, 
                                onChanged: (bool? newValue){
                                  toggleCompletion(documentSnapshot.id, isCompleted);
                                }),
                              title: Text(documentSnapshot['isCompleted'].toString()),       
                              trailing: IconButton(
                                onPressed:() => 
                                  isCompleted 
                                  ? deleteTask(documentSnapshot.id)
                                  : null ,
                                icon: const Icon(Icons.delete)),
                              ),
                            );
                        });
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }))
            ],
          )),
      ),
    );
  }
}