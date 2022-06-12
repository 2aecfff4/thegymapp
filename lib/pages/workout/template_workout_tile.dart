import 'package:flutter/material.dart';
import 'package:thegymapp/api/models/exercise.dart';
import 'package:thegymapp/api/models/template_workout.dart';
import 'package:thegymapp/pages/exercises/exercise_details/exercise_details.dart';
import 'package:thegymapp/pages/workout/template_workout_edit_page.dart';
import 'package:thegymapp/pages/workout/template_workout_preview_page.dart';

///
class TemplateWorkoutTile extends StatelessWidget {
  final TemplateWorkoutUi templateWorkout;
  const TemplateWorkoutTile({Key? key, required this.templateWorkout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(5));

    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () {
          Navigator.of(context)
              .push(routeTemplateWorkoutPreviewPage(templateWorkout.id));
        },
        canRequestFocus: true,
        autofocus: false,
        child: Semantics(
          selected: false,
          enabled: true,
          child: Ink(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                ),
                borderRadius: borderRadius),
            child: SafeArea(
                top: false,
                bottom: false,
                minimum: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      templateWorkout.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    _TemplateWorkoutExerciseList(
                      templateWorkout: templateWorkout,
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class _TemplateWorkoutExerciseList extends StatelessWidget {
  final TemplateWorkoutUi templateWorkout;
  const _TemplateWorkoutExerciseList({Key? key, required this.templateWorkout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: templateWorkout.exercises.map((e) {
          return Text("${e.sets.length} × ${e.exercise.name}");
        }).toList());
  }
}
