import 'package:thegymapp/api/models/exercise.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:thegymapp/api/api.dart' show api;

///
class ExercisesApi {
  ///
  Future<List<Exercise>> getExercises({final bool sorted = false}) async {
    return await api.db.getExercises(sorted: sorted);
  }
}
