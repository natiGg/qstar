import 'package:flutter/material.dart';
import 'package:qstar/screen/Chat/home_screen.dart';
import 'message_model.dart';
import 'user_model.dart';
import 'package:qstar/constant.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  const ChatScreen({required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? mPrimaryColor : Color(0xFFFFEFEE),
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.time,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 12.0,
              fontWeight: FontWeight.w100,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            message.text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
        IconButton(
          icon: message.isLiked
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
          iconSize: 30.0,
          color: message.isLiked ? mPrimaryColor : Colors.blueGrey,
          onPressed: () {},
        )
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
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
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
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
          SizedBox(
            width: 16,
          ),
          CircleAvatar(
            backgroundColor: mPrimaryColor,
            child: Icon(
              Icons.send,
              color: Colors.white,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: false,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
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
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                widget.user.imageUrl
                              ))),
                    ),
                    Positioned(
                        bottom: 10,
                        right: 0,
                        child: Container(
                           decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                            
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          
                          shape: BoxShape.circle,
                          color: Colors.white
                          ),
                   
                          child: Icon(
                            Icons.circle,
                            color: Colors.green,
                            size: 10,
                          ),
                        )),
                  ],
                ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.name,
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
              icon: Icon(
                Icons.call,
                size: 28,
                color: mPrimaryColor,
              ),
              onPressed: () {}),
          IconButton(
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
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(15),
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
                                    backgroundImage:
                                        AssetImage(widget.user.imageUrl),
                                  ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.6),
                                  decoration: BoxDecoration(
                                      color: isMe
                                          ? mPrimaryColor.withOpacity(0.80)
                                          : Colors.grey[200],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
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
                                    SizedBox(
                                      width: 40,
                                    ),
                                  Icon(
                                    Icons.done_all,
                                    size: 20,
                                    color: bodyTextTime.color,
                                  ),
                                  SizedBox(
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
      
    );
  }
}
