import 'package:chatapp/Homepage/addtodo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
        backgroundColor: Colors.lightBlue,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("todos").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List data = snapshot.data?.docs ?? [];
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: ((context, index) {
                return ListTile(
                    title: Text(
                  data[index]["name"],
                  
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () {
                      
                      showDialog(context: context, builder: (context) => AlertDialog(
                        title: TextFormField(
                validator: (value) {
                  if (value != null && value.length > 0) {
                    return null;
                  } else {
                    return "Please enter atleast one task";
                  }
                },
                controller: _editingController,
              ),
              actions: [ElevatedButton(onPressed: () {
                FirebaseFirestore.instance.collection("todos").doc((data)[index].id).update({"name": _editingController.text});
                Navigator.pop(context);
              }, child: Text("update"))],
                      ),
                      );
                      

                      
                    },
                    icon: Icon(Icons.edit,color: Colors.lightBlue,),
                    ),
                    IconButton(onPressed: () {
                      FirebaseFirestore.instance.collection("todos").doc((data)[index].id).delete();
                      

                      
                    },
                    icon: Icon(Icons.delete,color: Colors.lightBlue,),
                    ),
                  ],
                ),
                );

                
              }),
            );
            
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => addtodo()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
