import 'package:flutter/material.dart';
import 'package:flutterjs/adminusuarios.dart';
import 'package:flutterjs/huella.dart';
import 'package:flutterjs/main.dart';
import 'package:flutterjs/reportes.dart';
import 'package:flutterjs/servicios/autenticacion.dart';

class Opciones extends StatelessWidget {
  const Opciones({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Hello World',

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
          height: MediaQuery.sizeOf(context).height,

          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
          colors: [Color(0xff1488cc), Color(0xff2b32b2)],
          stops: [0, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      
                ),
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    const SizedBox(
                      height: 50,
                      width: 50,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Icon(Icons.supervised_user_circle,color: Colors.white),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Cristian Escalante",style: TextStyle(color: Colors.white),),
                        TextButton(
                          onPressed: () {
                            AuthService().signOut();
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()));
                          },
                          child: const Text("Cerrar sesion", style: TextStyle(color: Colors.red),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: GestureDetector(
                          child: botonActividad(
                            "Administrar usuarios",
                            const Icon(Icons.list, color: Colors.white),
                            Colors.green,
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Admin()))),
                    ),
                    Flexible(
                      child: GestureDetector(
                        child: botonActividad(
                          "Chequeo",
                          const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                          Colors.blue,
                        ),
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => huella())),
                      ),
                    ),
                    Flexible(
                        child: GestureDetector(
                      child: botonActividad(
                        "Reportes",
                        const Icon(Icons.report, color: Colors.white),
                        Colors.orange,
                      ),
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Reportes())),
                    )),
                  ],
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Container campoTexto(String texto) {
  return Container(
    margin: const EdgeInsets.all(10),
    child: TextField(
      decoration: InputDecoration(
        labelText: texto,
      ),
    ),
  );
}

Container botonActividad(String texto, Icon icono, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.contain,
            child: icono,
          ),
        ),
        Text(
          texto,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
