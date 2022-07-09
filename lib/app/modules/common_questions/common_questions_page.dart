import 'package:flutter/material.dart';

class CommonQuestions extends StatelessWidget {
  const CommonQuestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Principais Perguntas',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Dúvidas frequentes sobre o uso do Mercado Justo',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            Card(
              child: Column(children: [
                ExpansionTile(
                  title: Text('Como que eu uso o aplicativo Mercado Justo'),
                  children: [Text('Aqui uma resposta')],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
