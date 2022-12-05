import 'package:chatapp/apps_function.dart';
import 'package:chatapp/auth/login_screen.dart';
import 'package:chatapp/chat/chat_detail_screen.dart';
import 'package:chatapp/main.dart';
import 'package:chatapp/profile/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({
    super.key,
  });

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const profileScreen(),
              ),
            );
          },
          child: ClipOval(
            child: Image.network(
              "https://scontent.fktm17-1.fna.fbcdn.net/v/t39.30808-6/278918763_3294441794169747_6457355518929236859_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=OnnnHcrqiEIAX9evLV9&_nc_ht=scontent.fktm17-1.fna&oh=00_AfCls7MAOyKwIzXY3wwEwxlnRrMOC9iul3h-1KhN-Cny-Q&oe=638F55FB",
              width: 10,
              height: 10,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: const Text("chats"),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(AppSetting.navigatorKey.currentContext!)
                    .pushAndRemoveUntil(
                        CupertinoPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where(
              "uid",
              isNotEqualTo: user?.uid,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data?.docs ?? [];
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      String loggedinUserUid = user!.uid;
                      String otherUserUid = users[index]['uid'];
                      String chatRoomId =
                          createChatRoom(loggedinUserUid, otherUserUid);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChatDetailScreen(
                            name: users[index]['name'],
                            chatRoomId: chatRoomId,
                          ),
                        ),
                      );
                    },
                    title: Text(
                      users[index]['name'],
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  // body: ListView.builder(
  //   itemCount: 15,
  //   itemBuilder: ((context, index) {
  //     return ListTile(
  //       onTap: () {
  //         Navigator.of(context).push(CupertinoPageRoute(
  //             builder: ((context) => const ChatDetailScreen())));
  //       },
  //       title: const Text("Hey sanjit"),
  //       leading: ClipOval(
  //           child: Image.network("https://picsum.photos/id/237/536/354",
  //               height: 50, width: 50, fit: BoxFit.cover)),
  //       subtitle: const Text("Hello guys"),
  //       trailing: const Icon(Icons.more_vert),
  //     );
  //   }),
  // ),

}
