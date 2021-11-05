import 'package:flutter/material.dart';
import 'post_create_view_model.dart';

import 'package:provider/provider.dart';

class LocationSelectorWidget extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = 'LocationSelectorWidget';

  const LocationSelectorWidget({Key? key}) : super(key: key);
  @override
  _LocationSelectorWidgetState createState() => _LocationSelectorWidgetState();
}

class _LocationSelectorWidgetState extends State<LocationSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              child: Container(
                child: Text(
                  context.watch<PostCreateViewModel>().locationSuggest[index],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: ShapeDecoration(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    color: Theme.of(context).hintColor.withOpacity(0.12)),
              ),
              onTap: () {
                context.read<PostCreateViewModel>().setCurrentLocation(
                    context.read<PostCreateViewModel>().locationSuggest[index]);
              },
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 16,
                height: 0,
              ),
          itemCount:
              context.watch<PostCreateViewModel>().locationSuggest.length),
    );
  }
}
