import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/question_controller.dart';
import '../utils/constants.dart';

class Options extends StatelessWidget {
  final String text;
  final int index;
  final VoidCallback press;
  const Options(
      {super.key,
      required this.text,
      required this.index,
      required this.press});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (controller) {
          Color getRightColor() {
            if (controller.isAnswered) {
              if (index == controller.correctAnswer) {
                return sGreenColor;
              } else if ((index == controller.selectedAnswer) &&
                  (controller.selectedAnswer != controller.correctAnswer)) {
                return sRedColor;
              }
            }
            return sGrayColor;
          }

          IconData getRightIcon() {
            return getRightColor() == sRedColor
                ? Icons.close_rounded
                : Icons.done_rounded;
          }

          return GestureDetector(
            onTap: press,
            child: Container(
              margin: const EdgeInsets.only(top: sDefaultPadding),
              padding: const EdgeInsets.all(sDefaultPadding),
              decoration: BoxDecoration(
                border: Border.all(color: getRightColor()),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${index + 1}-   $text",
                    style: TextStyle(
                      color: getRightColor(),
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: getRightColor() == sGrayColor
                          ? Colors.transparent
                          : getRightColor(),
                      border: Border.all(color: getRightColor()),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: getRightColor() == sGrayColor
                        ? null
                        : Icon(
                            getRightIcon(),
                            size: 16,
                          ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
