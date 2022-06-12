import 'package:flutter/material.dart';
import 'package:thegymapp/api/models/exercise.dart';

///
class ExerciseAboutTab extends StatelessWidget {
  final Exercise exercise;
  const ExerciseAboutTab({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15), child: Text(exercise.description));
  }
}
