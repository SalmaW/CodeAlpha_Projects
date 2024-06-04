import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../views/score_screen.dart';
import '../models/questions_model.dart';

class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  String userName = "Player";
  late AnimationController _animationController;
  late Animation<double> _animation;
  Animation<double> get animation => _animation;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  int _correctAnswer = 0;
  int get correctAnswer => _correctAnswer;

  int _selectedAnswer = 0;
  int get selectedAnswer => _selectedAnswer;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  late PageController _pageController;
  PageController get pageController => _pageController;

  List<Question> _questions = [];
  List<Question> get questions => _questions;

  List<Question> _filteredQuestion = [];
  List<Question> get filteredQuestion => _filteredQuestion;

  final TextEditingController questionControllerText = TextEditingController();
  final List<TextEditingController> optionControllers =
      List.generate(4, (index) => TextEditingController());
  final TextEditingController correctAnswerController = TextEditingController();
  final TextEditingController quizCategory = TextEditingController();

  //Adding question to category
  Future<void> savedQuestionToSharedPreferences(Question question) async {
    final prefs = await SharedPreferences.getInstance();
    final questions = prefs.getStringList("questions") ?? [];

    //convert the questions list to save it into SharedPreferences
    questions.add(jsonEncode(question.toJson()));
    await prefs.setStringList("questions", questions);
  }

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

  void loadQuestionsFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final questionJson = prefs.getStringList("questions") ?? [];

    _questions = questionJson
        .map((json) => Question.fromJson(jsonDecode(json)))
        .toList();

    update();
  }

  List<Question> getQuestionsByCategory(String category) =>
      _questions.where((question) => question.category == category).toList();

  void checkAnswer(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAnswer = question.answer;
    _selectedAnswer = selectedIndex;
    if (_correctAnswer == _selectedAnswer) _numOfCorrectAns++;
    _animationController.stop();
    update();

    Future.delayed(const Duration(seconds: 3), () => nextQuestion());
  }

  void nextQuestion() async {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
        duration: const Duration(microseconds: 250),
        curve: Curves.ease,
      );
      _animationController.reset();
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      Get.to(() => const ScoreScreen());
    }
  }

  void updateQuestionNumber(int index) {
    _questionNumber.value = index + 1;
    update();
  }

  void setFilteredQuestions(String category) {
    _filteredQuestion = getQuestionsByCategory(category);
    _questionNumber.value = 1;
    update();
    nextQuestion();
  }

  void resetNumOfCorrectAns() {
    _numOfCorrectAns = 0;
    update();
  }

  void resetAnimation() {
    _animationController.reset();
    _animationController.forward().whenComplete(nextQuestion);
  }

  @override
  void onInit() {
    super.onInit();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() => update());
    loadQuestionCategoryFromSharedPreferences();
    loadQuestionsFromSharedPreferences();
    _pageController = PageController();
    update();
  }
}
