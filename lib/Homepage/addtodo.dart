import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddToDo extends StatefulWidget {
  final String? documentId;
  final String? title;

  const AddToDo({super.key, this.documentId, this.title});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _editingController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.title != null) {
      _editingController.text = widget.title!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.documentId == null ? "Add" : "Update"),
      ),
      body: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value != null && value.length > 1) {
                    return null;
                  } else {
                    return "Please enter atleast one task";
                  }
                },
                controller: _editingController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      // final
                      if (widget.documentId == null) {
                        await FirebaseFirestore.instance
                            .collection("todos")
                            .add({
                          "name": _editingController.text,
                          "created_by": user!.uid,
                        });
                      } else {
                        await FirebaseFirestore.instance
                            .collection("todos")
                            .doc(widget.documentId)
                            .update({"name": _editingController.text});
                      }

                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(widget.documentId != null ? "add" : "Add"))
            ],
          )),
    );
  }
}
