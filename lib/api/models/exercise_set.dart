///
class WorkoutExercise {
  final int id;
  final int idWorkoutExercise;
  final bool isWarmup;
  final int numReps;
  final double weight;
  final double rpe;

  /// Stored in Unix time.
  final int dateFinish;

  ///
  WorkoutExercise(
      {required this.id,
      required this.idWorkoutExercise,
      required this.isWarmup,
      required this.numReps,
      required this.weight,
      required this.rpe,
      required this.dateFinish});

  ///
  factory WorkoutExercise.fromJson(final Map<String, dynamic> map) {
    return WorkoutExercise(
        id: map["id"],
        idWorkoutExercise: map["idWorkoutExercise"],
        isWarmup: map["isWarmup"],
        numReps: map["numReps"],
        weight: map["weight"],
        rpe: map["rpe"],
        dateFinish: map["dateFinish"]);
  }

  ///
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idWorkoutExercise": idWorkoutExercise,
      "isWarmup": isWarmup,
      "numReps": numReps,
      "weight": weight,
      "rpe": rpe,
      "dateFinish": dateFinish,
    };
  }
}
