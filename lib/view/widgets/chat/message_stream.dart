import 'package:chat_app/helpers/firebase_helper.dart';
import 'package:chat_app/view/widgets/chat/message_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesStream extends ConsumerStatefulWidget {
  MessagesStream({super.key});

  final _firestore = FirebaseFirestore.instance;

  @override
  ConsumerState<MessagesStream> createState() => _MessagesStreamState();
}

class _MessagesStreamState extends ConsumerState<MessagesStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget._firestore
          .collection('messages')
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        List<Widget> messageWidgets = snapshot.data!.docs.map<Widget>((m) {
          final data = m.data as dynamic;
          final messageText = data()['text'];
          final messageSender = data()['sender'];
          final currentUser = ref.watch(firebaseHelperProvider).getUserEmail();
          final timeStamp = data()['timestamp'];
          final avatar = data()['avatar'];
          return MessageTile(
              sender: messageSender,
              text: messageText,
              timestamp: timeStamp,
              isMe: currentUser == messageSender,
              avatar: avatar);
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
