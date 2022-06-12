///
class Workout {
  final int id;

  /// Stored in Unix time.
  final int dateStart;

  /// Stored in Unix time. If [dateEnd] is null, then workout is not finished yet.
  final int? dateEnd;

  ///
  Workout({required this.id, required this.dateStart, this.dateEnd});

  ///
  factory Workout.fromJson(final Map<String, dynamic> map) {
    return Workout(
        id: map["id"], dateStart: map["dateStart"], dateEnd: map["dateEnd"]);
  }

  ///
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "dateStart": dateStart,
      "dateEnd": dateEnd,
    };
  }
}
