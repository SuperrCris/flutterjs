import 'package:flutter/material.dart';
import 'package:flutterjs/adminusuarios.dart';
import 'package:flutterjs/widgets//botshe_renovar.dart';
import 'package:flutterjs/widgets//botshe_eliminar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ventanacliente extends StatefulWidget {
  final int id;
  final String nombre;
  final String fotoRef;
  final DateTime fecha;
  final String tipoMembresia;

  const ventanacliente(
      this.id, this.nombre, this.fotoRef, this.fecha, this.tipoMembresia, {super.key});

  @override
  _ventanaclienteState createState() => _ventanaclienteState();
}

class _ventanaclienteState extends State<ventanacliente> {
  late int id;
  late String nombre;
  late String fotoRef;
  late DateTime fecha;
  late String tipoMembresia;
  String imageUrl = '';

  Future<void> descargarImagen() async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('BodyGym03/fotosclientes/$fotoRef');

    try {
      print("$nombre - $id - $fotoRef");
      String downloadUrl = await ref.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });
    } catch (e) {
      print('Error al descargar la imagen: $e');
    }
  }

  @override
  void initState() {
    id = widget.id;
    nombre = widget.nombre;
    fotoRef = widget.fotoRef;
    fecha = widget.fecha;
    tipoMembresia = widget.tipoMembresia;
    super.initState();
    descargarImagen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionar usuario'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              nombre,
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Hero(
              tag: id,
              child: imageUrl == ""
                  ? const CircularProgressIndicator(
                      color: Colors.grey,
                    )
                  : Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.green, width: 10),
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: imageUrl,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
            ),
          ),
          Center(
            child: Text("Membresia $tipoMembresia",
                style: const TextStyle(fontSize: 20)),
          ),
          Center(
            child:
                Text(crearDescripcion(fecha), style: const TextStyle(fontSize: 10)),
          ),
          const SizedBox(height: 10.0),
          Center(
            child: Expanded(
              child: ElevatedButton(
                onPressed: () {
                  abrirRenovacion();
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(Colors.green),
                ),
                child: Text('Renovar'),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Renovar rapido'),
              ),
              const SizedBox(width: 20.0),
              ElevatedButton(
                onPressed: () {
                  abrirEliminacion(nombre, id);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                ),
                child: const Text('Eliminar usuario'),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  void abrirRenovacion() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ventanaRenovacion(),
        );
      },
    );
  }

  void abrirEliminacion(String nombre, int iD) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ventanaEliminacion(
            nombre: nombre,
            iD: iD,
            contextoAnterior: context,
          ),
        );
      },
    );
  }
}
