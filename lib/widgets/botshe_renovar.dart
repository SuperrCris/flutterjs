import 'package:flutter/material.dart';
import 'package:flutterjs/servicios/operaciones.dart';

class Nuevacomida extends StatelessWidget {
  const Nuevacomida({super.key});
  @override
  Widget build(BuildContext context) {
    return ventanaRenovacion();
  }
}

class ventanaRenovacion extends StatefulWidget {
  const ventanaRenovacion({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Nc();
  }
}

class _Nc extends State<ventanaRenovacion> {
  List<String> membresias = [
    "Diaria",
    "Semanal",
    "Quincenal",
    "Mensual de estudiante",
    "Mensual",
    "Bimensual",
    "Anual",
  ];
  fb? renovacion;
  List<int> precios = [40, 150, 240, 300, 350, 600, 3000];
  String? seleccion = "Mensual";
  int? precio = 350;

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
            const Center(
              child: Text(
                "Pagar membresia",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(height: 50),
            selector(),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  fb().renovar("BodyGym3", 1, "Chris Bumstead",
                      TipoMembresia.Estudiante);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 58, 183, 68)),
                child: Text("Pagar ${'\$'}$precio",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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

  Container selector() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, left: 30, right: 30),
      child: DropdownButton<String>(
        value: seleccion,
        isExpanded: true,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Color.fromARGB(255, 58, 183, 68)),
        onChanged: (newValue) {
          setState(() {
            seleccion = newValue;
            precio = precios[membresias.indexOf(newValue!)];
          });
        },
        items: membresias.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'figtree',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
          );
        }).toList(),
      ),
    );
  }
}
