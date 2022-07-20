import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/common_questions/presenter/common_questions_store.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';

class CommonQuestionsPage extends StatefulWidget {
  const CommonQuestionsPage({Key? key}) : super(key: key);

  @override
  State<CommonQuestionsPage> createState() => _CommonQuestionsPageState();
}

class _CommonQuestionsPageState
    extends ModularState<CommonQuestionsPage, CommonQuestionsStore> {
  @override
  void initState() {
    super.initState();
    store.getAllCommonQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FAQ'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Observer(builder: (_) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: store.commonQuestionsState is AppStateLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        'Principais Perguntas',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Dúvidas frequentes sobre o uso do Mercado Justo',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(children: [
                                ExpansionTile(
                                  collapsedBackgroundColor:
                                      Color.fromARGB(255, 240, 241, 241),
                                  title: Container(
                                    child: Text(
                                        store.commonQuestions[index].question),
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 16, left: 16, bottom: 16),
                                      child: Text(
                                        store.commonQuestions[index].answer
                                            .replaceAll(r'<p>', '')
                                            .replaceAll(r'</p>', ''),
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                )
                              ]),
                            );
                          },
                          itemCount: store.commonQuestions.length,
                        ),
                      )
                    ],
                  ),
          );
        }));
  }
}
