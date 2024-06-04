import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/question_controller.dart';
import '/views/admin/admin_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final QuestionController questionController = Get.put(QuestionController());

  @override
  void initState() {
    questionController.loadQuestionCategoryFromSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
      ),
      body: GetBuilder<QuestionController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.savedCategories.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    Get.to(() => AdminScreen(
                        quizCategory: controller.savedCategories[index]));
                  },
                  leading: const Icon(Icons.add),
                  title: Text(controller.savedCategories[index]),
                  subtitle: Text(controller.savedSubTitles[index]),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDialog() {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 15),
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      title: "Add Quiz",
      content: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: questionController.categoryTitleController,
            decoration:
                const InputDecoration(hintText: "Enter the category name"),
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            controller: questionController.categorySubTitleController,
            decoration:
                const InputDecoration(hintText: "Enter the category subtitle"),
          ),
        ],
      ),
      textConfirm: "Create",
      onConfirm: () {
        questionController.savedQuestionCategoryToSharedPreferences();
        Get.back();
        setState(() {});
      },
      textCancel: "Cancel",
      onCancel: () {
        if (kDebugMode) {
          print("Question set has been cancelled");
        }
      },
    );
  }
}
