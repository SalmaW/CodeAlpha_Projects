import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/question_controller.dart';
import '../config/app_images.dart';
import '../views/admin/admin_dashboard.dart';
import '../views/quiz_category.dart';
import '../utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final QuestionController name = Get.put(QuestionController());

  WelcomeScreen({super.key});

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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: sDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 2),
                  Text(
                    "Let's Test you Knowledge",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Text("Enter your information below"),
                  const Spacer(), // it will take 1/6 of the screen
                  TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: userNameController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1C2341),
                      hintText: 'Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      final userName = userNameController.text;
                      name.userName = userName;
                      if (userName == "Admin" || userName == "admin") {
                        Get.to(() => const AdminDashboard());
                      } else {
                        Get.to(() => QuizCategoryScreen());
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(sDefaultPadding * 0.75),
                      decoration: const BoxDecoration(
                        gradient: sPrimaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        "Let's Start Quiz",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
