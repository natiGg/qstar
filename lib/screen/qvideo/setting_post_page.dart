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
  // ignore: constant_identifier_names
  static const ROUTE_NAME = 'SettingPostPage';

  const SettingPostPage({Key? key}) : super(key: key);
  @override
  _SettingPostPageState createState() => _SettingPostPageState();
}

class _SettingPostPageState extends State<SettingPostPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ignore: unused_local_variable
    for (var element in ModalRoute.of(context)!.overlayEntries) {}
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
                  icon: const Icon(Icons.arrow_back),
                  color: mPrimaryColor,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  }),
              title: const Text(
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
                  icon: const Icon(Icons.check),
                  iconSize: 30.0,
                  color: mPrimaryColor,
                  onPressed: () {},
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const WriteCaptionWidget(),
                  const Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: const Text('Tag People'),
                    dense: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const Search(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                  ),
                  const Divider(
                    height: 1,
                  ),
                  if (context.watch<PostCreateViewModel>().currentLocation ==
                      null)
                    ListTile(
                      title: const Text('Add Location'),
                      dense: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                const Searchlocation(),
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
                        leading: const Icon(Icons.pin_drop),
                        trailing: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              context
                                  .read<PostCreateViewModel>()
                                  .setCurrentLocation(null);
                            }),
                        dense: true,
                      ),
                    ),
                  const Divider(
                    height: 1,
                  ),
                  if (context.watch<PostCreateViewModel>().currentLocation ==
                      null)
                    const LocationSelectorWidget(),
                  if (context.watch<PostCreateViewModel>().currentLocation ==
                      null)
                    const Divider(
                      height: 1,
                    ),
                  const Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: const Text('Setting'),
                    dense: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const SettingsScreen(),
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
