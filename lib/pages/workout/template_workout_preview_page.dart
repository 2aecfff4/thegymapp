import 'package:flutter/material.dart';
import 'package:thegymapp/api/models/template_workout.dart';
import 'package:thegymapp/homepage/homepage_app_bar.dart';
import 'package:thegymapp/pages/workout/template_workout_edit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:thegymapp/api/api.dart' show api;

class TemplateWorkoutPreviewPage extends StatelessWidget {
  final int templateWorkoutId;
  const TemplateWorkoutPreviewPage({Key? key, required this.templateWorkoutId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomepageAppBar(
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return const [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Edit"),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text("Duplicate"),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Text("Remove"),
              ),
            ];
          }, onSelected: (value) {
            switch (value) {
              case 0:
                Navigator.of(context)
                    .push(routeTemplateWorkoutEditPage(templateWorkoutId));
                break;
              case 1:
                break;
              case 2:
                // #TODO: Remove current template
                Navigator.of(context).pop();
                break;
              default:
                assert(false);
                break;
            }
          }),
        ],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      child: const Text("Start workout"),
                    ))
                  ],
                )),
            Row(
              children: const [Expanded(child: Divider())],
            ),
            Expanded(
                child: CupertinoScrollbar(
              thickness: 8.0,
              thicknessWhileDragging: 12.0,
              radius: const Radius.circular(34.0),
              child: FutureBuilder(
                  future: api.workouts.getTemplateWorkout(templateWorkoutId),
                  builder:
                      (context, AsyncSnapshot<TemplateWorkoutUi?> snapshot) {
                    if (!snapshot.hasData) {
                      //return const Center(child: CircularProgressIndicator());
                      return Container();
                    }

                    if (snapshot.data == null) {
                      return ListView(
                        children: const [],
                      );
                    }

                    final widgets = snapshot.data!.exercises.map((data) {
                      return _PreviewExerciseTile(
                        templateWorkoutExercise: data,
                      );
                    }).toList();

                    return ListView.builder(
                      itemCount: widgets.length,
                      itemBuilder: (_, index) {
                        return widgets[index];
                      },
                    );
                  }),
            )),
          ]),
    );
  }
}

///
Route routeTemplateWorkoutPreviewPage(final int templateWorkoutId) {
  return MaterialPageRoute(builder: (_) {
    return TemplateWorkoutPreviewPage(templateWorkoutId: templateWorkoutId);
  });
}

///
class _PreviewExerciseTile extends StatelessWidget {
  final TemplateWorkoutExerciseUi templateWorkoutExercise;
  const _PreviewExerciseTile({Key? key, required this.templateWorkoutExercise})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leadingWidget = () {
      if (templateWorkoutExercise.exercise.iconPath != null) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: ImageIcon(AssetImage(
              "assets/exercises/icons/${templateWorkoutExercise.exercise.iconPath}")),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
              templateWorkoutExercise.exercise.name
                  .substring(0, 1)
                  .toUpperCase(),
              style: const TextStyle(fontSize: 24, color: Colors.white70)),
        );
      }
    }();

    return ListTile(
      contentPadding: const EdgeInsets.all(5),
      dense: true,
      onTap: () {
        //
      },
      leading: leadingWidget,
      title: Text(
          "${templateWorkoutExercise.sets.length} × ${templateWorkoutExercise.exercise.name}",
          style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(templateWorkoutExercise.exercise.category),
    );
  }
}
