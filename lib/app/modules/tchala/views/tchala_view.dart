import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/app_string.dart';
import 'package:haiti_lotri/app/data/models/tchala_model.dart';
import 'package:haiti_lotri/app/global_widgets/app_bar.dart';

import '../../../global_widgets/infinite_list.dart';
import '../controllers/tchala_controller.dart';

class TchalaView extends GetView<TchalaController> {
  const TchalaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgetTitle(
        title: AppStrings.TCHALA,
      ),
      body: InfiniteList<TchalaModel>(
        onPage: controller.onPage,
        onSearch: controller.onSearch,
        itemBuilder: (p0, item) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: 50),
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text(item.label)),
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          runAlignment: WrapAlignment.end,
                          alignment: WrapAlignment.end,
                          spacing: 5,
                          runSpacing: 5,
                          children: [
                            ...item.bouls.map(
                              (el) {
                                return gradiantCircular(
                                  child: Text(el),
                                  colors: [
                                    Colors.white,
                                    getRandomColor(int.parse(el)),
                                  ],
                                  dimension: 40,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color getRandomColor(int number) {
    // Ensure the number is between 0 and 99
    assert(number >= 0 && number <= 99);

    // Seed the random generator with the number
    Random random = Random(number);

    // Generate RGB components with a limit to prevent luminance
    int red = random.nextInt(156) + 50; // Range: 50-205
    int green = random.nextInt(156) + 50; // Range: 50-205
    int blue = random.nextInt(156) + 50; // Range: 50-205

    return Color.fromARGB(255, red, green, blue); // ARGB with full opacity
  }

  Widget gradiantCircular({
    required Widget child,
    required List<Color> colors,
    List<double>? stops,
    required double dimension,
  }) {
    return Container(
      width: dimension, // Width of the circular widget
      height: dimension, // Height of the circular widget
      decoration: BoxDecoration(
        shape: BoxShape.circle, // Make the widget circular
        gradient: RadialGradient(
          colors: colors,
          stops: stops, // Control the spread of colors
          center: Alignment.center, // Center the gradient
        ),
      ),
      child: Center(child: child),
    );
  }
}
