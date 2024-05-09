import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterjs/opciones.dart';

class Reportes extends StatefulWidget {
  const Reportes({
    super.key,
  });

  @override
  State<Reportes> createState() => ReporteEstado();
}

class ReporteEstado extends State<Reportes> {
  DateTime fechaIni = DateTime.now();
  DateTime fechaFin = DateTime.now();
  int total = 0;
  int recuento = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
              "Reportes",
              style: TextStyle(fontSize: 30),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              height: MediaQuery.sizeOf(context).height * 0.6,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.33,
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
                            child: GestureDetector(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
          colors: [ Color.fromARGB(255, 228, 95, 95),Color(0xffec008c),],
          stops: [0, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      ,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: const Column(
                                    children: [
                                      Icon(Icons.calendar_month,
                                          color: Colors.white),
                                      Text(
                                        "Seleccionar periodo",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () async {
                                  _mostrarDatePicker(context);
                                }),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.33,
                            child: GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
          colors: [Color.fromARGB(255, 71, 206, 255), Color.fromARGB(255, 32, 177, 162)],
          stops: [0, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
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
                          ),
                      const SizedBox(
                            height: 10,
                          ),
                            SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.33,
                            child: GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
          colors: [Color.fromARGB(255, 60, 218, 86), Color(0xff20b131)],
          stops: [0, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      ,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Column(
                                  children: [
                                    Icon(Icons.receipt_long_outlined, color: Colors.white),
                                    Text(
                                      "Exportar a .xlsx",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  listaClientes(context, fechaIni, fechaFin),
                ],
              ),
            ),
             textoTal(
                      key: textoTal.llave,
                    ),
          ],
        ),
      )),
    );
  }

  Future<void> _mostrarDatePicker(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Theme(
                  data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF8CE7F1),
            colorScheme: ColorScheme.light(primary: const Color.fromARGB(255, 34, 78, 233)),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary
            ),
                  ),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).width * 0.7,
                width: MediaQuery.sizeOf(context).width * 0.7,
                child: SfDateRangePicker(
                  selectionMode: DateRangePickerSelectionMode.range,
                  minDate: DateTime(2020, 1, 1),
                  maxDate: DateTime(2025, 12, 31),
                  confirmText: "Buscar",
                  cancelText: "Cancelar",
                  showActionButtons: true,
                  onSubmit: (args) {
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  onCancel: () {
                    Navigator.of(context).pop();
                  },
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                    fechaIni = args.value.startDate;
                    print(fechaIni);
                    fechaFin = args.value.endDate;
                    print(fechaFin);
                  },
                ),
              ),
            ),
          );
        });
  }

  Container listaClientes(
      BuildContext context, DateTime fechaIni, DateTime fechaFin) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: MediaQuery.sizeOf(context).width * 0.63,
      height: MediaQuery.sizeOf(context).height * 0.6,
      child: FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
        future: obtenerDatosEnIntervalo(fechaIni, fechaFin),
        builder: (context,
            AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
                snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Future.delayed(Duration(microseconds: 1),
                () => textoTal.llave.currentState!.actualizar(total, recuento, fechaIni, fechaFin));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                children: [
                  const Center(
                      child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: CircularProgressIndicator())),
                  Text(
                      "Generando reporte de ventas realizadas entre el ${fechaIni.day}/${fechaIni.month}/${fechaIni.year} y ${fechaFin.day}/${fechaFin.month}/${fechaFin.year}")
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, i) {
                if (i == 0) {
                  total = 0;
                  recuento = 0;
                }

                QueryDocumentSnapshot<Map<String, dynamic>>? datos;
                datos = snapshot.data?.elementAt(i);

                List<dynamic>? listPag = datos!['fecha'];
                String fecha = "${listPag![0]}/${listPag[1]}/${listPag[2]}";
                int monto = datos['monto'];
                total += monto;
                recuento ++;
                return elementoReporte(
                  datos['id'].toString(),
                  datos['nombre'].toString(),
                  fecha,
                  monto.toString(),
                  datos['tipoMembresia'].toString(),
                );
              },
            );
          }
        },
      ),
    );
  }
}

void _mostrarFechaSeleccionada(DateTime fechaSeleccionada) {
  print('Fecha seleccionada: $fechaSeleccionada');
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

Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
    obtenerDatosEnIntervalo(DateTime fechaInicio, DateTime fechaFin) async {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> documentos = [];
  DateTime fF = fechaFin.add(Duration(days: 1));
  try {
    print("Buscando");
    for (DateTime fecha = fechaInicio;
        fecha.isBefore(fF);
        fecha = fecha.add(const Duration(days: 1))) {
      print("Revisando fecha: $fecha");
      String fechaStr = "${fecha.day}-${fecha.month}-${fecha.year}";

      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('BodyGym3')
          .doc('Reportes')
          .collection(fechaStr)
          .get();

      for (var elemento in snapshot.docs) {
        print("Elemento hallado en $fechaStr: ${elemento.toString()}");
        documentos.add(elemento);
      }
    }
  } catch (e) {
    print(e);
  }
  return documentos;
}

Container elementoReporte(
  id,
  nombre,
  fecha,
  monto,
  concepto,
) {
  return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black12,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
            child: Text(
              id,
              textAlign: TextAlign.center,
            ),
            width: 30),
        SizedBox(child: Text(nombre), width: 100),
        SizedBox(
          child: Text(fecha),
          width: 100,
        ),
        SizedBox(
          child: Text("\$$monto"),
          width: 100,
        ),
        SizedBox(
          child: Text(concepto),
          width: 200,
        ),
      ]));
}

class textoTal extends StatefulWidget {
  static GlobalKey<_textoTalState> llave = GlobalKey<_textoTalState>();
  textoTal({Key? key}) : super(key: key);
  @override
  _textoTalState createState() => _textoTalState();
}

class _textoTalState extends State<textoTal> {
  int t = 0;
  int r = 0;
  DateTime ini = DateTime.now();
  late DateTime fin;
  String fechaIniString = "";
  String fechaFinString = "";
  // Método para actualizar el contador
  void actualizar(int total, int recuento,DateTime fechaInicial, DateTime fechaFin) {
    setState(() {
      t = total;
      r = recuento;
      ini = fechaInicial;
      fin = fechaFin;

      fechaIniString = "${ini.day}/${ini.month}/${ini.year}";
      fechaFinString = fin == ini ? "":" - ${fin.day}/${fin.month}/${fin.year}";

    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      
          Container(
            padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.black12,
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Periodo:',
              ),
              Text(
                '$fechaIniString $fechaFinString',
              ),
            ],
          ),
        ),
          
         Container(
          padding: EdgeInsets.all(10),
           margin: EdgeInsets.all(10),
           decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.black12,
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total en ventas:',
              ),
              Text(
                '\$$t',
              ),
            ])
        ),
        
         Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
           decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.black12,
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Numero de ventas:',
              ),
              Text(
                '$r',
              ),
            ],
          ),
        ),
        ]
      ),
    );
  }
}
