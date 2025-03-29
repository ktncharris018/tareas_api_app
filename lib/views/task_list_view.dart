import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_list_controller.dart';
import '../models/task_model.dart';

class TaskListView extends StatelessWidget {
  final TaskListController controller = Get.put(TaskListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.tasks.isEmpty) {
          return Center(child: Text('No hay tareas disponibles'));
        }
        return ListView.builder(
          itemCount: controller.tasks.length,
          itemBuilder: (context, index) {
            final task = controller.tasks[index];
            return TaskCard(task: task, controller: controller);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToCreateTask,
        child: Icon(Icons.add),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final TaskListController controller;

  TaskCard({required this.task, required this.controller});

  Color getStatusColor(String status) {
    switch (status) {
      case 'pendiente':
        return Colors.orange;
      case 'completada':
        return Colors.green;
      case 'en_progreso':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(task.nombre, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(task.detalle),
        trailing: IconButton(
          icon: Icon(Icons.close, color: Colors.red),
          onPressed: () {
            if (task.id != null) {
              controller.deleteTask(task.id!); // Forzamos a no nulo con `!`
            } else {
              Get.snackbar('Error', 'No se puede eliminar una tarea sin ID');
            }
          },
        ),
        onTap: () => controller.goToEditTask(task),
        leading: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: getStatusColor(task.estado),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            task.estado.toUpperCase(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
