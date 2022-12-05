import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

bool _isObscure = true;
bool _issObscure = true;

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  final TextEditingController _textEmailController = TextEditingController();
  final TextEditingController _textPasswordController = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit profile"),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 3,
            ),
            Center(
              child: Container(
                  height: 0.3 * size.width,
                  width: 0.3 * size.width,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.3),
                      border: Border.all()),
                  child: ClipOval(
                    child: Image.network(
                      "https://lh3.googleusercontent.com/a/AEdFTp6kyF0Q7_enDjXH1F-eVkp3YGhLv3djYXYffTYa9-M=s396-p-rw-no",
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value != null && value.length > 3) {
                          return null;
                        } else {
                          return "Name cannot be empty";
                        }
                      },
                      decoration: const InputDecoration(hintText: "Name"),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return null;
                        } else {
                          return "Enter a valid email";
                        }
                      },
                      decoration: const InputDecoration(hintText: "Email"),
                    ),
                    TextFormField(
                      obscureText: _isObscure,
                      controller: _textPasswordController,
                      validator: (value) {
                        if (value != null && value.length > 7) {
                          return null;
                        } else {
                          return "Password must be atleast 8 characters";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscure
                                      ? _isObscure = false
                                      : _isObscure = true;
                                });
                              },
                              icon: const Icon(Icons.remove_red_eye))),
                    ),
                    TextFormField(
                      obscureText: _issObscure,
                      validator: (value) {
                        if (value == _textPasswordController.text) {
                          return null;
                        } else {
                          return "Password didnot match";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Confirm Password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _issObscure
                                      ? _issObscure = false
                                      : _issObscure = true;
                                });
                              },
                              icon: const Icon(Icons.remove_red_eye))),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text("Cancel")),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Save")),
              ],
            )
          ]),
        ));
  }
}
