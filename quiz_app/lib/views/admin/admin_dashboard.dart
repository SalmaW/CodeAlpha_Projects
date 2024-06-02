import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/question_controller.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final QuestionController questionController = Get.put(QuestionController());
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
                  leading: const Icon(Icons.add),
                  title: Text(
                    controller.savedCategories[index],
                    style: TextStyle(color: Colors.white),
                  ),
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
      titlePadding: EdgeInsets.only(top: 15),
      contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      title: "Add Quiz",
      content: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: "Enter the category name"),
          ),
          TextFormField(
            decoration:
                InputDecoration(hintText: "Enter the category subtitle"),
          ),
        ],
      ),
      textConfirm: "Create",
      onConfirm: () {
        questionController.savedQuestionCategoryToSharedPreferences();
        Get.back();
      },
      textCancel: "Cancel",
      onCancel: () {
        print("Question set has been cancelled");
      },
    );
  }
}
