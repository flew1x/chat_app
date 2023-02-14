import 'dart:developer';

import 'package:chat_app/view/widgets/chat/message_tile.dart';
import 'package:chat_app/view/widgets/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../widgets/action_button.dart';

final _firestore = FirebaseFirestore.instance;
User? _loggedInuser;

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final _controller = TextEditingController();
  final _auth = FirebaseAuth.instance;

  late String _messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool isKeyboardVisible) {
      if (mounted) {
        setState(() {
          // Your state change code goes here
        });
      }
    });
  }

  Future<bool> onBackPress() {
    return Future.value(false);
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        _loggedInuser = user;
        log(_loggedInuser.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: onBackPress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const MessagesStream(),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                            hintText: 'Сообщение...', border: InputBorder.none),
                        textInputAction: TextInputAction.send,
                        keyboardType: TextInputType.multiline,
                        onSubmitted: (value) {
                          _controller.clear();
                          _firestore.collection('messages').add({
                            'sender': _loggedInuser!.email,
                            'text': _messageText,
                            'timestamp': Timestamp.now(),
                          });
                        },
                        maxLines: null,
                        controller: _controller,
                        onChanged: (value) {
                          _messageText = value;
                        },
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: GlowingActionButton(
                              color: Colors.transparent,
                              icon: Icons.send_sharp,
                              onPressed: () {
                                _controller.clear();
                                _firestore.collection('messages').add({
                                  'sender': _loggedInuser!.email,
                                  'text': _messageText,
                                  'timestamp': Timestamp.now(),
                                });
                              },
                            ))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          // Sort the messages by timestamp DESC because we want the newest messages on bottom.
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        // If we do not have data yet, show a progress indicator.
        if (!snapshot.hasData) {
          return const Loader();
        }
        // Create the list of message widgets.

        // final messages = snapshot.data.documents.reversed;

        List<Widget> messageWidgets = snapshot.data!.docs.map<Widget>((m) {
          final data = m.data as dynamic;
          final messageText = data()['text'];
          final messageSender = data()['sender'];
          final currentUser = _loggedInuser!.email;
          final timeStamp = data()['timestamp'];
          return MessageTile(
            sender: messageSender,
            text: messageText,
            timestamp: timeStamp,
            isMe: currentUser == messageSender,
          );
        }).toList();

        return Expanded(
          child: ListView(
            reverse: true,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}
