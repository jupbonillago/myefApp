import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:myefapp_front/widgets/customAppbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();

  static _HomeState? of(BuildContext context) =>
      context.findAncestorStateOfType<_HomeState>();
}

typedef void StringCallback(String val);

class _HomeState extends State<Home> {
  // Url base del backend
  final baseurl = "https://myefapp-api.herokuapp.com/api/v1/";
  // Cursos cargados en memoria
  var _courses = [];
  // Filtro por aplicar
  String _filter = "";
  // Setter para el filtro
  set string(String value) => setState(() => _filter = value);
  // Get all courses
  void fetchCourses() async {
    var url = baseurl + "courses";
    // get Request
    try {
      final response = await get(Uri.parse(url));
      // interpreta el json de respuesta y lo guarda en una lista de mapas
      final data = jsonDecode(response.body);
      // modifica cursos y actualiza la vista
      setState(() {
        // casteo de map a list al recibir un json y no una lista de json
        _courses = data["data"];
      });
    } catch (err) {
      print(err);
      final data = [];
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  refresh() {
    //TODO
    if (_filter != "") {
      var _temp = _courses;
      _temp.removeWhere((element) => !element["name"].contains(_filter));
      setState(() {
        _courses = _temp;
      });
    } else {
      fetchCourses();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(60, refresh,
            callback: (val) => setState(() => _filter = val)),
        // IMPORTANTE: renderiza dinamicamente widgets por cada item en la lista
        body: _courses.isEmpty
            ? const Center(
                child: Image(
                    image: AssetImage('assets/img/progress_indicator.gif')))
            : ListView.builder(
                padding: const EdgeInsets.only(top: 15),
                itemCount: _courses.length,
                itemBuilder: (context, i) {
                  final course = _courses[i];
                  return Center(
                    child: Card(
                      elevation: 4,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          debugPrint('Card tapped.');
                          Navigator.of(context)
                              .pushNamed("/course", arguments: course);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.school_rounded),
                              title: Text(course["name"]),
                              subtitle: Text(
                                  "${course["codeSIA"]} \n ${course["program"]["faculty"]}"),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: const Text('Descartar'),
                                  onPressed: () {/* ... */},
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  child: const Text('Agregar'),
                                  onPressed: () {/* ... */},
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }));
  }
}
