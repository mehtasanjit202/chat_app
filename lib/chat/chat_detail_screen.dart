import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatDetailScreen extends StatefulWidget {
  final name;
  final String chatRoomId;
  const ChatDetailScreen(
      {super.key, required this.chatRoomId, required this.name});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.video_call,
              color: Colors.black87,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ))
        ],
        // centerTitle: true,
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("chats")
                      .doc(widget.chatRoomId)
                      .collection("users")
                      .orderBy("created_at", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final chats = snapshot.data?.docs ?? [];

                      return ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          reverse: true,
                          itemCount: chats.length,
                          itemBuilder: (contex, index) {
                            {
                              bool isSentByMe =
                                  user?.uid == chats[index]["sent_by"];
                              return Row(
                                mainAxisAlignment: isSentByMe
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  // if (!isSentByMe)
                                  Visibility(
                                    visible: !isSentByMe,
                                    child: ClipOval(
                                      child: Image.network(
                                        "https://images4.fanpop.com/image/photos/23900000/Felicia-Day-Random-Portrait-felicia-day-23983017-1070-1599.jpg",
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(15),
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: isSentByMe
                                          ? Colors.blue
                                          : Colors.grey,
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(10),
                                        topRight: const Radius.circular(10),
                                        bottomLeft: isSentByMe
                                            ? const Radius.circular(10)
                                            : const Radius.circular(0),
                                        bottomRight: isSentByMe
                                            ? const Radius.circular(0)
                                            : const Radius.circular(10),
                                      ),
                                    ),
                                    child: Text(chats[index]['message']),
                                  ),
                                  // if (isSentByMe)
                                  Visibility(
                                    visible: isSentByMe,
                                    child: ClipOval(
                                      child: Image.network(
                                        "https://scontent.fktm17-1.fna.fbcdn.net/v/t39.30808-6/278918763_3294441794169747_6457355518929236859_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=OnnnHcrqiEIAX9evLV9&_nc_ht=scontent.fktm17-1.fna&oh=00_AfCls7MAOyKwIzXY3wwEwxlnRrMOC9iul3h-1KhN-Cny-Q&oe=638F55FB",
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          });
                    }
                    return const CircularProgressIndicator();
                  })),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                const Icon(
                  Icons.camera_alt_rounded,
                  size: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.photo,
                  size: 40,
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.mic,
                      size: 40,
                    )),
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final auth = FirebaseAuth.instance.currentUser;
                    if (_messageController.text.isNotEmpty) {
                      FirebaseFirestore.instance
                          .collection("chats")
                          .doc(widget.chatRoomId)
                          .collection("users")
                          .add({
                        "message": _messageController.text,
                        "created_at": DateTime.now().toString(),
                        "chat_room_id": widget.chatRoomId,
                        "sent_by": auth?.uid,
                      });
                      _messageController.clear();
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    size: 40,
                    color: Colors.blue,
                  ),
                ),

                //  )
              ],
            ),
          ),
          const SizedBox(
            height: 2,
          ),
        ],
      ),
    );
  }
}
