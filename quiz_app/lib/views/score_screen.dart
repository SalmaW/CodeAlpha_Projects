import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../config/app_images.dart';
import '../controllers/question_controller.dart';
import '../utils/constants.dart';
import '../views/quiz_category.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  QuestionController questionController = Get.put(QuestionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            AppImages.bg,
            fit: BoxFit.fitWidth,
          ),
          Column(
            children: [
              const Spacer(flex: 3),
              Text(
                "${questionController.userName}'s Score",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: sSecondaryColor),
              ),
              Text(
                '${questionController.numOfCorrectAns * 10.0} / ${questionController.questions.length * 10.0}',
                style: (questionController.numOfCorrectAns * 10.0) <
                        (questionController.questions.length * 10.0) / 2
                    ? Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: sRedColor,
                          fontWeight: FontWeight.w700,
                        )
                    : Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: sSecondaryColor,
                          fontWeight: FontWeight.w700,
                        ),
              ),
              const Spacer(flex: 2),
              Text(
                'You Answered: ${questionController.numOfCorrectAns} / ${questionController.filteredQuestion.length}',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: sSecondaryColor),
              ),
              TextButton(
                  onPressed: () {
                    questionController.resetNumOfCorrectAns();
                    Get.offAll(() => QuizCategoryScreen());
                  },
                  child: const Text(
                    "Go Home",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: sSecondaryColor,
                    ),
                  )),
              const Spacer(flex: 3),
            ],
          ),
        ],
      ),
    );
  }
}
