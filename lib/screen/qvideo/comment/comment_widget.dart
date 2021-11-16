import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/2.jpg'),
            radius: 18,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'dangngocduc ',
                        style: Theme.of(context).textTheme.bodyText2),
                    TextSpan(
                        text: 'This one looks amazing',
                        style: Theme.of(context).textTheme.bodyText1),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: DefaultTextStyle(
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      child: Row(
                        children: const [
                          Text('5d'),
                          SizedBox(
                            width: 24,
                          ),
                          Text('3 likes'),
                          SizedBox(
                            width: 24,
                          ),
                          Text('Reply')
                        ],
                      )),
                )
              ],
            ),
          )),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.favorite,
              size: 16,
            ),
          )
        ],
      ),
    );
  }
}
