///
class WorkoutExercise {
  final int id;
  final int idWorkout;
  final int idExercise;

  ///
  WorkoutExercise(
      {required this.id, required this.idWorkout, required this.idExercise});

  ///
  factory WorkoutExercise.fromJson(final Map<String, dynamic> map) {
    return WorkoutExercise(
      id: map["id"],
      idWorkout: map["idWorkout"],
      idExercise: map["idExercise"],
    );
  }

  ///
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idWorkout": idWorkout,
      "idExercise": idExercise,
    };
  }
}
