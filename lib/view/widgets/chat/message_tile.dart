import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../themes/text styles/chat_screen_text_style.dart';
import '../../themes/theme.dart';
import 'package:intl/src/intl/date_format.dart';

class MessageTile extends StatelessWidget {
  const MessageTile(
      {super.key, this.sender, this.text, this.timestamp, this.isMe});
  final String? sender;
  final String? text;
  final Timestamp? timestamp;
  final bool? isMe;

  String giveUsername(String email) {
    return email.replaceAll(RegExp(r'@g(oogle)?mail\.com?$'), '');
  }

  @override
  Widget build(BuildContext context) {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp!.seconds * 1000);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Align(
        alignment: isMe! ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              giveUsername(
                sender!,
              ),
              style: const TextStyle(color: Color.fromARGB(167, 145, 145, 145)),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              decoration: BoxDecoration(
                  color:
                      isMe! ? AppColors.secondary : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Text(
                  text!,
                  style: const TextStyle(fontSize: 17),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 8),
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
