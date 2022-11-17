import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/profile/city_model.dart';
import 'package:mercado_justo/app/modules/profile/profile_controller.dart';
import 'package:mercado_justo/app/modules/profile/state_model.dart';
import 'package:mercado_justo/app/modules/profile/widgets/custom_input_profile.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _authController = Modular.get<AuthController>();
  final _profileController = Modular.get<ProfileStore>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // TextEditingController _phoneController = TextEditingController();
  String? _selectedValue;
  List<String> listOfValue = ['Masculino', 'Feminino', 'Outros'];
  @override
  void initState() {
    super.initState();
    _nameController.text = _authController.user!.name;
    _phoneController.text = _authController.user!.phone;
    _emailController.text = _authController.user!.email;
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
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 40,
              ),
              CustomInputProfile(
                label: 'Seu nome',
                controller: _nameController,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInputProfile(
                label: 'Celular(DDD+número)',
                controller: _phoneController,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInputProfile(
                label: 'Seu email',
                controller: _emailController,
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
                child: DropdownButtonFormField<String>(
                  hint: Text('Selecione...'),
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Não pode ser vazio";
                    } else {
                      return null;
                    }
                  },
                  items: listOfValue.map((String val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(
                        val,
                      ),
                    );
                  }).toList(),
                  value: _selectedValue,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
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
                    if (_profileController.stateStatus is AppStateLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (_profileController.stateStatus
                        is AppStateSuccess) {
                      return DropdownButtonFormField<StateModel>(
                        hint: Text('Selecione...'),
                        isExpanded: true,
                        onChanged: (value) {
                          _profileController.selectedState = value;
                          _profileController.getCities();
                        },
                        onSaved: (value) {
                          _profileController.selectedState = value;
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Não pode ser vazio";
                          } else {
                            return null;
                          }
                        },
                        items: _profileController.states.map((StateModel val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val.sigla,
                            ),
                          );
                        }).toList(),
                        value: _profileController.selectedState,
                        decoration: InputDecoration(border: InputBorder.none),
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
                    if (_profileController.cityStatus is AppStateLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (_profileController.cityStatus
                        is AppStateSuccess) {
                      return DropdownButtonFormField<CityModel>(
                        hint: Text('Selecione...'),
                        isExpanded: true,
                        onChanged: (value) {
                          _profileController.selectedCity = value;
                        },
                        onSaved: (value) {
                          _profileController.selectedCity = value;
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Não pode ser vazio";
                          } else {
                            return null;
                          }
                        },
                        items: _profileController.cities.map((CityModel val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val.name,
                            ),
                          );
                        }).toList(),
                        value: _profileController.selectedCity,
                        decoration: InputDecoration(border: InputBorder.none),
                      );
                    }
                    return Container();
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ]),
          )),
    );
  }
}
