import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home_auth/widgets/custom_button_widget.dart';
import 'package:mercado_justo/app/modules/profile/city_model.dart';
import 'package:mercado_justo/app/modules/profile/profile_controller.dart';
import 'package:mercado_justo/app/modules/profile/state_model.dart';
import 'package:mercado_justo/app/modules/profile/widgets/custom_input_profile.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';
import 'package:mercado_justo/shared/models/user_model.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:mercado_justo/shared/utils/input_formaters.dart';
import 'package:mobx/mobx.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _authController = Modular.get<AuthController>();
  final _profileController = Modular.get<ProfileStore>();

  @override
  void initState() {
    super.initState();
    _profileController.getUser(_authController.user!.id);
    autorun((_) {
      if (_profileController.selectedState != null) {
        _profileController.getCities();
      }
    });
    autorun((_) {
      if (_profileController.userUpdateStatus is AppStateError) {
        var e = _profileController.userUpdateStatus as AppStateError;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.error.message),
          backgroundColor: Colors.redAccent,
        ));
      }
      if (_profileController.userUpdateStatus is AppStateSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Dados atualizados com sucesso!'),
          backgroundColor: Colors.lightBlue,
        ));
      }
    });
    _profileController.getStates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar Meus Dados'),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: Observer(
          builder: (_) {
            if (_profileController.userStatus is AppStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (_profileController.userStatus is AppStateError) {
              return const Center(
                child: Text(
                    'Erro ao buscar dados. Verifique sua conexão com a internet'),
              );
            }
            if (_profileController.userStatus is AppStateSuccess) {
              return Observer(
                builder: (_) {
                  return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              CustomInputProfile(
                                label: 'Seu nome',
                                initialValue: _profileController.inputName,
                                onChange: _profileController.setName,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomInputProfile(
                                label: 'Celular(DDD+número)',
                                inputType: TextInputType.phone,
                                inputFormatters: [
                                  InputFormater.phoneMask(
                                      initialText:
                                          _profileController.inputPhone)
                                ],
                                initialValue: _profileController.inputPhone,
                                onChange: _profileController.setPhone,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomInputProfile(
                                label: 'Seu email',
                                inputType: TextInputType.emailAddress,
                                initialValue: _profileController.inputEmail,
                                onChange: _profileController.setEmail,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Gênero',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Observer(builder: (_) {
                                  return DropdownButtonFormField<String>(
                                    hint: Text('Selecione...'),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      _profileController.selectedGenre = value;
                                    },
                                    onSaved: (value) {
                                      _profileController.selectedGenre = value;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Não pode ser vazio";
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: _profileController.genreList
                                        .map((String val) {
                                      return DropdownMenuItem(
                                        value: val,
                                        child: Text(
                                          val,
                                        ),
                                      );
                                    }).toList(),
                                    value: _profileController.selectedGenre,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  );
                                }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Estado',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Observer(
                                  builder: (_) {
                                    if (_profileController.stateStatus
                                        is AppStateLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (_profileController.stateStatus
                                        is AppStateSuccess) {
                                      return DropdownButtonFormField<String>(
                                        hint: Text('Selecione...'),
                                        isExpanded: true,
                                        onChanged: (value) {
                                          _profileController.selectedState =
                                              value;
                                        },
                                        onSaved: (value) {
                                          _profileController.selectedState =
                                              value;
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return "Não pode ser vazio";
                                          } else {
                                            return null;
                                          }
                                        },
                                        items: _profileController.states
                                            .map(
                                          (element) => element.sigla,
                                        )
                                            .map((String val) {
                                          return DropdownMenuItem(
                                            value: val,
                                            child: Text(
                                              val,
                                            ),
                                          );
                                        }).toList(),
                                        value: _profileController.selectedState,
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                      );
                                    }
                                    return Container(
                                      child: Text('Erro'),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Cidade',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Observer(
                                  builder: (_) {
                                    if (_profileController.cityStatus
                                        is AppStateLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (_profileController.cityStatus
                                        is AppStateSuccess) {
                                      return DropdownButtonFormField<String>(
                                        hint: Text('Selecione...'),
                                        isExpanded: true,
                                        onChanged: (value) {
                                          _profileController.selectedCity =
                                              value;
                                        },
                                        onSaved: (value) {
                                          _profileController.selectedCity =
                                              value;
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return "Não pode ser vazio";
                                          } else {
                                            return null;
                                          }
                                        },
                                        items: _profileController.cities
                                            .map((element) => element.name)
                                            .map((String val) {
                                          return DropdownMenuItem(
                                            value: val,
                                            child: Text(
                                              val,
                                            ),
                                          );
                                        }).toList(),
                                        value: _profileController.selectedCity,
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                      );
                                    }
                                    return Container(
                                      width: double.maxFinite,
                                      padding: EdgeInsets.all(16),
                                      child: const Text(
                                          'Selecione um estado primeiro...'),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomInputProfile(
                                initialValue: _profileController.inputStreet,
                                onChange: _profileController.setStreet,
                                label: 'Rua',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Observer(builder: (_) {
                                return CustomInputProfile(
                                  initialValue:
                                      _profileController.inputNeighborhood,
                                  onChange: _profileController.setNeighborhood,
                                  label: 'Bairro',
                                );
                              }),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomInputProfile(
                                initialValue:
                                    _profileController.inputComplement,
                                onChange: _profileController.setComplement,
                                label: 'Complemento',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomInputProfile(
                                initialValue: _profileController.inputCEP,
                                onChange: _profileController.setCEP,
                                label: 'CEP',
                                inputType: TextInputType.number,
                                inputFormatters: [
                                  InputFormater.cepMask(
                                      initialText: _profileController.inputCEP)
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                child: SizedBox(
                                  width: 300,
                                  height: 50,
                                  child: Observer(builder: (_) {
                                    return ElevatedButton(
                                      child: _profileController.userUpdateStatus
                                              is AppStateLoading
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.lightBlue,
                                              ),
                                            )
                                          : const Text(
                                              'Atualizar',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                      onPressed: _profileController.canUpdate &&
                                              _profileController
                                                      .userUpdateStatus
                                                  is! AppStateLoading
                                          ? () {
                                              _profileController.updateUser();
                                            }
                                          : null,
                                    );
                                  }),
                                ),
                                alignment: Alignment.center,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ]),
                      ));
                },
              );
            }
            return Container();
          },
        ));
  }
}
