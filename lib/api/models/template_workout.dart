import 'package:thegymapp/api/models/exercise.dart';
import 'package:thegymapp/api/models/template_exercise_set.dart';

///
class TemplateWorkout {
  final int id;
  final String name;

  ///
  TemplateWorkout({required this.id, required this.name});

  ///
  factory TemplateWorkout.fromJson(final Map<String, dynamic> map) {
    return TemplateWorkout(
      id: map["id"],
      name: map["name"],
    );
  }

  ///
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
    };
  }
}

//////////////////////////////////////////////////////////////////////////////
///

///
class TemplateWorkoutExerciseUi {
  final int id;
  final String note;
  final Exercise exercise;
  final List<TemplateExerciseSet> sets;

  ///
  TemplateWorkoutExerciseUi(
      {required this.id,
      required this.note,
      required this.exercise,
      required this.sets});
}

///
class TemplateWorkoutUi {
  final int id;
  final String name;
  final List<TemplateWorkoutExerciseUi> exercises;

  ///
  TemplateWorkoutUi(
      {required this.id, required this.name, required this.exercises});
}
