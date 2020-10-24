import 'dart:async';

import 'package:Xchangez/scaffold/CustomScaffold.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  final ChatUser user = ChatUser(
    name: "Fayeed",
    firstName: "Fayeed",
    lastName: "Pawaskar",
    uid: "12345678",
    avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
  );

  final ChatUser otherUser = ChatUser(
    name: "Mrfatty",
    uid: "25649654",
  );

  List<ChatMessage> messages = List<ChatMessage>();
  var m = List<ChatMessage>();

  var i = 0;

  @override
  void initState() {
    super.initState();
  }

  void systemMessage() {
    Timer(Duration(milliseconds: 300), () {
      if (i < 6) {
        setState(() {
          messages = [...messages, m[i]];
        });
        i++;
      }
      Timer(Duration(milliseconds: 300), () {
        _chatViewKey.currentState.scrollController
          ..animateTo(
            _chatViewKey.currentState.scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
      });
    });
  }

  void onSend(ChatMessage message) async {
    print(message.toJson());
  }

  @override
  Widget build(BuildContext context) {
    //var messages = List();

    return CustomScaffold(DashChat(
      key: _chatViewKey,
      inverted: false,
      onSend: onSend,
      sendOnEnter: true,
      textInputAction: TextInputAction.send,
      user: user,
      inputDecoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 8, bottom: 6),
        labelText: "Mensaje...",
      ),
      dateFormat: DateFormat('yyyy-MMM-dd'),
      timeFormat: DateFormat('HH:mm'),
      messages: messages,
      showUserAvatar: false,
      showAvatarForEveryMessage: false,
      scrollToBottom: true,
      onPressAvatar: (ChatUser user) {
        print("OnPressAvatar: ${user.name}");
      },
      onLongPressAvatar: (ChatUser user) {
        print("OnLongPressAvatar: ${user.name}");
      },
      inputMaxLines: 5,
      messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
      alwaysShowSend: true,
      inputTextStyle: TextStyle(fontSize: 16.0),
      inputContainerStyle: BoxDecoration(
        border: Border.all(width: 0.0),
        color: Colors.white,
      ),
      onQuickReply: (Reply reply) {
        setState(() {
          messages.add(ChatMessage(
              text: reply.value, createdAt: DateTime.now(), user: user));

          messages = [...messages];
        });

        Timer(Duration(milliseconds: 300), () {
          _chatViewKey.currentState.scrollController
            ..animateTo(
              _chatViewKey
                  .currentState.scrollController.position.maxScrollExtent,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            );

          if (i == 0) {
            systemMessage();
            Timer(Duration(milliseconds: 600), () {
              systemMessage();
            });
          } else {
            systemMessage();
          }
        });
      },
      onLoadEarlier: () {
        print("laoding...");
      },
      shouldShowLoadEarlier: false,
      showTraillingBeforeSend: true,
      trailing: [
        IconButton(
          icon: Icon(Icons.photo),
          onPressed: () async {},
        )
      ],
      leading: [
        IconButton(
          icon: Icon(Icons.emoji_emotions),
          onPressed: () {},
        ),
      ],
    ));
  }
}
/*return CustomScaffold(Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("CACA"),
              subtitle: Text("Popo"),
            );
          },
        )),
        Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(color: Colors.white),
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              IconButton(
                icon: Icon(Icons.emoji_emotions),
                onPressed: () {},
              ),
              Expanded(
                  child: TextField(
                maxLines:
                    null, // Este null es requerido para la funcionalidad de expanción en overflow
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 8, bottom: 6),
                  labelText: "Mensaje...",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {},
                  ),
                ),
              )),
            ]))
      ],
    ));*/
