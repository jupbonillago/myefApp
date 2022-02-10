import 'package:flutter/material.dart';

typedef void StringCallback(String val);

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final StringCallback callback;
  // controlador para el textfield de busqueda
  TextEditingController searchController = new TextEditingController();

  // notifica al widget padre que ha sido llamado
  final Function() notifyParent;

  // filtra por materias
  void courseFilter() {
    callback(searchController.text);
    notifyParent();
  }

  CustomAppbar(@required this.height, this.notifyParent,
      {required this.callback});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        // The search area here
        title: Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  callback("");
                  print("X icon pressed");
                  notifyParent();
                },
              ),
              hintText: 'buscar...',
              border: InputBorder.none),
          onSubmitted: (string) {
            callback(searchController.text);
            notifyParent();
          },
        ),
      ),
    ));
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
