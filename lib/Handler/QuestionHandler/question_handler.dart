import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Models/Question/question.dart';

class QuestionHandler{
  final TextEditingController title=TextEditingController();
  final TextEditingController mark=TextEditingController();
  ValueNotifier<Question> question=ValueNotifier(null);
  final ValueNotifier<List<Options>> options=ValueNotifier([]);
  bool isThereRightOption=false;
}