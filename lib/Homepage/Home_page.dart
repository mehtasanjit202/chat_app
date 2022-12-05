import 'package:chatapp/Homepage/addtodo.dart';
import 'package:chatapp/auth/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _editingController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout)),
        ],
        backgroundColor: Colors.lightBlue,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("todos")
            .where("created_by", isEqualTo: user?.uid)
            .snapshots(),
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
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((context) => AddToDo(
                                    documentId: data[index].id,
                                    title: data[index]['name'],
                                  )),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.lightBlue,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        title: const Text("confirm delete?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection("todos")
                                                  .doc((data)[index].id)
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                            child: const Text("yes"),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("cancel")),
                                        ],
                                      )));

                              // FirebaseFirestore.instance.collection("todos").doc((data)[index].id).delete();
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
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
            context,
            CupertinoPageRoute(
              builder: (context) => const AddToDo(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
