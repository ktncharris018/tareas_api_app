import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/routes.dart'; // Archivo donde defines las rutas

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestor de Tareas',
      initialRoute: AppRoutes.HOME, // Ruta inicial de la app
      getPages: AppRoutes.routes, // Definición de rutas en routes.dart
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema de la app (puedes personalizarlo)
      ),
    );
  }
}
