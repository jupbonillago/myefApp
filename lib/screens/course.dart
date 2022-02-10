import 'package:flutter/material.dart';

import 'package:myefapp_front/widgets/info.dart';

class Course extends StatelessWidget {
  // var name = "";
  // var codeSIA = "";
  // var credits = "";
  // var programName = "";
  // var programDegree = "";
  // var programFaculty = "";
  // var comments = [];

  // Course(this.name, this.codeSIA, this.credits, this.programName,
  //     this.programDegree, this.programFaculty, this.professors);

  @override
  Widget build(BuildContext context) {
    // Recibe la información de curso desde la ruta como argumento
    final Map courseInfo = ModalRoute.of(context)?.settings.arguments as Map;

    //navega al siguiente widget
    navigate() {
      debugPrint('Card tapped.');
      Navigator.of(context)
          .pushNamed("/courseProfessors", arguments: courseInfo);
    }

    var comments = courseInfo["comments"];
    try {
      comments.length;
    } catch (error) {
      comments = [
        {
          "body": "Aún no hay comentarios en esta asignatura..",
          "user.forename": ""
        }
      ];
    }
    return Scaffold(
        appBar: InfoCourse(
            courseInfo["name"],
            courseInfo["credits"],
            courseInfo["codeSIA"],
            courseInfo["program"]["name"],
            courseInfo["program"]["faculty"],
            220,
            navigate),
        // IMPORTANTE: renderiza dinamicamente widgets por cada item en la lista
        // TODO En caso de ERROR quitar column y Expanded
        body: Column(
          children: <Widget>[
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  elevation: 5,
                  //minimumSize: const Size.fromHeight(50),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 2),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed("/courseComment", arguments: courseInfo);
                },
                child: const Text("Realizar un comentario",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16.0))),
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.only(top: 15),
                    itemCount: comments.length,
                    itemBuilder: (context, i) {
                      final comment = comments[i];
                      return Center(
                        child: Card(
                          //elevation: 2,
                          child: comment["user.forename"] != ""
                              ? ListTile(
                                  title: Text("${comment["body"]}"),
                                  subtitle: Text(
                                      "${comment["user.forename"]} \n Score: ${comment["rating"]} ⭐"),
                                )
                              : ListTile(
                                  title: Text("${comment["body"]}"),
                                ),
                        ),
                      );
                    })),
          ],
        ));
  }
}
