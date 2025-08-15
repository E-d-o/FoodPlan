import 'package:flutter/material.dart';
import 'package:foodplan/notifiers/main_list_manager.dart';
import 'package:foodplan/notifiers/single_list_manager.dart';
import 'package:foodplan/pages/single_list_page.dart';
import 'package:provider/provider.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
    required this.borderRadius,
    required this.height,
    required this.manager,
    required this.id,
  });
  final double borderRadius;
  final double height;
  final String id;
  final SingleListManager manager;
  final double percentageBlurToNonBlur = 0.1;

  @override
  Widget build(BuildContext context) {
    MainListManager mainManager = context.watch<MainListManager>();

    double progress = mainManager.getListProgress(id);
    return LayoutBuilder(
      builder: (context, constraints) {
        final double parentWidth = constraints.maxWidth;
        double progressBarTotalWidth = progress * parentWidth;
        double progressBarBlurWidth =
            progressBarTotalWidth * percentageBlurToNonBlur;
        double progressBarWidth =
            progressBarTotalWidth * (1 - percentageBlurToNonBlur);

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
              width: progressBarWidth,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  bottomLeft: Radius.circular(borderRadius),
                ),
              ),
            ),
            blurProgress(progressBarWidth, progressBarBlurWidth),
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

  Positioned blurProgress(
    double progressBarWidth,
    double progressBarBlurWidth,
  ) {
    return Positioned(
      left: progressBarWidth - 1,
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
          width: progressBarBlurWidth,
          height: height,
          color: Colors.white,
        ),
      ),
    );
  }

  double calculateProgressBarWidth(
    double parentWidth,
    double progress,
    double blurWidthMultiplier,
  ) {
    double idealWidth = parentWidth * (progress - blurWidthMultiplier);
    if (idealWidth <= 0) {
      return 0.0;
    } else {
      return idealWidth;
    }
  }
}
