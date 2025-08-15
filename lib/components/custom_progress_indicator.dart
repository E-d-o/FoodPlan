import 'package:flutter/material.dart';
import 'package:foodplan/notifiers/single_list_manager.dart';
import 'package:foodplan/pages/single_list_page.dart';
import 'package:provider/provider.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
    required this.borderRadius,
    required this.height,
    required this.manager,
  });
  final double borderRadius;
  final double height;
  final double progress = 0.6;
  final double blurWidth = 50;
  final SingleListManager manager;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double parentWidth = constraints.maxWidth;
        return Stack(
          children: [
            Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),

            Container(
              height: height,
              width: parentWidth * progress - blurWidth,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  bottomLeft: Radius.circular(borderRadius),
                ),
              ),
            ),
            Positioned(
              left: parentWidth * progress - blurWidth - 1,
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [
                      Colors.blue.withValues(alpha: 1),
                      Colors.blue.withValues(alpha: 0.7),
                      Colors.white,
                    ],
                    stops: [0.0, 0.5, 1],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcATop,
                child: Container(
                  width: blurWidth,
                  height: height,
                  color: Colors.white,
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkResponse(
                splashColor: Colors.redAccent,
                highlightShape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(borderRadius),
                containedInkWell: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ChangeNotifierProvider.value(
                          value: manager,
                          child: SingleListPage(),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
