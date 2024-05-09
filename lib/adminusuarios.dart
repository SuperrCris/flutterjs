
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterjs/opciones.dart';
import 'package:flutterjs/widgets/agregarCliente.dart';
import 'package:flutterjs/widgets/clientes.dart';

class Admin extends StatefulWidget {
  const Admin({
    super.key,
  });

  @override
  State<Admin> createState() => AdminEstado();
}

class AdminEstado extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Opciones()));
                  },
                  icon: const Icon(Icons.arrow_left),
                  label: const Text("Regresar"))
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Administrar usuarios",
            style: TextStyle(fontSize: 30),
          ),
          campoTexto("Buscar usuario", const Icon(Icons.search)),
          Container(
            margin: const EdgeInsets.all(10),
            height: MediaQuery.sizeOf(context).height * 0.6,
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: Column(
                      children: [
                        SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.33,
                            child: boton("Añadir usuario", Icons.add,
                                Colors.green, context)),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.33,
                            child: boton("Eliminar usuario", Icons.remove,
                                Colors.red, context)),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.33,
                          child: GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: const Column(
                                children: [
                                  Icon(Icons.replay, color: Colors.white),
                                  Text(
                                    "Recargar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              setState(() {});
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                listaClientes(context),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

Container listaClientes(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    decoration: const BoxDecoration(
      color: Colors.black12,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    width: MediaQuery.sizeOf(context).width * 0.7,
    child: FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
      future: obtenerDatos(),
      builder: (context,
          AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
              snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  Center(
            child: Column(
              children:[ const SizedBox(
                
                  width: 60, height: 60, child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CircularProgressIndicator())),
                    Text("Buscando usuarios")
            ],),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, i) {
              int id = int.parse(snapshot.data![i].id);
              QueryDocumentSnapshot<Map<String, dynamic>>? datos;
              datos = snapshot.data?.elementAt(i);
              List<dynamic>? listPag = datos!['fechaPago'];
              DateTime fechaPag = DateTime(
                  listPag![2] as int, listPag[1] as int, listPag[0] as int);
              String descripcion = crearDescripcion(fechaPag);
              return Elecliente(
                id: id,
                nombre: datos['nombre'],
                descripcion: descripcion,
                fotoRef: "$id.png",
                fechaPago: fechaPag,
                tipoMembresia: datos['tipoMembresia'],
              );
            },
          );
        }
      },
    ),
  );
}

String crearDescripcion(DateTime fecha) {
  String desc;
  if (fecha.difference(DateTime.now()).inDays > 0) {
    desc = "Vence el";
  } else {
    desc = "Venció el";
  }

  desc += " ${fecha.day} / ${fecha.month} / ${fecha.year}";
  return desc;
}

Container campoTexto(String texto, Icon icono) {
  return Container(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color(0xffa3c6d6),
    ),
    child: TextField(
      decoration: InputDecoration(
        prefixIcon: icono,
        border: InputBorder.none,
        labelText: texto,
      ),
    ),
  );
}

GestureDetector boton(
    String texto, IconData icono, Color color, BuildContext contexto) {
  return GestureDetector(
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: color, borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Icon(icono, color: Colors.white),
          Text(
            texto,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
    onTap: () {
      Navigator.push(contexto,
          MaterialPageRoute(builder: (context) => ventanaAgregarCliente()));
    },
  );
}

/*GestureDetector elemento(int id, String textoTitulo, String textoSubtitulo,
    AssetImage imagen, BuildContext con) {
  return GestureDetector(
      child: ListTile(
        title: Text(textoTitulo),
        leading: Hero(
            tag: id,
            child: CircleAvatar(
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.green,
                      width: 1,
                    ),
                    image: DecorationImage(image: imagen)),
              ),
            )),
        subtitle: Text(textoSubtitulo),
      ),
      onTap: () => Navigator.push(
          con,
          MaterialPageRoute(
              builder: (context) => ventanacliente(id, textoTitulo, imagen))));
}*/

Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> obtenerDatos() async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('BodyGym3')
      .doc('Clientes')
      .collection('ID')
      .get();

  List<QueryDocumentSnapshot<Map<String, dynamic>>> documentos = [];
  for (var elemento in snapshot.docs) {
    print("elemento hallado$elemento");
    documentos.add(elemento);
  }

  return documentos;
}
