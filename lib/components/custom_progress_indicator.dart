import 'package:flutter/material.dart';
import 'package:foodplan/managers/main_list_manager.dart';

import 'package:provider/provider.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
    required this.borderRadius,
    required this.height,

    required this.id,
  });
  final double borderRadius;
  final double height;
  final String id;

  final double percentageBlurToNonBlur = 0.1;

  @override
  Widget build(BuildContext context) {
    MainListManager mainManager = context.watch<MainListManager>();

    double progress = mainManager.getListProgress(id);
    progress = 0.6; //for testing purpuses
    final Color backgroundColor = Theme.of(
      context,
    ).colorScheme.secondaryContainer;
    final Color primaryColor = Theme.of(context).colorScheme.primary;
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
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),

            Container(
              height: height,
              width: progressBarWidth,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  bottomLeft: Radius.circular(borderRadius),
                ),
              ),
            ),
            blurProgress(
              progressBarWidth,
              progressBarBlurWidth,
              context,
              primaryColor,
              backgroundColor,
            ),
            Material(
              color: Colors.transparent,
              child: InkResponse(
                splashColor: Theme.of(context).splashColor,
                highlightShape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(borderRadius),
                containedInkWell: true,
                onTap: () {},
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
    dynamic context,
    Color primaryColor,
    Color backgroundColor,
  ) {
    return Positioned(
      left: progressBarWidth - 1,
      child: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [
              primaryColor.withValues(alpha: 1),
              primaryColor.withValues(alpha: 0.7),
              Colors.transparent,
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
          color: backgroundColor,
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
