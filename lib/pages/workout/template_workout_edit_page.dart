import 'package:flutter/material.dart';
import 'package:thegymapp/homepage/homepage_app_bar.dart';

class TemplateWorkoutEditPage extends StatelessWidget {
  final int templateWorkoutId;
  TemplateWorkoutEditPage({Key? key, required this.templateWorkoutId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomepageAppBar(
        actions: [],
        title: "Edit template",
      ),
      body: Center(child: Text("TemplateWorkoutEditPage")),
    );
  }
}

Route routeTemplateWorkoutEditPage(final int templateWorkoutId) {
  return MaterialPageRoute(builder: (_) {
    return TemplateWorkoutEditPage(templateWorkoutId: templateWorkoutId);
  });
}
