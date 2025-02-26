import 'package:flutter/widgets.dart';

Widget layoutBuilderWithAlwaytScoll(
    {required Widget child, bool scrool = false}) {
  return scrool
      ? LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: constraints.maxHeight,
              child: child,
            ),
          );
        })
      : child;
}
