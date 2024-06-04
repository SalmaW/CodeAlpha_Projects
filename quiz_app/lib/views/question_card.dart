import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/question_controller.dart';
import '../models/questions_model.dart';
import '../utils/constants.dart';
import '../views/option.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    QuestionController questionController = Get.put(QuestionController());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: sDefaultPadding),
      padding: const EdgeInsets.all(sDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question.questions,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: sBlackColor),
          ),
          const SizedBox(height: sDefaultPadding / 2),
          ...List.generate(
            question.options.length,
            (index) => Options(
              text: question.options[index],
              index: index,
              press: () => questionController.checkAnswer(question, index),
            ),
          ),
        ],
      ),
    );
  }
}
