import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutterjs/servicios/firebase_options.dart';
import 'package:flutterjs/opciones.dart';
import 'package:flutterjs/servicios/autenticacion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
  } catch (e) {
    e;
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _Estado();
}

class _Estado extends State<App> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width / 2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('recursos/gym.png'),
                  fit: BoxFit.cover,
                ),
                color: Colors.blue,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width / 2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height / 4,
                      width: MediaQuery.sizeOf(context).width / 4,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.supervisor_account,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: campoTexto(
                            "Email", Icons.mail, _emailController, false)),
                    SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: campoTexto("Contraseña", Icons.password,
                            _passwordController, true)),
                    GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        width: MediaQuery.sizeOf(context).width * .4,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Acceder",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      onTap: () async {
                        String email = _emailController.text.trim();
                        String password = _passwordController.text.trim();
                        User? user = await _authService.signInWithEmailPassword(
                          email,
                          password,
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Opciones()));
                                            },
                    ),
                    TextButton(
                        onPressed: () async {},
                        child: const Text("¿Olvidaste tu contraseña?")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {

    super.initState();
            WidgetsBinding.instance
        .addPostFrameCallback((_) => verificarLogin());
  }

  void verificarLogin() async {
    print(_authService.verificarSesion());
    if (_authService.verificarSesion() == true) {
      print("El usuario ya inicio sesion");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Opciones()));
    }
  }
}

Container campoTexto(String texto, IconData icono,
    TextEditingController controlador, bool contra) {
  return Container(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color(0xffdce5e9),
    ),
    child: TextField(
      controller: controlador,
      obscureText: contra,
      decoration: InputDecoration(
        prefixIcon: Icon(icono),
        border: InputBorder.none,
        labelText: texto,
      ),
    ),
  );
}

void toast() async {
  Fluttertoast.showToast(
    msg:
        "Credenciales incorrectas", // Duración del Toast (Toast.LENGTH_SHORT o Toast.LENGTH_LONG)
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity
        .BOTTOM, // Ubicación del Toast en la pantalla (TOP, CENTER, BOTTOM)
    timeInSecForIosWeb: 1, // Duración específica para iOS (en segundos)
    backgroundColor: Colors.grey, // Color de fondo del Toast
    textColor: Colors.white, // Color del texto del Toast
    fontSize: 16.0, // Tamaño del texto del Toast
  );
}
