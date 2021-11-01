import 'package:flutter/material.dart';
import 'message_model.dart';
import 'chat_screen.dart';
import 'package:qstar/constant.dart';

class Match extends StatelessWidget {
  const Match({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: ListView.builder(
            physics: const ScrollPhysics(),
            itemCount: chats3.length,
            itemBuilder: (BuildContext context, int index) {
              final Message chat = chats3[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        ChatScreen(
                      user: chat.sender,
                    ),
                    transitionDuration: Duration.zero,
                  ),
                ),
                child: Container(
                  margin:
                      const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          //   Stack(children: [
                          //      CircleAvatar(
                          //     radius: 35.0,
                          //     backgroundImage: AssetImage(chat.sender.imageUrl),
                          //     backgroundColor: mPrimaryColor,
                          //   ),
                          //   Positioned(
                          // bottom: -10,
                          // right: -35,
                          // child: Container(
                          //   child: RawMaterialButton(
                          //     onPressed: () {},

                          //     fillColor: Colors.white,
                          //     padding: EdgeInsets.all(1.0),
                          //     child: Icon(Icons.circle, color: Colors.green,size: 15,),

                          //     shape: CircleBorder(),
                          //   ),
                          // )),
                          //   ],),
                          Stack(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
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
                                        image:
                                            AssetImage(chat.sender.imageUrl))),
                              ),
                              Positioned(
                                  bottom: 10,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              offset: const Offset(0, 10))
                                        ],
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.circle,
                                      color: chat.unread
                                          ? Colors.green
                                          : Colors.grey,
                                      size: 10,
                                    ),
                                  )),
                            ],
                          ),

                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                chat.sender.name,
                                style: const TextStyle(
                                  color: mPrimaryColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                chat.activeTime,
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.5),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Text(
                                  chat.text,
                                  style: const TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          chat.unread
                              ? Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: const BoxDecoration(
                                      color: mPrimaryColor,
                                      shape: BoxShape.circle),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    '3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : const Text(''),
                          const SizedBox(height: 5.0),
                          Text(
                            "100 m",
                            style: TextStyle(
                              color: Colors.grey.withOpacity(0.8),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            chat.time,
                            style: TextStyle(
                              color: Colors.grey.withOpacity(0.5),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
