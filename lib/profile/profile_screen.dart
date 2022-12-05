import 'package:chatapp/profile/edit_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({super.key});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("profile"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: ClipOval(
              child: Image.network(
                "https://scontent.fktm17-1.fna.fbcdn.net/v/t39.30808-6/278918763_3294441794169747_6457355518929236859_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=OnnnHcrqiEIAX9evLV9&_nc_ht=scontent.fktm17-1.fna&oh=00_AfCls7MAOyKwIzXY3wwEwxlnRrMOC9iul3h-1KhN-Cny-Q&oe=638F55FB",
                height: 0.5 * Size.width,
                width: 0.5 * Size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Sanjit Mehta",
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 5,
          ),
          const Text("mehtasanjit202@gmail.com"),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
              },
              child: Row(mainAxisSize: MainAxisSize.min, children: const [
                Icon(Icons.edit),
                Text("Edit profile "),
              ])),
        ],
      ),
    );
  }
}
