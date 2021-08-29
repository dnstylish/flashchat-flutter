import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection('messages');
  final messagesTextController = TextEditingController();

  late final User loggedInUser;
  late String textMessage;

  Future<void> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if(user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void getMessages() async {
    final messages = await _firestore.get();
    for (final message in messages.docs) {
      print(message.data());
    }
  }


  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          TextButton(
              onPressed: () {},
              child: CloseButton(
                color: Colors.white,
                onPressed: () { },
              )
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessagesStream(
                firestore: _firestore,
                loggedInUser: loggedInUser,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        onChanged: (value) {
                          textMessage = value;
                        },
                        controller: messagesTextController,
                        decoration: InputDecoration(
                          hintText: 'Type messages here...'
                        ),
                      ),
                  ),
                  TextButton(
                      onPressed: () {
                        messagesTextController.clear();
                        _firestore.add(
                              {
                                'text': textMessage,
                                'sender': loggedInUser.email,
                                'createdAt': new DateTime.now().microsecondsSinceEpoch
                              }
                            );
                      },
                      child: Text('Send'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key, required CollectionReference<Map<String, dynamic>> firestore, required this.loggedInUser}) : _firestore = firestore, super(key: key);

  final CollectionReference<Map<String, dynamic>> _firestore;
  final User loggedInUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.orderBy('createdAt').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData) {
          List<MessageBubble> messageWidgets = [];
          snapshot.data!.docs.forEach((element) {
            messageWidgets.add(
              MessageBubble(
                message: element.get('text'),
                sender: element.get('sender'),
                isMe: element.get('sender') == loggedInUser.email,
              )
            );
          });
          return Expanded(
            child: ListView(
              children: messageWidgets,
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({ Key? key, required this.message, required this.sender, required this.isMe }) : super(key: key);

  final String message;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender, style: TextStyle(
            fontSize: 12
          )),
          SizedBox(
            height: 8,
          ),
          Material(
            borderRadius: isMe ? BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)
            ) : BorderRadius.only(
                bottomLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)
            ),
            color: isMe ? Colors.lightBlueAccent : Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                  message,
                  style: TextStyle(
                      fontSize: 15
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
