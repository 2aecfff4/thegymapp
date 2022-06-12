import 'package:flutter/material.dart';
import 'package:thegymapp/api/models/exercise.dart';
import 'package:thegymapp/config.dart';
import 'package:thegymapp/pages/exercises/exercise_details/exercise_about_tab.dart';
import 'package:thegymapp/pages/exercises/exercise_details/exercise_history_tab.dart';
import 'package:thegymapp/pages/exercises/exercise_details/exercise_records_tab.dart';
import 'package:thegymapp/pages/exercises/exercise_details/exercise_statistics_tab.dart';

///
class ExerciseDetails extends StatefulWidget {
  final Exercise exercise;
  const ExerciseDetails({Key? key, required this.exercise}) : super(key: key);

  @override
  State<ExerciseDetails> createState() => _ExerciseDetailsState();
}

///
class _ExerciseDetailsState extends State<ExerciseDetails> {
  @override
  Widget build(BuildContext context) {
    const upperTab = TabBar(tabs: <Tab>[
      Tab(text: "About"),
      Tab(text: "History"),
      Tab(text: "Statistics"),
      Tab(text: "Records"),
    ]);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          title: Text(widget.exercise.name),
          bottom: upperTab,
        ),
        body: TabBarView(
          children: [
            ExerciseAboutTab(
              exercise: widget.exercise,
            ),
            ExerciseHistoryTab(),
            ExerciseStatisticsTab(),
            ExerciseRecordsTab(),
          ],
        ),
      ),
    );
  }
}

Route exerciseDetailsRoute(final Exercise exercise) {
  return MaterialPageRoute(builder: (_) {
    return ExerciseDetails(exercise: exercise);
  });
}
