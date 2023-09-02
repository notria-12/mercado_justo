import 'package:flutter/material.dart';

class NoConnectionWidget extends StatelessWidget {
  NoConnectionWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/img/no_connection.png',
              height: 150,
            ),
            Text(
              "Ops! Sem conexão",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
                // color: ColorLib.black.colorO(0.7),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Verifique sua conexão com a Internet!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
