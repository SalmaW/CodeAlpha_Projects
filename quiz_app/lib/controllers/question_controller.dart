import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/questions_model.dart';

class QuestionController extends GetxController {
  final List<Question> _questions = [];
  List<Question> get questions => _questions;

  //Admin Dashboard
  final String _categoryKey = "category_title";
  final String _subTitleKey = "subtitle";
  TextEditingController categoryTitleController = TextEditingController();
  TextEditingController categorySubTitleController = TextEditingController();

  RxList<String> savedCategories = <String>[].obs;
  RxList<String> savedSubTitles = <String>[].obs;

  void savedQuestionCategoryToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    savedCategories.add(categoryTitleController.text);
    savedSubTitles.add(categorySubTitleController.text);

    await prefs.setStringList(_categoryKey, savedCategories);
    await prefs.setStringList(_subTitleKey, savedSubTitles);

    categoryTitleController.clear();
    categorySubTitleController.clear();

    Get.snackbar("Saved", "Category created successfully");
  }

  void loadQuestionCategoryFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final categories = prefs.getStringList(_categoryKey) ?? [];
    final subtitles = prefs.getStringList(_subTitleKey) ?? [];

    savedCategories.assignAll(categories);
    savedSubTitles.assignAll(subtitles);
    update();
  }
}
