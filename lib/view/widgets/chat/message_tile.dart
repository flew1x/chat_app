import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../themes/text styles/chat_screen_text_style.dart';
import '../../themes/theme.dart';
import 'package:intl/src/intl/date_format.dart' show DateFormat;

class MessageTile extends ConsumerStatefulWidget {
  const MessageTile(
      {super.key,
      this.sender,
      this.text,
      this.timestamp,
      this.isMe,
      required this.avatar});
  final String? sender;
  final String? text;
  final Timestamp? timestamp;
  final bool? isMe;
  final String avatar;

  @override
  ConsumerState<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends ConsumerState<MessageTile> {
  String giveUsername(String email) {
    return email.replaceAll(RegExp(r'@g(oogle)?mail\.com?$'), '');
  }

  @override
  Widget build(BuildContext context) {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(widget.timestamp!.seconds * 1000);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Align(
        alignment: widget.isMe! ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              widget.isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              giveUsername(
                widget.sender!,
              ),
              style: const TextStyle(color: Color.fromARGB(167, 145, 145, 145)),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: widget.isMe!
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: widget.isMe!
                          ? AppColors.secondary
                          : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Text(
                      widget.text!,
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.avatar),
                    radius: 25,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 8, right: 4),
              child: Text(
                DateFormat('h:mm').format(dateTime),
                style: timeOfMessageTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
