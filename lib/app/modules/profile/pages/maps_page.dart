import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mercado_justo/shared/controllers/position_store.dart';
import 'package:mercado_justo/shared/utils/utils.dart';

class MapsPosition extends StatefulWidget {
  @override
  State<MapsPosition> createState() => MapsPositionState();
}

class MapsPositionState extends State<MapsPosition> {
  final storePosition = Modular.get<PositionStore>();

  Future getCurrentPosition() async {
    storePosition.position = await Utils.determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: storePosition.position != null
          ? MapsEditLocation()
          : FutureBuilder(
              future: getCurrentPosition(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Não conseguimos obter sua localização'),
                    );
                  }
                  return MapsEditLocation();
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
    );
  }
}

class MapsEditLocation extends StatefulWidget {
  MapsEditLocation({Key? key}) : super(key: key);

  @override
  State<MapsEditLocation> createState() => _MapsEditLocationState();
}

class _MapsEditLocationState extends State<MapsEditLocation> {
  Completer<GoogleMapController> _controller = Completer();

  Position? position;

  final storePosition = Modular.get<PositionStore>();

  void _updatePosition(CameraPosition _position) {
    setState(() {
      position = Position(
          longitude: _position.target.longitude,
          latitude: _position.target.latitude,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              zoom: 15,
              target: LatLng(
                storePosition.position!.latitude,
                storePosition.position!.longitude,
              )),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onCameraMove: (_position) => _updatePosition(_position),
        ),
        Center(
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Color.fromARGB(255, 15, 129, 187), width: 3)),
          ),
        ),
        Container(
          color: Color.fromARGB(255, 240, 241, 241),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: const Text(
            'Deixe a sua localização dentro do círculo e clique em ok!',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          child: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.7,
            child: ElevatedButton(
              child: const Text('SALVAR'),
              onPressed: position != null
                  ? () {
                      if (position != null) {
                        storePosition.position = position!;
                      }
                      Modular.to.pop();
                    }
                  : null,
            ),
          ),
          bottom: 30,
          left: MediaQuery.of(context).size.width * 0.15,
        )
      ],
    );
  }
}
