import 'package:flutter/material.dart';

class InfoCourse extends StatelessWidget implements PreferredSizeWidget {
  var _name = "";
  var _credits = 0;
  var _codeSIA = "";
  var _degree = "";
  var _faculty = "";
  final double height;

  // notifica al widget padre que ha sido llamado
  final Function() notifyParent;

  InfoCourse(this._name, this._credits, this._codeSIA, this._degree,
      this._faculty, @required this.height, @required this.notifyParent);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            const SizedBox(
              //Use of SizedBox
              height: 40,
            ),
            Text(
              _name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white),
            ),
            Text("${_credits} créditos",
                style: const TextStyle(color: Colors.white70)),
            Text("${_codeSIA}", style: const TextStyle(color: Colors.white70)),
            Text(_degree, style: const TextStyle(color: Colors.white)),
            Text(_faculty, style: const TextStyle(color: Colors.white)),
            SizedBox(height: 4),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  elevation: 5,
                  // minimumSize: const Size.fromHeight(50),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 2),
                ),
                onPressed: () {
                  notifyParent();
                },
                child: const Text("profesores",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16.0))),
          ],
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
