import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myefapp_front/widgets/rating.dart';

import 'package:http/http.dart';

class CourseComment extends StatefulWidget {
  const CourseComment({Key? key}) : super(key: key);

  @override
  _CourseCommentState createState() => _CourseCommentState();
}

class _CourseCommentState extends State<CourseComment> {
  double rating = 5.0;
  Map courseInfo = {};
  // Url base del backend
  final baseurl = "https://myefapp-api.herokuapp.com/api/v1/";

  // Envia el comentario como un request de tipo POST
  void postComment() async {
    String id = courseInfo["_id"].toString();
    debugPrint(id);
    var url = baseurl + "courses/61bb2f173a8978a003ad407b/comment";
    final response = await post(Uri.parse(url),
        //TODO: arreglar este POST request
        headers: {
          "Accept": "*/*",
          "User-Agent": "Thunder Client (https://www.thunderclient.io)"
        },
        body: json.encode({
          "comment": {
            "user": {"_id": "61bb2f173a8978a003ad407b", "forename": "Pedro"},
            "body": "No disfrute el curso, no aprendí nada. ",
            "rating": 1,
          }
        }));

    if (response.statusCode == 200) {
      // Si el server retorna 200 OK como respuesta,
      Navigator.pop(context);
    } else {
      // Si el server NO retorna 200 OK como respuesta,
      debugPrint(json.encode({
        "comment": {
          "user": {"_id": "61bb2f173a8978a003ad407b", "forename": "Pedro"},
          "body": "No disfrute el curso, no aprendí nada. ",
          "rating": 1,
        }
      }));
      debugPrint("respuesta: ");
      debugPrint("${response.statusCode}");
      debugPrint("${response.body}");
      throw Exception('Error en el request');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Recibe la información de curso desde la ruta como argumento
    courseInfo = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Container(
            width: double.infinity,
            child: Text(
              "${courseInfo["name"]}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "Agrega tu comentario",
              style: TextStyle(
                fontSize: 24,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
              width: double.infinity,
              height: 180,
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.blueAccent)),
              child: Center(
                child: TextField(
                  expands: true,
                  maxLines: null,
                  //controller: searchController,
                  decoration: InputDecoration(
                      hintText: 'Describe tu experiencia con la asignatura...',
                      border: InputBorder.none),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Row(children: <Widget>[
            Text("      Calificación de tu experiencia:        "),
            StarRating(
              rating: rating,
              onRatingChanged: (rating) => setState(() => this.rating = rating),
              color: Colors.blue,
            )
          ])),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                elevation: 5,
                //minimumSize: const Size.fromHeight(50),
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 2),
              ),
              onPressed: postComment,
              child: const Text("Enviar comentario",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0))),
        ],
      ),
    );
  }
}
