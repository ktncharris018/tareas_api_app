import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/routes.dart'; 

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
      getPages: AppRoutes.routes, 
      theme: ThemeData(
        primarySwatch: Colors.blue, 
      ),
    );
  }
}
