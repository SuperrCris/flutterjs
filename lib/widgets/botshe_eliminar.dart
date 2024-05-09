import 'package:flutter/material.dart';
import 'package:flutterjs/servicios/operaciones.dart';

class ventanaEliminacion extends StatefulWidget {
  final String nombre;
  final int iD;
  final dynamic contextoAnterior;
  const ventanaEliminacion(
      {super.key,
      required this.nombre,
      required this.iD,
      required this.contextoAnterior});

  @override
  State<StatefulWidget> createState() {
    return _Nc();
  }
}

class _Nc extends State<ventanaEliminacion> {
  late String nombre;
  late int iD;
  late dynamic contextoAnterior;
  @override
  void initState() {
    nombre = widget.nombre;
    iD = widget.iD;
    contextoAnterior = widget.contextoAnterior;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(seconds: 1),
        decoration: const BoxDecoration(),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "¿Deseas eliminar a $nombre?",
                style: const TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(height: 50),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  fb().eliminarUsuario("BodyGym3", iD);

                  Navigator.pop(context);
                  Navigator.pop(contextoAnterior);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 58, 183, 68)),
                child: const Text("Eliminar",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'figtree',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    )),
              ),
            ),
          ]),
        ));
  }
}
