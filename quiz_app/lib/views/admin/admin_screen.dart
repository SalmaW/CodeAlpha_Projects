import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/question_controller.dart';
import '/models/questions_model.dart';

class AdminScreen extends StatelessWidget {
  final String quizCategory;
  AdminScreen({super.key, required this.quizCategory});
  final QuestionController questionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Question to $quizCategory"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: questionController.questionControllerText,
                decoration: const InputDecoration(hintText: "Question"),
              ),
              for (var i = 0; i < 4; i++)
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: questionController.optionControllers[i],
                  decoration: InputDecoration(hintText: "Option ${i + 1}"),
                ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                controller: questionController.correctAnswerController,
                decoration:
                    const InputDecoration(hintText: "Correct Answer is (0-3)"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    if (questionController
                        .questionControllerText.text.isEmpty) {
                      Get.snackbar('Required', "Question Field is Required");
                    } else if (questionController
                        .optionControllers[0].text.isEmpty) {
                      Get.snackbar('Required', "Option 1 is Required");
                    } else if (questionController
                        .optionControllers[1].text.isEmpty) {
                      Get.snackbar('Required', "Option 2 is Required");
                    } else if (questionController
                        .optionControllers[2].text.isEmpty) {
                      Get.snackbar('Required', "Option 3 is Required");
                    } else if (questionController
                        .optionControllers[3].text.isEmpty) {
                      Get.snackbar('Required', "Option 4 is Required");
                    } else if (questionController
                        .correctAnswerController.text.isEmpty) {
                      Get.snackbar(
                          'Required', "Correct Answer Field is Required");
                    } else {
                      addQuestion();
                    }
                  },
                  child: const Text("Add Question")),
            ],
          ),
        ),
      ),
    );
  }

  void addQuestion() async {
    final String questionText = questionController.questionControllerText.text;
    final List<String> options = questionController.optionControllers
        .map((controller) => controller.text)
        .toList();
    final int correctAnswer =
        int.tryParse(questionController.correctAnswerController.text) ?? 1;

    final Question newQuestion = Question(
      id: DateTime.now().microsecondsSinceEpoch, // Unique id
      questions: questionText,
      category: quizCategory,
      options: options,
      answer: correctAnswer,
    );

    //save the question to sharedPreferences
    await questionController.savedQuestionToSharedPreferences(newQuestion);
    Get.snackbar('Added', 'Question Added');
    questionController.questionControllerText.clear();
    for (var element in questionController.optionControllers) {
      element.clear();
    }
    questionController.correctAnswerController.clear();
  }
}
