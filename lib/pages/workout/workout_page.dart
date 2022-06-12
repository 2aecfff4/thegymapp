import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:thegymapp/api/api.dart' show api;
import 'package:thegymapp/api/models/template_workout.dart';
import 'package:thegymapp/pages/workout/template_workout_edit_page.dart';
import 'package:thegymapp/pages/workout/template_workout_tile.dart';

class WorkoutPage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  WorkoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
        thickness: 8.0,
        thicknessWhileDragging: 12.0,
        radius: const Radius.circular(34.0),
        controller: _scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      return;
                    },
                    child: const Text("Start an empty workout"),
                  ))
                ],
              ),
            ),
            Row(children: <Widget>[
              const Expanded(child: Divider()),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("Templates")),
              Expanded(
                  child: Row(children: [
                const Expanded(child: Divider()),
                TextButton(
                    onPressed: () {
                      // #TODO: Silently create a workout template.
                      Navigator.of(context)
                          .push(routeTemplateWorkoutEditPage(1));
                    },
                    child: const Icon(Icons.add))
              ])),
            ]),
            FutureBuilder(
                future: api.workouts.getTemplateWorkoutsUi(),
                builder:
                    (context, AsyncSnapshot<List<TemplateWorkoutUi>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      var widgets = snapshot.data!.map((data) {
                        return TemplateWorkoutTile(
                          templateWorkout: data,
                        );
                      }).toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: widgets.length,
                        itemBuilder: (_, index) {
                          return widgets[index];
                        },
                      );
                    }

                    return const Center(
                      child: Text("You don't have any workout templates!"),
                    );
                  } else {
                    //return const Center(child: CircularProgressIndicator());
                    return Container();
                  }
                })
          ],
        ));
  }
}
