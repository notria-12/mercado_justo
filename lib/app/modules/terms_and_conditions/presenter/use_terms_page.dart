import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/domain/entities/use_terms_entity.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/presenter/terms_and_conditions_store.dart';
import 'package:flutter_html/flutter_html.dart';

class UseTermsPage extends StatelessWidget {
  UseTermsPage({Key? key}) : super(key: key);
  final useTermsStore = Modular.get<TermsAndConditionsStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Termos e Condições'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Termos e Condições de Uso',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 24,
            ),
            FutureBuilder<UseTermsEntity>(
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          'Termos de uso não dispoíveis no momento',
                          style: TextStyle(color: Colors.black38),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return Html(data: snapshot.data!.text);
                  default:
                    return Container();
                }
              },
              future: useTermsStore.getUseTerms(),
            )
          ],
        ),
      )),
    );
  }
}
