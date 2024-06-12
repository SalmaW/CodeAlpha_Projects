# quiz_app (QuizME)
Quiz App is a Flutter application where users can add categories containing several questions and quiz themselves. At the end of the quiz, users receive a score. Additionally, there is an option to skip questions. To add a new category, users can enter "Admin" on the welcome screen instead of their name to open the admin dashboard, where they can add the category name and description. Users need to tap on the category to add new questions to a category.


# Features
- Category Management: Users can add categories with descriptions.
- Question Bank: Users can add questions to categories.
- Quiz Mode: Users can quiz themselves on the added categories.
- Skipping Questions: Users have the option to skip questions during a quiz.
- Score Tracking: Users receive a score at the end of each quiz.


# Packages Used
```yaml
#For navigation management.
get: ^4.6.6
#For displaying SVG images.
flutter_svg: ^2.0.9
#For storing simple data locally.
shared_preferences: ^2.2.3 
```


# Usage
1. Welcome Screen:
   - Users can either enter their name to start quizzing or enter "Admin or admin" to access the admin dashboard.

2. Admin Dashboard:
   - Users can add/delete new categories by providing a name and description.
   - Tap on a category to add new questions.

4. Category Screen:
   - Users see all categories and quiz themselves on what they need.

5. Quiz Screen:
   - Users can answer or skip quiestion/s, and see their score at the end.


# Contributing
Contributions are welcome! Please feel free to submit a pull request or open an issue for any bugs or feature requests.


# Acknowledgments
Special thanks to the Flutter community for their amazing support and resources.
