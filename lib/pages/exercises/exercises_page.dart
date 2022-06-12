import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:thegymapp/api/api.dart' show api;
import 'package:thegymapp/api/models/exercise.dart';
import 'package:thegymapp/pages/exercises/exercise_tile.dart';

///
class ExercisesPage extends StatefulWidget {
  const ExercisesPage({Key? key}) : super(key: key);

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

///
class _ExercisesPageState extends State<ExercisesPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
        thickness: 8.0,
        thicknessWhileDragging: 12.0,
        radius: const Radius.circular(34.0),
        controller: _scrollController,
        child: FutureBuilder(
            future: api.exercises.getExercises(sorted: true),
            builder: (context, AsyncSnapshot<List<Exercise>> snapshot) {
              if (snapshot.hasData) {
                var widgets = snapshot.data!.map((data) {
                  return ExerciseTile(
                    exercise: data,
                  );
                }).toList();

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: widgets.length,
                  itemBuilder: (_, index) {
                    return widgets[index];
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
