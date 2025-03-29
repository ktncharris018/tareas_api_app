import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';
import 'task_list_controller.dart';

class TaskEditController extends GetxController {
  final ApiService apiService = ApiService();
  late TextEditingController nameController;
  late TextEditingController detailsController;
  var selectedStatus = ''.obs;
  late int taskId; 

  @override
  void onInit() {
    super.onInit();
    TaskModel task = Get.arguments as TaskModel;
    taskId = task.id!;
    nameController = TextEditingController(text: task.nombre);
    detailsController = TextEditingController(text: task.detalle);
    selectedStatus.value = task.estado;
  }

  Future<void> updateTask() async {
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

    final updatedTask = TaskModel(
      id: taskId,
      nombre: nameController.text,
      detalle: detailsController.text,
      estado: selectedStatus.value,
    );

    try {
      await apiService.updateTask(taskId, updatedTask);
      Get.find<TaskListController>().fetchTasks(); // Actualizar la lista
      Get.back(); // Cerrar vista de edición
      Get.snackbar(
        'Éxito', 
        'Tarea actualizada correctamente',
          backgroundColor: const Color.fromARGB(255, 106, 231, 113),
          colorText: Colors.black,
          icon: Icon(Icons.check_circle, color: Colors.white),
          snackPosition: SnackPosition.TOP,
);
    } catch (e) {
      Get.snackbar('Error', 'No se pudo actualizar la tarea: $e');
    }
  }
}
