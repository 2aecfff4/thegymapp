import 'package:flutter/material.dart';
import 'package:thegymapp/pages/history/history_page.dart';
import 'package:thegymapp/pages/settings.dart';
import 'package:thegymapp/pages/summary.dart';
import 'package:thegymapp/pages/exercises/exercises_page.dart';
import 'package:thegymapp/pages/workout/workout_page.dart';
import 'package:thegymapp/homepage/homepage_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedPage = 0;
  final List<Widget> _pages = <Widget>[
    const SummaryPage(),
    const HistoryPage(),
    WorkoutPage(),
    const ExercisesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HomepageAppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: "Settings",
              onPressed: () {
                Navigator.of(context).push(settingsRoute());
              },
            ),
          ],
        ),
        body: _pages[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.summarize,
              ),
              label: "Summary",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
              ),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
              ),
              label: "Workout",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.line_weight,
              ),
              label: "Exercises",
            ),
          ],
          currentIndex: _selectedPage,
          onTap: _navBarOnTap,
        ));
  }

  void _navBarOnTap(final int index) {
    setState(() {
      _selectedPage = index;
    });
  }
}
