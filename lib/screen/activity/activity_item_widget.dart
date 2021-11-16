import 'package:flutter/material.dart';

class ActivityItemWidget extends StatelessWidget {
  const ActivityItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
            child: Row(
              children: <Widget>[
                const CircleAvatar(
                    maxRadius: 19,
                    backgroundImage: AssetImage('assets/images/1.jpg')),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'ronsbikes, dangngocduc',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                          TextSpan(
                              text: ' liked your photo.',
                              style: Theme.of(context).textTheme.subtitle1),
                          TextSpan(
                              text: ' 2h',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.56),
                                      fontSize: 16))
                        ])))),
              ],
            ),
          ),
          onTap: () {},
        ));
  }
}
