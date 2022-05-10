import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home_auth/widgets/custom_button_widget.dart';
import 'package:mercado_justo/app/modules/login/pages/code_by_email_page.dart';
import 'package:mercado_justo/shared/widgets/bottomsheets.dart';
import 'package:mercado_justo/shared/widgets/dialogs.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'Selecione ou Adicione uma lista',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
            flex: 8,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.max,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtom(
                        label: 'Compras do mês',
                        subTitle: '54 Produtos',
                        onPressed: () {},
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      OptionsListButton()
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtom(
                        label: 'Despensa',
                        subTitle: '32 Produtos',
                        onPressed: () {},
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      OptionsListButton()
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtom(
                        label: 'Churrasco de final de semana',
                        subTitle: '19 Produtos',
                        onPressed: () {},
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      OptionsListButton()
                    ],
                  ),
                ],
              ),
            )),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              CustomButtom(
                label: 'Criar nova lista',
                onPressed: () {
                  Dialogs().addNewList(context);
                },
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget OptionsListButton() {
    return InkWell(
      onTap: () => CustomBottonSheets.optionsList(context),
      child: Container(
        height: 50,
        width: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.lightBlue),
        child: const Center(
            child: Icon(
          Icons.more_vert,
          color: Colors.white,
          size: 38,
        )),
      ),
    );
  }
}
