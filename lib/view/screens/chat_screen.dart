import 'package:chat_app/model/message_data.dart';
import 'package:chat_app/themes/theme.dart';
import 'package:chat_app/view/widgets/avatar.dart';
import 'package:chat_app/view/widgets/icon_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/text styles/chat_screen_text_style.dart';
import '../widgets/action_button.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.messageData});

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: const [Expanded(child: _DemoMessageList()), _BottomBar()],
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.black12,
      elevation: 0,
      title: _AppBarTitle(
        messageData: messageData,
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Center(
            child: IconBorder(
          icon: Icons.arrow_back_ios_new,
          onTap: () {
            Get.back();
          },
        )),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
              child: IconBorder(
            icon: CupertinoIcons.video_camera_solid,
            onTap: () {},
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Center(
              child: IconBorder(
            icon: CupertinoIcons.phone_solid,
            onTap: () {},
          )),
        )
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: true,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(
                          width: 2, color: Theme.of(context).dividerColor))),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  CupertinoIcons.camera_circle_fill,
                  size: 30,
                ),
              ),
            ),
            const Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 14),
              child: TextField(
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(hintText: 'Сообщение...'),
              ),
            )),
            Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: GlowingActionButton(
                  color: Colors.transparent,
                  icon: Icons.send_sharp,
                  onPressed: () {},
                ))
          ],
        ));
  }
}

class _MessageOwnTile extends StatelessWidget {
  const _MessageOwnTile({required this.message, required this.messageDate});

  final String message;
  final String messageDate;

  static const _borderRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(_borderRadius)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Text(
                  message,
                  style: messagesTextStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 4),
              child: Text(
                messageDate,
                style: timeOfMessageTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({required this.message, required this.messageDate});

  final String message;
  final String messageDate;

  static const _borderRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(_borderRadius)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 8),
              child: Text(
                messageDate,
                style: const TextStyle(
                    color: AppColors.textFaded,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DemoMessageList extends StatelessWidget {
  const _DemoMessageList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        _DateLable(lable: "Вчера"),
        _MessageTile(message: 'Привет братан!', messageDate: '10:1 PM'),
        _MessageOwnTile(message: 'Дарова!', messageDate: '12:02 AM')
      ],
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({Key? key, required this.messageData}) : super(key: key);

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar.small(
          url: messageData.profilePicture,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              messageData.senderName,
              overflow: TextOverflow.ellipsis,
              style: nameTextStyle,
            ),
            const SizedBox(
              height: 2,
            ),
            Text('Онлайн', style: statusOnlineTextStyle)
          ],
        ))
      ],
    );
  }
}

class _DateLable extends StatelessWidget {
  const _DateLable({required this.lable});

  final String lable;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          lable,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.textFaded),
        ),
      ),
    );
  }
}
