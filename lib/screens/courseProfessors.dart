import 'package:flutter/material.dart';

class CourseProfessors extends StatelessWidget {
  // var name = "";
  // var codeSIA = "";
  // var credits = "";
  // var programName = "";
  // var programDegree = "";
  // var programFaculty = "";
  // var professors = [];

  // Course(this.name, this.codeSIA, this.credits, this.programName,
  //     this.programDegree, this.programFaculty, this.professors);

  @override
  Widget build(BuildContext context) {
    // Recibe la información de curso desde la ruta como argumento
    final Map courseInfo = ModalRoute.of(context)?.settings.arguments as Map;
    final professors = courseInfo["professors"];
    return Scaffold(
        appBar: AppBar(
          title: Container(
              width: double.infinity,
              child: Text(
                "${courseInfo["name"]}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
        ),
        // IMPORTANTE: renderiza dinamicamente widgets por cada item en la lista
        body: ListView.builder(
            padding: const EdgeInsets.only(top: 15),
            itemCount: professors.length,
            itemBuilder: (context, i) {
              final professor = professors[i];
              return Center(
                child: Card(
                  elevation: 1.5,
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(
                        "${professor["name"]["first"]} ${professor["name"]["last"]}"),
                    subtitle: Text(
                        "${courseInfo["program"]["faculty"]} \n Score: ${professor["score"]} ⭐"),
                  ),
                ),
              );
            }));
  }
}
