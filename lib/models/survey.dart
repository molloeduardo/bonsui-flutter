import 'package:flutter/cupertino.dart';

class BonsuiSurveyQuestion {
  final String question;
  final List<BonsuiSurveyAnswer> answers;
  final bool required;
  final bool multipleChoices;
  final int? maxChoices;

  BonsuiSurveyQuestion(
      {required this.question,
      required this.answers,
      this.required = false,
      this.multipleChoices = false,
      this.maxChoices});
}

class BonsuiSurveyAnswer {
  final int id;
  final IconData? icon;
  final String text;
  final bool? selected;

  BonsuiSurveyAnswer(
      {this.icon, required this.text, required this.id, this.selected});
}
