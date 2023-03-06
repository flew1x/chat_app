import 'package:chat_app/cotrollers/firebase_controller.dart';
import 'package:chat_app/view/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/chat/message_stream.dart';
import '../widgets/chat/send_button.dart';

class MessagePage extends ConsumerStatefulWidget {
  const MessagePage({super.key});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends ConsumerState<MessagePage> {
  final _controller = TextEditingController();
  final FocusNode _myfocus = FocusNode();

  late String _messageText;

  @override
  Widget build(BuildContext context) {
    return ref.watch(userDataProvider).when(
        data: (user) => Scaffold(
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    MessagesStream(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: TextField(
                              autofocus: false,
                              focusNode: _myfocus,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                  hintText: 'Сообщение...',
                                  border: InputBorder.none),
                              textInputAction: TextInputAction.send,
                              keyboardType: TextInputType.multiline,
                              onSubmitted: (value) {
                                ref
                                    .watch(firebaseControllerProvider)
                                    .sendMessage(
                                        _messageText, user!, _controller);
                              },
                              maxLines: null,
                              controller: _controller,
                              onChanged: (value) {
                                _messageText = value;
                              },
                            ),
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12),
                                  child: SendButton(
                                    color: Colors.transparent,
                                    icon: Icons.send_sharp,
                                    onPressed: () {
                                      ref
                                          .watch(firebaseControllerProvider)
                                          .sendMessage(
                                              _messageText, user!, _controller);
                                    },
                                  ))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        error: (Object error, StackTrace stackTrace) {
          return const Loader();
        },
        loading: () {
          return const Loader();
        });
  }
}
