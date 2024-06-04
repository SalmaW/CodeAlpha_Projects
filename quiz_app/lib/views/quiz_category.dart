import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../views/quiz_screen.dart';
import '../config/app_images.dart';
import '../controllers/question_controller.dart';

class QuizCategoryScreen extends StatelessWidget {
  QuizCategoryScreen({super.key});
  final QuestionController _questionController = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          _questionController.userName.isEmpty
              ? "Hi! Choose Category"
              : "Hi ${_questionController.userName}! Choose Category",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            AppImages.bg,
            fit: BoxFit.fitWidth,
          ),
          Obx(
            () => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: _questionController.savedCategories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _questionController.resetAnimation();
                    Get.to(() => QuizScreen(
                        category: _questionController.savedCategories[index]));
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Icon(
                            Icons.question_answer_outlined,
                            size: 30,
                          ),
                        ),
                        Text(
                          _questionController.savedCategories[index],
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          _questionController.savedSubTitles[index],
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
