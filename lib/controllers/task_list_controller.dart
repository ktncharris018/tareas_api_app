import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';
import '../utils/routes.dart';

class TaskListController extends GetxController {
  final ApiService apiService = ApiService();
  var tasks = <TaskModel>[].obs;
  var isLoading = false.obs;

  //var allTasks = <TaskModel>[].obs; // Lista completa de tareas
  var filteredTasks = <TaskModel>[].obs; // Lista filtrada de tareas
  //var searchQuery = ''.obs; 

  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  Future<void> fetchTasks() async {
    isLoading(true);
    try {
      final data = await apiService.getTasks();
      tasks.assignAll(data);
      filteredTasks.assignAll(tasks);
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar las tareas');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await apiService.deleteTask(id);
      tasks.removeWhere((task) => task.id == id);
      filteredTasks.removeWhere((task) => task.id == id);
      Get.snackbar(
          'Éxito',
         'Tarea eliminada correctamente',
          backgroundColor: const Color.fromARGB(255, 106, 231, 113),
          colorText: Colors.black,
          icon: Icon(Icons.check_circle, color: Colors.white),
          snackPosition: SnackPosition.TOP,

       );
    } catch (e) {
      Get.snackbar('Error', 'No se pudo eliminar la tarea: $e');
    }
  }

  void filterTasks(String query) {
  if (query.isEmpty) {
    filteredTasks.assignAll(tasks); // Mostrar todas si no hay búsqueda
  } else {
    filteredTasks.assignAll(
      tasks.where((task) =>
          task.nombre.toLowerCase().contains(query.toLowerCase()) ||
          task.detalle.toLowerCase().contains(query.toLowerCase()))
    );
  }
}


  // rutas para navegar
  void goToCreateTask() {
    Get.toNamed(AppRoutes.CREATE_TASK);
  }

  void goToEditTask(TaskModel task) {
    Get.toNamed(AppRoutes.EDIT_TASK, arguments: task);
  }
}
