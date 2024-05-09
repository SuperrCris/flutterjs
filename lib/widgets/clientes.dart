import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterjs/ventanacliente.dart';

enum Estado { registrado, distinto, desconocido, noregistrado, espera }

class Elecliente extends StatefulWidget {
  final int id;
  final String nombre;
  final String fotoRef;
  final String descripcion;
  final DateTime fechaPago;
  final String tipoMembresia;
  const Elecliente(
      {super.key,
      required this.id,
      required this.nombre,
      required this.fotoRef,
      required this.descripcion,
      required this.fechaPago,
      required this.tipoMembresia})
      : super();

  @override
  State createState() => DiarioEstado();
}

class DiarioEstado extends State<Elecliente> {
  late int id;
  late String nombre;
  late String fotoRef;
  late String descripcion;
  late DateTime fechaPago;
  late String tipoMembresia;

  String imageUrl = '';
  Future<void> downloadImage() async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('BodyGym03/fotosclientes/$fotoRef');

    try {
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
    descripcion = widget.descripcion;
    fechaPago = widget.fechaPago;
    tipoMembresia = widget.tipoMembresia;
    super.initState();
    downloadImage();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Yendo a la ventana de $nombre - $tipoMembresia");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ventanacliente(
                    id, nombre, fotoRef, fechaPago, tipoMembresia)));
      },
      child: Container(
        margin: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 5,
        ),
        height: 120,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Hero(tag: id, child: marca(imageUrl)),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nombre, style: const TextStyle(fontSize: 28)),
                        SizedBox(
                          height: 45,
                          child: Text(
                            descripcion,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black45),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Container marca(String url) {
  String ur = url;
  Container contenedor;
  print(ur);
  contenedor = Container(
    margin: const EdgeInsets.only(right: 10),
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [Color(0xff49ec04), Color(0xff1cc705)],
        stops: [0.3, 0.75],
        center: Alignment.center,
      ),
    ),
    child: Stack(children: [
      SizedBox(
        height: 70,
        width: 70,
        child: ur == ""
            ? const CircularProgressIndicator(
                color: Colors.grey,
              )
            : Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: ur,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error){
                        print("$error");
                       return const Icon(Icons.person);}
                        ),
                ),
              ),
      ),
    ]),
  );
  return contenedor;
}
