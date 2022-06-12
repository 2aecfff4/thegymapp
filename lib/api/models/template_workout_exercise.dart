///
class TemplateWorkoutExercise {
  final int id;
  final int idWorkout;
  final int idExercise;

  ///
  TemplateWorkoutExercise(
      {required this.id, required this.idWorkout, required this.idExercise});

  ///
  factory TemplateWorkoutExercise.fromJson(final Map<String, dynamic> map) {
    return TemplateWorkoutExercise(
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
