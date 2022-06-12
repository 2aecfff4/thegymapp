import 'package:thegymapp/api/models/exercise.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:thegymapp/api/models/template_exercise_set.dart';
import 'dart:convert';

import 'package:thegymapp/api/models/template_workout.dart';

class DbApi {
  static const String EXERCISES_TABLE_NAME = "Exercises";
  static const String WORKOUT_TABLE_NAME = "Workout";
  static const String WORKOUT_EXERCISE_TABLE_NAME = "WorkoutExercise";
  static const String EXERCISE_SET_TABLE_NAME = "ExerciseSet";

  static const String TEMPLATE_WORKOUT_TABLE_NAME = "TemplateWorkout";
  static const String TEMPLATE_WORKOUT_EXERCISE_TABLE_NAME =
      "TemplateWorkoutExercise";
  static const String TEMPLATE_EXERCISE_SET_TABLE_NAME = "TemplateExerciseSet";

  ///
  Future<List<Exercise>> getExercises({final bool sorted = false}) async {
    final db = await _DatabaseHelper.internal().db;
    final exercises = await db.query(EXERCISES_TABLE_NAME, orderBy: () {
      if (sorted) {
        return "name";
      }
      return null;
    }());

    final List<Exercise> result = List.generate(exercises.length, (i) {
      return Exercise.fromJson(exercises[i]);
    });

    return result;
  }

  ///
  Future<List<TemplateWorkout>> getTemplateWorkouts() async {
    final db = await _DatabaseHelper.internal().db;
    final templateWorkouts = await db.query(TEMPLATE_WORKOUT_TABLE_NAME);

    final List<TemplateWorkout> result =
        List.generate(templateWorkouts.length, (i) {
      return TemplateWorkout.fromJson(templateWorkouts[i]);
    });

    return result;
  }

  ///
  Future<List<TemplateWorkoutUi>> getTemplateWorkoutsUi() async {
    final db = await _DatabaseHelper.internal().db;
    final templateWorkouts = await getTemplateWorkouts();

    List<TemplateWorkoutUi> result = [];
    for (final templateWorkout in templateWorkouts) {
      List<TemplateWorkoutExerciseUi> exercises = [];
      final templateWorkoutExercisesQuery = await db.query(
          TEMPLATE_WORKOUT_EXERCISE_TABLE_NAME,
          where: "idTemplateWorkout = ?",
          whereArgs: [templateWorkout.id]);
      for (var i = 0; i < templateWorkoutExercisesQuery.length; i++) {
        final Map<String, dynamic> map = templateWorkoutExercisesQuery[i];
        final Map<String, dynamic> exerciseQuery = (await db.query(
            EXERCISES_TABLE_NAME,
            where: "id = ?",
            whereArgs: [map["idExercise"]]))[0];

        List<TemplateExerciseSet> sets = [];
        final setsQuery = await db.query(TEMPLATE_EXERCISE_SET_TABLE_NAME,
            where: "idTemplateWorkoutExercise = ?",
            whereArgs: [map["idExercise"]]);

        for (var j = 0; j < setsQuery.length; j++) {
          sets.add(TemplateExerciseSet.fromJson(setsQuery[j]));
        }

        exercises.add(TemplateWorkoutExerciseUi(
            id: map["id"],
            note: map["note"],
            exercise: Exercise.fromJson(exerciseQuery),
            sets: sets));
      }

      result.add(TemplateWorkoutUi(
          id: templateWorkout.id,
          name: templateWorkout.name,
          exercises: exercises));
    }

    return result;
  }

  ///
  Future<TemplateWorkoutUi?> getTemplateWorkout(final int id) async {
    final db = await _DatabaseHelper.internal().db;
    final templateWorkoutQuery = await db
        .query(TEMPLATE_WORKOUT_TABLE_NAME, where: "id = ?", whereArgs: [id]);

    if (templateWorkoutQuery.isEmpty) {
      return null;
    }

    final templateWorkout = TemplateWorkout.fromJson(templateWorkoutQuery[0]);

    List<TemplateWorkoutExerciseUi> exercises = [];
    final templateWorkoutExercisesQuery = await db.query(
        TEMPLATE_WORKOUT_EXERCISE_TABLE_NAME,
        where: "idTemplateWorkout = ?",
        whereArgs: [templateWorkout.id]);

    for (var i = 0; i < templateWorkoutExercisesQuery.length; i++) {
      final Map<String, dynamic> map = templateWorkoutExercisesQuery[i];
      final Map<String, dynamic> exerciseQuery = (await db.query(
          EXERCISES_TABLE_NAME,
          where: "id = ?",
          whereArgs: [map["idExercise"]]))[0];

      List<TemplateExerciseSet> sets = [];
      final setsQuery = await db.query(TEMPLATE_EXERCISE_SET_TABLE_NAME,
          where: "idTemplateWorkoutExercise = ?",
          whereArgs: [map["idExercise"]]);

      for (var j = 0; j < setsQuery.length; j++) {
        sets.add(TemplateExerciseSet.fromJson(setsQuery[j]));
      }

      exercises.add(TemplateWorkoutExerciseUi(
          id: map["id"],
          note: map["note"],
          exercise: Exercise.fromJson(exerciseQuery),
          sets: sets));
    }

    return TemplateWorkoutUi(
        id: templateWorkout.id,
        name: templateWorkout.name,
        exercises: exercises);
  }
}

class _DatabaseHelper {
  static final _DatabaseHelper _instance = _DatabaseHelper.internal();
  factory _DatabaseHelper() => _instance;
  static Database? _database;

  Future<Database> get db async {
    _database ??= await init();
    return _database!;
  }

  _DatabaseHelper.internal();

  Future<Database> init() async {
    return openDatabase(
      join(await getDatabasesPath(), "database.db"),
      onCreate: (db, version) async {
        await db.execute("""
            CREATE TABLE Exercises(
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              iconPath TEXT NULL,
              name TEXT NOT NULL, 
              description TEXT NOT NULL, 
              category TEXT NOT NULL
            )
          """);

        await db.execute("""
            CREATE TABLE Workout(
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              dateStart INTEGER NOT NULL, 
              dateEnd INTEGER NULL
            )
          """);

        await db.execute("""
            CREATE TABLE WorkoutExercise(
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              idWorkout INTEGER NOT NULL, 
              idExercise INTEGER NOT NULL,
              FOREIGN KEY (idWorkout) REFERENCES Workout(id) ON DELETE CASCADE,
              FOREIGN KEY (idExercise) REFERENCES Exercises(id)
            )
          """);

        await db.execute("""
            CREATE TABLE ExerciseSet(
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              idWorkoutExercise INTEGER NOT NULL,
              isWarmup INTEGER NOT NULL, 
              numReps INTEGER NOT NULL, 
              weight REAL NOT NULL,
              rpe REAL NOT NULL,
              dateFinish INTEGER NOT NULL,
              FOREIGN KEY (idWorkoutExercise) REFERENCES WorkoutExercise(id) ON DELETE CASCADE
            )
          """);

        //////////////////////////////////////////////////////////////////////////////////
        /// Templates

        await db.execute("""
            CREATE TABLE TemplateWorkout(
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL
            )
          """);

        await db.execute("""
            CREATE TABLE TemplateWorkoutExercise(
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              idTemplateWorkout INTEGER NOT NULL, 
              idExercise INTEGER NOT NULL,
              note TEXT NULL,
              tag TEXT NULL,
              FOREIGN KEY (idTemplateWorkout) REFERENCES TemplateWorkout(id) ON DELETE CASCADE,
              FOREIGN KEY (idExercise) REFERENCES Exercises(id)
            )
          """);

        await db.execute("""
            CREATE TABLE TemplateExerciseSet(
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              idTemplateWorkoutExercise INTEGER NOT NULL,
              isWarmup INTEGER NOT NULL, 
              numReps INTEGER NOT NULL, 
              weight REAL NOT NULL,
              rpe REAL NOT NULL,
              FOREIGN KEY (idTemplateWorkoutExercise) REFERENCES TemplateWorkoutExercise(id) ON DELETE CASCADE
            )
          """);

        //////////////////////////////////////////////////////////////////////////////////
        /// Add exercises from json

        final jsonStr =
            await rootBundle.loadString("assets/exercises/exercises.json");
        final json = jsonDecode(jsonStr);

        for (var data in json) {
          await db.insert("Exercises", data,
              conflictAlgorithm: ConflictAlgorithm.replace);
        }

        //////////////////////////////////////////////////////////////////////////////////
        /// Add sample template workout
        await db.insert(
            "TemplateWorkout",
            {
              "name": "Test template workout",
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
        await db.insert(
            "TemplateWorkoutExercise",
            {
              "idTemplateWorkout": 1,
              "idExercise": 1,
              "note": "Test note",
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
        await db.insert(
            "TemplateExerciseSet",
            {
              "idTemplateWorkoutExercise": 1,
              "isWarmup": 0,
              "numReps": 8,
              "weight": 55,
              "rpe": 9.5,
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
        await db.insert(
            "TemplateExerciseSet",
            {
              "idTemplateWorkoutExercise": 1,
              "isWarmup": 0,
              "numReps": 8,
              "weight": 75,
              "rpe": 9.5,
            },
            conflictAlgorithm: ConflictAlgorithm.replace);

        await db.insert(
            "TemplateWorkoutExercise",
            {
              "idTemplateWorkout": 1,
              "idExercise": 2,
              "note": "Test note 2",
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
        await db.insert(
            "TemplateExerciseSet",
            {
              "idTemplateWorkoutExercise": 2,
              "isWarmup": 1,
              "numReps": 8,
              "weight": 15,
              "rpe": 8.0,
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
      },
      onUpgrade: (db, oldVersion, newVersion) {},
      version: 1,
    );
  }
}
