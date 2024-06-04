import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../views/progress_bar.dart';
import '../views/question_card.dart';
import '../config/app_images.dart';
import '../controllers/question_controller.dart';
import '../utils/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController questionController = Get.find();
    PageController pageController = questionController.pageController;

    return Stack(
      fit: StackFit.expand,
      children: [
        SvgPicture.asset(
          AppImages.bg,
          fit: BoxFit.fitWidth,
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const ProgressBar(),
              Obx(
                () => Text.rich(
                  TextSpan(
                      text:
                          "Question ${questionController.questionNumber.value}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: sSecondaryColor),
                      children: [
                        TextSpan(
                          text:
                              "/${questionController.filteredQuestion.length}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: sSecondaryColor),
                        ),
                      ]),
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: questionController.updateQuestionNumber,
                  itemCount: questionController.filteredQuestion.length,
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return QuestionCard(
                        question: questionController.filteredQuestion[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
