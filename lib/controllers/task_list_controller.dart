import 'package:get/get.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';
import '../utils/routes.dart';

class TaskListController extends GetxController {
  final ApiService apiService = ApiService();
  var tasks = <TaskModel>[].obs;
  var isLoading = false.obs;

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
      Get.snackbar('Éxito', 'Tarea eliminada correctamente');
    } catch (e) {
      Get.snackbar('Error', 'No se pudo eliminar la tarea: $e');
    }
  }

  // 🚀 Ahora usamos rutas para navegar
  void goToCreateTask() {
    Get.toNamed(AppRoutes.CREATE_TASK);
  }

  void goToEditTask(TaskModel task) {
    Get.toNamed(AppRoutes.EDIT_TASK, arguments: task);
  }
}
