import 'package:flutter/material.dart';
import 'location_selector_widget.dart';
import 'post_create_view_model.dart';

import 'package:qstar/constant.dart';
import 'write_caption_widget.dart';
import 'package:provider/provider.dart';
import 'package:qstar/screen/post/tag.dart';
import 'package:qstar/screen/post/location.dart';
import 'package:qstar/screen/post/setting.dart';

class SettingPostPage extends StatefulWidget {
  static const ROUTE_NAME = 'SettingPostPage';
  @override
  _SettingPostPageState createState() => _SettingPostPageState();
}

class _SettingPostPageState extends State<SettingPostPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ModalRoute.of(context)!.overlayEntries.forEach((element) {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostCreateViewModel(),
      lazy: false,
      child: Builder(
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: mPrimaryColor,
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }),
              title: Text(
                "New Post",
                style: TextStyle(
                  color: mPrimaryColor,
                  fontSize: 27,
                  fontFamily: 'font1',
                ),
              ),
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.check),
                  iconSize: 30.0,
                  color: mPrimaryColor,
                  onPressed: () {},
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  WriteCaptionWidget(),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text('Tag People'),
                    dense: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              Search(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                  ),
                  Divider(
                    height: 1,
                  ),
                  if (context.watch<PostCreateViewModel>().currentLocation ==
                      null)
                    ListTile(
                      title: Text('Add Location'),
                      dense: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                Searchlocation(),
                            transitionDuration: Duration.zero,
                          ),
                        );
                      },
                    ),
                  if (context.watch<PostCreateViewModel>().currentLocation !=
                      null)
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).toggleableActiveColor,
                          BlendMode.srcATop),
                      child: ListTile(
                        title: Text(
                            '${context.watch<PostCreateViewModel>().currentLocation}'),
                        leading: Icon(Icons.pin_drop),
                        trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              context
                                  .read<PostCreateViewModel>()
                                  .setCurrentLocation(null);
                            }),
                        dense: true,
                      ),
                    ),
                  Divider(
                    height: 1,
                  ),
                  if (context.watch<PostCreateViewModel>().currentLocation ==
                      null)
                    LocationSelectorWidget(),
                  if (context.watch<PostCreateViewModel>().currentLocation ==
                      null)
                    Divider(
                      height: 1,
                    ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text('Setting'),
                    dense: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              SettingsScreen(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
