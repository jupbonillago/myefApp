import 'package:flutter/material.dart';
import 'package:myefapp_front/screens/course.dart';
import 'package:myefapp_front/screens/courseProfessors.dart';
import 'package:myefapp_front/screens/courseComment.dart';

import 'package:myefapp_front/screens/login.dart';
import 'package:myefapp_front/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MyEFapp',
        theme: ThemeData(fontFamily: 'OpenSans'),
        initialRoute: "/login",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/login": (BuildContext context) => Login(),
          "/home": (BuildContext context) => const Home(),
          "/course": (BuildContext context) => Course(),
          "/courseProfessors": (BuildContext courseProfessors) =>
              CourseProfessors(),
          "/courseComment": (BuildContext courseComment) => CourseComment(),
          //"/profile": (BuildContext context) => new Profile(),
          //"/articles": (BuildContext context) => new Articles(),
          //"/elements": (BuildContext context) => new Elements(),
          //"/account": (BuildContext context) => new Register(),
          //"/pro": (BuildContext context) => new Pro(),
        });
  }
}
