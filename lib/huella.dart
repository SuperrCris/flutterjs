import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterjs/opciones.dart';

class huella extends StatelessWidget {
  const huella({super.key});
  @override
  Widget build(BuildContext context) {
    print("Entrando a Huella");
    return MaterialApp(
      // Application name
      title: 'Flutter Hello World',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        // useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      // A widget which will be started on application startup
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Opciones()));
                      },
                      icon: const Icon(Icons.arrow_left),
                      label: const Text("Regresar"))
                ],
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).height * 0.60,
                height: MediaQuery.sizeOf(context).height * 0.60,
                child: const FittedBox(
                  fit: BoxFit.cover,
                  child: Icon(Icons.fingerprint_outlined, color: Colors.blue),
                ),
              ),
              GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Column(
                      children: [
                        Icon(Icons.search, color: Colors.white),
                        Text(
                          "Buscar por teclado",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {

                      _mostrarDatePicker(context);
                    ;
                  }),
            ],
          ),
        ),
      ),
    );
  }
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

Future<void> _mostrarDatePicker(BuildContext context) async {
  try {
    final DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (fechaSeleccionada != null) {
      print('Fecha seleccionada: $fechaSeleccionada');
      // Realiza las acciones que necesites con la fecha seleccionada
    }
  } catch (e) {
    print(e);
  }
}

ListTile elemento(String textoTitulo, String textoSubtitulo) {
  return ListTile(
    title: Text(textoTitulo),
    leading: const Icon(Icons.account_box),
    subtitle: Text(textoSubtitulo),
  );
}
