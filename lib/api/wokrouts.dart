import 'package:thegymapp/api/models/exercise.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:thegymapp/api/api.dart' show api;
import 'package:thegymapp/api/models/template_workout.dart';

///
class WorkoutsApi {
  ///
  Future<List<TemplateWorkout>> getTemplateWorkouts() async {
    return await api.db.getTemplateWorkouts();
  }

  ///
  Future<List<TemplateWorkoutUi>> getTemplateWorkoutsUi() async {
    return await api.db.getTemplateWorkoutsUi();
  }

  ///
  Future<TemplateWorkoutUi?> getTemplateWorkout(final int id) async {
    return await api.db.getTemplateWorkout(id);
  }
}
