// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'message_model.dart';

import 'package:qstar/constant.dart';

class ChatScreen extends StatefulWidget {
  final User? user;

  const ChatScreen({required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

late TextEditingController message;
var messagetype = "text";

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    message = TextEditingController();

    super.initState();
  }

  _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: message,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type your message ...',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.attach_file,
                    color: Colors.grey[500],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: () async {
              print(message!.text);
              print(messagetype);
              print(widget.user!.id);

              await RemoteServices.sendmessage(
                  message!.text, messagetype, widget.user!.id);
            },
            child: const CircleAvatar(
              backgroundColor: mPrimaryColor,
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() {
    Navigator.of(context).pop(true);
    return Future.value(false);
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    //if(mounted)
    // setState(() {

    // });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,

      //cheak pull_to_refresh
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: false,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: mPrimaryColor,
              onPressed: () {
                Navigator.of(context).pop(true);
              }),
          title: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://qstar.mindethiopia.com/api/getProfilePicture/${widget.user!.id}"))),
                  ),
                  Positioned(
                      bottom: 10,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            color: Colors.white),
                        child: const Icon(
                          Icons.circle,
                          color: Colors.green,
                          size: 10,
                        ),
                      )),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user!.name,
                    style: chatSenderName,
                  ),
                  Text(
                    'online',
                    style: bodyText1.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.call,
                  size: 28,
                  color: mPrimaryColor,
                ),
                onPressed: () {}),
            IconButton(
                // ignore: prefer_const_constructors
                icon: Icon(
                  Icons.videocam_outlined,
                  size: 28,
                  color: mPrimaryColor,
                ),
                onPressed: () {}),
          ],
          elevation: 2,
        ),
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: _onBackPressed,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, int index) {
                      final message = messages[index];
                      bool isMe = message.sender.id == currentUser.id;
                      return Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: isMe
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (!isMe)
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundImage: NetworkImage(
                                            "https://qstar.mindethiopia.com/api/getProfilePicture/${widget.user!.id}"),
                                      ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6),
                                      decoration: BoxDecoration(
                                          color: isMe
                                              ? mPrimaryColor.withOpacity(0.80)
                                              : Colors.grey[200],
                                          borderRadius: BorderRadius.only(
                                            topLeft: const Radius.circular(16),
                                            topRight: const Radius.circular(16),
                                            bottomLeft:
                                                Radius.circular(isMe ? 12 : 0),
                                            bottomRight:
                                                Radius.circular(isMe ? 0 : 12),
                                          )),
                                      child: Text(
                                        messages[index].text,
                                        style: bodyTextMessage.copyWith(
                                            color: isMe
                                                ? Colors.white
                                                : Colors.grey[800]),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment: isMe
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      if (!isMe)
                                        const SizedBox(
                                          width: 40,
                                        ),
                                      Icon(
                                        Icons.done_all,
                                        size: 20,
                                        color: bodyTextTime.color,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        message.time,
                                        style: bodyTextTime,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              _buildMessageComposer()
            ],
          ),
        ),
      ),
    );
  }
}
