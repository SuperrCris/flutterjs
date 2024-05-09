import 'package:flutter/material.dart';
import 'package:flutterjs/servicios/operaciones.dart';

class ventanaAgregarCliente extends StatefulWidget {
  const ventanaAgregarCliente({super.key});

  @override
  _ventanaAgregarClienteState createState() => _ventanaAgregarClienteState();
}

class _ventanaAgregarClienteState extends State<ventanaAgregarCliente> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  TipoMembresia membresia = TipoMembresia.Mensual;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar usuario'),
      ),
      body: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            Container(
              height: MediaQuery.sizeOf(context).width * 0.3,
              width: MediaQuery.sizeOf(context).width * 0.3,
              alignment: AlignmentDirectional.bottomEnd,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 10),
                  image: const DecorationImage(
                      image: AssetImage("recursos/default.png"),
                      fit: BoxFit.cover)),
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.purple,
                ),
                child: const Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.6,
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  campoTextoRegistro(
                      "Nombre", Icons.verified_user_sharp, _nombreController),
                  campoTextoRegistro(
                      "Número de telefono", Icons.phone, _telController),
                  selector(),
                  const Flexible(child: SizedBox()),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          const Icon(Icons.check, color: Colors.white),
                          Text(
                            "Inscribir y pagar \$$precio",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      int tel =
                          int.parse(_telController.text.toString().trim());
                      String nombre = _nombreController.text.trim();
                      String gym = "BodyGym03";
                      print("$gym, $nombre, $membresia, $tel");
                      fb().agregarNuevoCliente(gym, nombre, membresia, tel);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ])),
    );
  }

  List<String> membresias = [
    "Diaria",
    "Semanal",
    "Quincenal",
    "Mensual de estudiante",
    "Mensual",
    "Bimensual",
    "Anual",
  ];
  List<int> precios = [40, 150, 240, 300, 350, 600, 3000];
  String? seleccion = "Mensual";
  int? precio = 350;
  Container selector() {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffdce5e9),
      ),
      child: DropdownButton<String>(
        value: seleccion,
        isExpanded: true,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        onChanged: (newValue) {
          setState(() {
            seleccion = newValue;
            int index = membresias.indexOf(newValue!);
            precio = precios[index];
            membresia = TipoMembresia.values.elementAt(index);
          });
        },
        items: membresias.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              textAlign: TextAlign.center,
            ),
          );
        }).toList(),
      ),
    );
  }
}

Container campoTextoRegistro(
    String texto, IconData icono, TextEditingController controlador) {
  return Container(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color(0xffdce5e9),
    ),
    child: TextField(
      controller: controlador,
      decoration: InputDecoration(
        prefixIcon: Icon(icono),
        border: InputBorder.none,
        labelText: texto,
      ),
    ),
  );
}
