import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class addtodo extends StatefulWidget {
  const addtodo({super.key});

  @override
  State<addtodo> createState() => _addtodoState();
}

final TextEditingController _fieldcontroler = TextEditingController();
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

class _addtodoState extends State<addtodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Addtodo"),
      ),
      body: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value != null && value.length > 0) {
                    return null;
                  } else {
                    return "Please enter atleast one task";
                  }
                },
                controller: _fieldcontroler,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      await FirebaseFirestore.instance
                          .collection("todos")
                          .add({"name": _fieldcontroler.text});
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add"))
            ],
          )),
    );
  }
}
