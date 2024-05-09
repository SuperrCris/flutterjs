
import 'package:cloud_firestore/cloud_firestore.dart';


enum TipoMembresia {
  Diaria,
  Semanal,
  Quincenal,
  Estudiante,
  Mensual,
  Bimensual,
  Anual,
}

class fb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void renovar(
    String gym,
    int id,
    String nombre,
    TipoMembresia membresia,
  ) async {
    try {
      DateTime fecha;
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('BodyGym3')
          .doc('Clientes')
          .collection("ID")
          .doc(id as String)
          .get();

      List<dynamic>? array = snapshot.data()!['fechaPago'];
      print(array.toString());
      fecha = DateTime(array![2] as int, array[1] as int, array[0] as int);
      int dias = fecha.difference(DateTime.now()).inDays;
      print("Le quedan $dias dias");

      DocumentReference clienteRef = _firestore
          .collection('BodyGym3')
          .doc('Clientes')
          .collection("ID")
          .doc('1');

      DateTime nuevaFecha = retornarDias(membresia);
      List<int> fechaint = [nuevaFecha.day, nuevaFecha.month, nuevaFecha.year];
      await clienteRef.set(
        {'fechaPago': fechaint},
        SetOptions(merge: true),
      );

      print('Fechas de pago actualizadas correctamente.');
    } catch (e) {
      print('Error al obtener el array desde Firestore: $e');
    }
  }

  void agregarNuevoCliente(
    final gym,
    String nombre,
    TipoMembresia membresia,
    int numeroTel,
  ) async {
    int nuevoID;
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('BodyGym3').doc('Clientes').get();
      nuevoID = snapshot.data()!["siguienteID"] + 1;

      DocumentReference clienteRef =
          _firestore.collection('BodyGym3').doc('Clientes');
      await clienteRef.set(
        {'siguienteID': nuevoID},
        SetOptions(merge: true),
      );

      DateTime fechaPago = retornarDias(membresia);

      Map<String, dynamic> datosCliente = {
        'nombre': nombre,
        'fechaPago': {fechaPago.day, fechaPago.month, fechaPago.year},
        'telefono': numeroTel,
        'tipoMembresia': membresia.name,
      };
      _firestore
          .collection('BodyGym3')
          .doc('Clientes')
          .collection('ID')
          .doc(nuevoID.toString())
          .set(
            datosCliente,
            SetOptions(merge: true),
          );

      await clienteRef.set(
        {'siguienteID': nuevoID},
        SetOptions(merge: true),
      );
      RealizarReporte(nuevoID, nombre, "Membresia",
          retornarPrecios(membresia).toDouble(), membresia, DateTime.now());
    } catch (e) {
      print(e);
    }
  }

  void eliminarUsuario(String gym, int id) {
    _firestore
        .collection(gym)
        .doc('Clientes')
        .collection('ID')
        .doc(id.toString())
        .delete();
  }

  DateTime retornarDias(TipoMembresia memb) {
    int dias = 0;
    switch (memb) {
      case TipoMembresia.Diaria:
        dias = 1;
        break;
      case TipoMembresia.Semanal:
        dias = 7;
        break;
      case TipoMembresia.Quincenal:
        dias = 15;
        break;
      case TipoMembresia.Estudiante:
        dias = 30;
        break;
      case TipoMembresia.Mensual:
        dias = 30;
        break;
      case TipoMembresia.Bimensual:
        dias = 60;
        break;
      case TipoMembresia.Anual:
        dias = 365;
        break;
    }
    return DateTime.now().add(Duration(days: dias));
  }

  int retornarPrecios(TipoMembresia memb) {
    int precio = 0;
    switch (memb) {
      case TipoMembresia.Diaria:
        precio = 40;
        break;
      case TipoMembresia.Semanal:
        precio = 150;
        break;
      case TipoMembresia.Quincenal:
        precio = 240;
        break;
      case TipoMembresia.Estudiante:
        precio = 300;
        break;
      case TipoMembresia.Mensual:
        precio = 350;
        break;
      case TipoMembresia.Bimensual:
        precio = 600;
        break;
      case TipoMembresia.Anual:
        precio = 3000;
        break;
    }
    return precio;
  }

  void RealizarReporte(
    int? id,
    String? nombre,
    String concepto,
    double monto,
    TipoMembresia membresia,
    DateTime fecha,
  ) {
    Map<String, dynamic> datosReporte = {
      'id': id ?? 0,
      'nombre': nombre == null ? " " : nombre,
      'monto': monto,
      'compra': concepto,
      'tipoMembresia': membresia.name,
      'fecha':{DateTime.now().day,DateTime.now().month,DateTime.now().year}
    };
    _firestore
        .collection('BodyGym3')
        .doc('Reportes')
        .collection('${fecha.day}-${fecha.month}-${fecha.year}')
        .add(datosReporte);
  }
}
