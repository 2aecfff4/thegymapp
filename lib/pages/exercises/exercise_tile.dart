import 'package:flutter/material.dart';
import 'package:thegymapp/api/models/exercise.dart';
import 'package:thegymapp/pages/exercises/exercise_details/exercise_details.dart';

///
class ExerciseTile extends StatelessWidget {
  final Exercise exercise;
  const ExerciseTile({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leadingWidget = () {
      if (exercise.iconPath != null) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: ImageIcon(
              AssetImage("assets/exercises/icons/${exercise.iconPath}")),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Text(exercise.name.substring(0, 1).toUpperCase(),
              style: const TextStyle(fontSize: 24, color: Colors.white70)),
        );
      }
    }();

    return ListTile(
      contentPadding: const EdgeInsets.all(5),
      dense: true,
      onTap: () {
        Navigator.push(context, exerciseDetailsRoute(exercise));
      },
      leading: leadingWidget,
      title: Text(exercise.name),
      subtitle: Text(exercise.category),
      // leading: ,
    );
  }
}
