import 'package:flutter/material.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/screen/profile/userprofiledetail.dart';

class ActivityItemWidget extends StatelessWidget {
  final GetActivity? data;
  const ActivityItemWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 19,
                  backgroundImage: NetworkImage(
                      "https://qstar.mindethiopia.com/api/getProfilePicture/${data!.user_account_id}"),
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: data!.profile_name,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    TextSpan(
                        text: " " + data!.body,
                        style: Theme.of(context).textTheme.subtitle1),
                    TextSpan(
                        text: ' 2h',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.56),
                            fontSize: 16))
                  ])),
                )),
                // CircleAvatar(
                //   maxRadius: 19,
                //   backgroundImage: NetworkImage(
                //       "https://qstar.mindethiopia.com/api/getPostPicture/${data!.post_id}"),
                // ),
              ],
            ),
          ),
          onTap: () {},
        ));
  }
}
