///
class TemplateExerciseSet {
  final int id;
  final int idTemplateWorkoutExercise;
  final bool isWarmup;
  final int numReps;
  final double weight;
  final double rpe;

  ///
  TemplateExerciseSet(
      {required this.id,
      required this.idTemplateWorkoutExercise,
      required this.isWarmup,
      required this.numReps,
      required this.weight,
      required this.rpe});

  ///
  factory TemplateExerciseSet.fromJson(final Map<String, dynamic> map) {
    return TemplateExerciseSet(
      id: map["id"],
      idTemplateWorkoutExercise: map["idTemplateWorkoutExercise"],
      isWarmup: map["isWarmup"] == 1 ? true : false,
      numReps: map["numReps"],
      weight: map["weight"],
      rpe: map["rpe"],
    );
  }

  ///
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idTemplateWorkoutExercise": idTemplateWorkoutExercise,
      "isWarmup": isWarmup,
      "numReps": numReps,
      "weight": weight,
      "rpe": rpe,
    };
  }
}
