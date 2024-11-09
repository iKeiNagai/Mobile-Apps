import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager',
        home: LoginPage(),
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
  final TextEditingController _subtaskcontroller = TextEditingController();
  
  final CollectionReference _maintasks = FirebaseFirestore.instance.collection('Main Tasks');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _logout(BuildContext context) async{
    await _auth.signOut();
    Navigator.pop(context);
  }

  Future<void> addTask (String mainTask) async {
    if(mainTask.isEmpty) return;

    try {
      await _maintasks.add({
        'mainTask' : mainTask,
        'isCompleted' : false,
        'subtask' : []
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

  Future<void> addsubtask(String taskid, String subtask) async{
    DocumentSnapshot maintaskdoc = await _maintasks.doc(taskid).get();
    List<dynamic> subtasks = maintaskdoc.get('subtask') ?? [];

    subtasks.add({
      'subtask' : subtask,
      'isCompleted' : false
    });
    
    try{
      await _maintasks.doc(taskid).update({
        'subtask': subtasks
      });
    } catch(e){
      Text('error adding subtask: $e');
    }
  }

  Future<void> completionSubtask(String taskid, int subtaskindex, bool currentStatus) async {
    DocumentSnapshot maintaskdoc = await _maintasks.doc(taskid).get();
    List<dynamic> subtasks = maintaskdoc.get('subtask') ?? [];

    subtasks[subtaskindex]['isCompleted'] = !currentStatus;

    await _maintasks.doc(taskid).update({
      'subtask' : subtasks
    });
  }

  Future<void> deleteSubtask(String taskid, int subtaskindex) async {
    DocumentSnapshot maintaskdoc = await _maintasks.doc(taskid).get();
    List<dynamic> subtasks = maintaskdoc.get('subtask') ?? [];

    subtasks.removeAt(subtaskindex);

    await _maintasks.doc(taskid).update({
      'subtask' : subtasks
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _logout(context), 
            icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: <Widget> [
              TextField(
                controller: _taskcontroller,
                decoration: const InputDecoration(labelText: 'Task Name'),
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
                          final List subtasks = documentSnapshot['subtask'] ?? [];
                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: ExpansionTile(
                              leading: Checkbox(
                                value: isCompleted, 
                                onChanged: (bool? newValue){
                                  toggleCompletion(documentSnapshot.id, isCompleted);
                                }),
                              title: Text(documentSnapshot['mainTask']),       
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed:() => 
                                      isCompleted 
                                      ? deleteTask(documentSnapshot.id)
                                      : null ,
                                    icon: const Icon(Icons.delete)),
                                  IconButton(
                                    onPressed: (){
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return AlertDialog(
                                            title: const Text('Add subtask'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller: _subtaskcontroller,
                                                  decoration: const InputDecoration(labelText: 'Subtask Name'),
                                                ),
                                                OutlinedButton(
                                                  onPressed:(){
                                                    addsubtask(documentSnapshot.id, _subtaskcontroller.text);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Enter'))
                                              ],
                                            ),
                                          );
                                        });
                                    }, 
                                    icon: const Icon(Icons.add))
                                ],
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: subtasks.length,
                                    itemBuilder: (context, index){
                                      var subtask = subtasks[index];
                                      final bool isCompletedsub = subtask['isCompleted'];
                                      return ListTile(
                                        leading: Checkbox(
                                          value: isCompletedsub, 
                                          onChanged: (bool? newValue){
                                            completionSubtask(documentSnapshot.id, index, isCompletedsub);
                                          }),
                                        title: Text(subtask['subtask']),
                                        trailing: IconButton(
                                          onPressed: () => 
                                          isCompletedsub
                                          ? deleteSubtask(documentSnapshot.id, index)
                                          : null,
                                          icon: const Icon(Icons.delete)),        
                                      );
                                    }),
                                )
                              ],
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