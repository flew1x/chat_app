import 'package:chat_app/model/message_data.dart';
import 'package:chat_app/services/helpers.dart';
import 'package:chat_app/themes/theme.dart';
import 'package:chat_app/view/screens/screens.dart';
import 'package:chat_app/view/widgets/avatar.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(_delegate),
        )
      ],
    );
  }

  Widget _delegate(BuildContext context, int index) {
    final Faker faker = Faker();
    final date = Helpers.randomDate();
    return _MessageTitle(
        messageData: MessageData(
            senderName: faker.person.name(),
            message: faker.lorem.sentence(),
            messageDate: date,
            dateMessage: Jiffy(date).fromNow(),
            profilePicture: Helpers.randomPictureUrl()));
  }
}

class _MessageTitle extends StatelessWidget {
  const _MessageTitle({required this.messageData});

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ChatScreen(messageData: messageData),
            transition: Transition.zoom);
      },
      child: Container(
        height: 95,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Avatar.medium(
                url: messageData.profilePicture,
              ),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(messageData.senderName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              letterSpacing: 0.2,
                              wordSpacing: 1.5,
                              fontWeight: FontWeight.w900)),
                    ),
                    SizedBox(
                      height: 20,
                      child: Text(
                        messageData.message,
                        style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.textFaded,
                            overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    messageData.dateMessage.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 11,
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textFaded),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                        color: AppColors.secondary, shape: BoxShape.circle),
                    child: const Center(
                      child: Text(
                        '1',
                        style:
                            TextStyle(fontSize: 10, color: AppColors.textLigth),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
