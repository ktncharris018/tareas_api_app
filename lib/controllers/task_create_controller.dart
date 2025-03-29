import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';
import 'task_list_controller.dart';

class TaskCreateController extends GetxController {
  final ApiService apiService = ApiService();

  // Controladores para los campos de texto
  final TextEditingController nameController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  
  // Estado seleccionado
  var selectedStatus = 'Pendiente'.obs;

  // Método para validar y agregar la tarea
  Future<void> validateAndSave() async {
    if (nameController.text.isEmpty || detailsController.text.isEmpty) {
      Get.snackbar('Error', 'Todos los campos son obligatorios');
      return;
    }

    final task = TaskModel(
      nombre: nameController.text,  // 👈 Coincide con el modelo
      detalle: detailsController.text, // 👈 Coincide con el modelo
      estado: selectedStatus.value, // 👈 Coincide con el modelo
    );

    await addTask(task);
  }

  // Método para agregar la tarea a la API
  Future<void> addTask(TaskModel task) async {
    try {
      final newTask = await apiService.createTask(task);
      if (newTask.id != 0) {
        Get.find<TaskListController>().fetchTasks(); // Refrescar lista
        Get.back(); // Cerrar la vista de agregar tarea
        Get.snackbar('Éxito', 'Tarea creada correctamente');
      }else{
        Get.snackbar('Nota', 'Se necesita id para crear la tarea');
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo crear la tarea: $e');
    }
  }
}
