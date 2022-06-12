import 'package:thegymapp/api/db.dart';
import 'package:thegymapp/api/exercises.dart';
import 'package:thegymapp/api/statistics.dart';
import 'package:thegymapp/api/wokrouts.dart';

///
class Api {
  ExercisesApi exercises = ExercisesApi();
  StatisticsApi statistics = StatisticsApi();
  WorkoutsApi workouts = WorkoutsApi();
  DbApi db = DbApi();
}

var api = Api();
