// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qstar/constant.dart';

class CategorySelector extends StatelessWidget {
  final TabController tabController;

  const CategorySelector({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      height: 80,
      child: TabBar(
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: const Color(0xff1967d2),
        unselectedLabelColor: const Color(0xff5f6368),
        isScrollable: true,
        indicator: const MD2Indicator(
          indicatorSize: MD2IndicatorSize.full,
          indicatorHeight: 6.0,
          indicatorColor: mPrimaryColor,
        ),
        tabs: [
          Tab(
              icon: Padding(
            padding: const EdgeInsets.all(5.0),
            child: RichText(
              // ignore: prefer_const_constructors
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 15,
                  color: mPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
                children: const [
                  TextSpan(text: 'Friends'),
                  WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0),
                      child: Icon(
                        FontAwesome.users,
                        size: 15,
                        color: mPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
          Tab(
              icon: Padding(
            padding: const EdgeInsets.all(5.0),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  color: mPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(text: 'Online'),
                  WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0),
                      child: Icon(
                        FontAwesome.circle,
                        size: 15,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
          Tab(
              icon: Padding(
            padding: const EdgeInsets.all(5.0),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  color: mPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(text: 'Nearby'),
                  WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0),
                      child: Icon(
                        FontAwesome.map_marker,
                        size: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
          Tab(
              icon: Padding(
            padding: const EdgeInsets.all(5.0),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  color: mPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(text: 'Match'),
                  WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0),
                      child: Icon(
                        FontAwesome.heart,
                        size: 18,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}

enum MD2IndicatorSize {
  tiny,
  normal,
  full,
}

class MD2Indicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final MD2IndicatorSize indicatorSize;

  const MD2Indicator(
      {required this.indicatorHeight,
      required this.indicatorColor,
      required this.indicatorSize});

  @override
  _MD2Painter createBoxPainter([VoidCallback? onChanged]) {
    return _MD2Painter(this, onChanged!);
  }
}

class _MD2Painter extends BoxPainter {
  final MD2Indicator decoration;

  _MD2Painter(this.decoration, VoidCallback onChanged)
      // ignore: unnecessary_null_comparison
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // ignore: unnecessary_null_comparison
    assert(configuration != null);
    assert(configuration.size != null);

    Rect? rect;
    if (decoration.indicatorSize == MD2IndicatorSize.full) {
      rect = Offset(offset.dx,
              (configuration.size!.height - decoration.indicatorHeight)) &
          Size(configuration.size!.width, decoration.indicatorHeight);
    } else if (decoration.indicatorSize !=
        MD2IndicatorSize
            // ignore: curly_braces_in_flow_control_structures
            .normal) if (decoration.indicatorSize == MD2IndicatorSize.tiny) {
      rect = Offset(offset.dx + configuration.size!.width / 2 - 8,
              (configuration.size!.height - decoration.indicatorHeight)) &
          Size(16, decoration.indicatorHeight);
    } else {
      rect = Offset(offset.dx + 6,
              (configuration.size!.height - decoration.indicatorHeight)) &
          Size(configuration.size!.width - 12, decoration.indicatorHeight);
    }

    final Paint paint = Paint();
    paint.color = decoration.indicatorColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndCorners(rect!,
            topRight: const Radius.circular(8),
            topLeft: const Radius.circular(8)),
        paint);
  }
}
