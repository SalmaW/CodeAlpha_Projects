import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../config/app_images.dart';
import '../controllers/question_controller.dart';

class QuizCategoryScreen extends StatelessWidget {
  QuizCategoryScreen({Key? key}) : super(key: key);

  final QuestionController _questionController = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            AppImages.bg,
            fit: BoxFit.fitWidth,
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: _questionController.savedCategories.length,
            itemBuilder: (context, index) {
              return Card(
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.question_answer_outlined),
                      Text(_questionController.savedCategories[index]),
                      Text(_questionController.savedSubTitles[index]),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}