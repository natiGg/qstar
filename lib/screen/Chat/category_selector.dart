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
        labelColor: Color(0xff1967d2),
        unselectedLabelColor: Color(0xff5f6368),
        isScrollable: true,
        indicator: MD2Indicator(
          indicatorSize: MD2IndicatorSize.full,
          indicatorHeight: 6.0,
          indicatorColor: mPrimaryColor,
        ),
        tabs: [
          Tab(
              icon: Padding(
            padding: const EdgeInsets.all(5.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  color: mPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(text: 'Friends'),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
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
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  color: mPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(text: 'Online'),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
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
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  color: mPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(text: 'Nearby'),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
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
    return new _MD2Painter(this, onChanged!);
  }
}

class _MD2Painter extends BoxPainter {
  final MD2Indicator decoration;

  _MD2Painter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    Rect? rect;
    if (decoration.indicatorSize == MD2IndicatorSize.full) {
      rect = Offset(offset.dx,
              (configuration.size!.height - decoration.indicatorHeight)) &
          Size(configuration.size!.width, decoration.indicatorHeight);
    } else if (decoration.indicatorSize == MD2IndicatorSize.normal) {
      rect = Offset(offset.dx + 6,
              (configuration.size!.height - decoration.indicatorHeight)) &
          Size(configuration.size!.width - 12, decoration.indicatorHeight);
    } else if (decoration.indicatorSize == MD2IndicatorSize.tiny) {
      rect = Offset(offset.dx + configuration.size!.width / 2 - 8,
              (configuration.size!.height - decoration.indicatorHeight)) &
          Size(16, decoration.indicatorHeight);
    }

    final Paint paint = Paint();
    paint.color = decoration.indicatorColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndCorners(rect!,
            topRight: Radius.circular(8), topLeft: Radius.circular(8)),
        paint);
  }
}
