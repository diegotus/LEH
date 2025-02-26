import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGaugeProgressBar2 extends GetWidget {
  final double progress; // Progress from 0.0 to 1.0
  final int creditScore;
  final double height;
  final double width;
  final double scoreTextSize;
  final double scoreStatusTextSize;
  final bool inContainer;
  const RadialGaugeProgressBar2({
    super.key,
    this.scoreStatusTextSize = 12,
    this.scoreTextSize = 16,
    required this.progress,
    int? creditScore = 0,
    this.height = 150,
    this.width = 150,
    this.inContainer = true,
  }) : creditScore = creditScore ?? 0;

  @override
  Widget build(BuildContext context) {
    var textData = Text(
      categorizeCreditScore(creditScore),
      style: TextStyle(
        fontSize: scoreStatusTextSize, // Adjusted font size
        color: Colors.green[600],
      ),
    );
    var containerData = inContainer
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                ),
              ],
            ),
            child: textData,
          )
        : textData;
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              startAngle: 135,
              endAngle: 45,
              radiusFactor: 0.8, // Adjusted to fit within the new size
              minimum: 0,
              maximum: 850,
              showLabels: false,
              ranges: <GaugeRange>[
                GaugeRange(
                  startValue: 0,
                  endValue: 600,
                  color: Colors.red,
                ),
                GaugeRange(
                  startValue: 600,
                  endValue: 650,
                  color: Colors.orange,
                ),
                GaugeRange(
                  startValue: 650,
                  endValue: 700,
                  color: Colors.yellow,
                ),
                GaugeRange(
                  startValue: 700,
                  endValue: 750,
                  color: Colors.lightGreen,
                ),
                GaugeRange(
                  startValue: 750,
                  endValue: 850,
                  color: Colors.green,
                ),
              ],
              pointers: const <GaugePointer>[],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  widget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        creditScore.toString(),
                        style: TextStyle(
                          fontSize: scoreTextSize, // Adjusted font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      containerData,
                    ],
                  ),
                  angle: 90,
                  positionFactor: 0.1,
                ),
                // Calculate the exact position for the white circle
                GaugeAnnotation(
                  angle: 135 +
                      (progress * 270), // Calculate angle based on progress
                  positionFactor:
                      1, // Ensure it's on the outer edge of the gauge
                  widget: Container(
                    width: 15, // Adjusted size
                    height: 15, // Adjusted size
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String categorizeCreditScore(int creditScore) {
    if (creditScore >= 750) {
      return "Excellent";
    } else if (creditScore >= 700) {
      return "Good";
    } else if (creditScore >= 650) {
      return "Fair";
    } else if (creditScore >= 600) {
      return "Poor";
    } else {
      return "Very Poor";
    }
  }
}

class CreditScoreProgressBar extends StatelessWidget {
  final int creditScore;
  final int startRange;
  final int endRange;
  final double containerWidth;
  const CreditScoreProgressBar({
    super.key,
    required this.creditScore,
    this.startRange = 300,
    this.endRange = 850,
    required this.containerWidth,
  });

  @override
  Widget build(BuildContext context) {
    double scorePosition =
        ((creditScore < startRange ? startRange : creditScore) - startRange) /
            (endRange - startRange);
    // double containerWidth = MediaQuery.of(context).size.width - 32; // Subtracting padding

    return Container(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              SizedBox(
                width: double.infinity,
                height: 25, // Increased height of the Stack
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: const [
                            Colors.red,
                            Colors.orange,
                            Colors.yellow,
                            Colors.green
                          ],
                          stops: [
                            (300 - startRange) /
                                (endRange - startRange), // Red to Orange
                            (650 - startRange) /
                                (endRange - startRange), // Orange to Yellow
                            (700 - startRange) /
                                (endRange - startRange), // Yellow to Green
                            (750 - startRange) /
                                (endRange - startRange) // Gradient End
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Positioned(
                      left: scorePosition * containerWidth,
                      // Adjust top position to make the circle more visible
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.solid,
                              color: Colors.green.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Increased height for more separation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$startRange',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                '$endRange',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
