import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';
import 'task_list_controller.dart';

class TaskCreateController extends GetxController {
  final ApiService apiService = ApiService();


  final TextEditingController nameController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  
  
  var selectedStatus = 'pendiente'.obs;

  
  Future<void> validateAndSave() async {
    if (nameController.text.isEmpty || detailsController.text.isEmpty) {
      Get.snackbar(
        'Error', 
        'Todos los campos son obligatorios',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        icon: Icon(Icons.error, color: Colors.white),
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final task = TaskModel(
      nombre: nameController.text,  
      detalle: detailsController.text, 
      estado: selectedStatus.value, 
    );

    await addTask(task);
  }


  Future<void> addTask(TaskModel task) async {
    try {
      final newTask = await apiService.createTask(task);
      if (newTask.id != 0) {
        Get.find<TaskListController>().fetchTasks(); // Refrescar lista
        Get.back(); // Cerrar la vista de agregar tarea
        Get.snackbar(
          'Éxito', 
          'Tarea creada correctamente',
          backgroundColor: const Color.fromARGB(255, 106, 231, 113),
          colorText: Colors.black,
          icon: Icon(Icons.check_circle, color: Colors.white),
          snackPosition: SnackPosition.TOP,
);
      }else{
        Get.snackbar('Nota', 'Se necesita id para crear la tarea');
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo crear la tarea: $e');
    }
  }
}
