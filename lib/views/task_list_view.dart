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
        title: Text('Lista de Tareas', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar tarea...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (value) => controller.filterTasks(value),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (controller.filteredTasks.isEmpty) {
                return Center(child: Text('No hay tareas disponibles'));
              }
              return ListView.builder(
                itemCount: controller.filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = controller.filteredTasks[index];
                  return TaskCard(task: task, controller: controller);
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToCreateTask,
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blueAccent,
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
      case 'en progreso':
        return Colors.amber;
      case 'completado':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(task.nombre, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(task.detalle),
        trailing: IconButton(
          icon: Icon(Icons.close, color: Colors.red),
          //icon: Icon(LucideIcons.x, color: Colors.red),
          onPressed: () {
            if (task.id != null) {
              controller.deleteTask(task.id!);
            } else {
              Get.snackbar(
                'Error',
                'No se puede eliminar una tarea sin ID',
                backgroundColor: Colors.redAccent,
                colorText: Colors.white,
                icon: Icon(Icons.error, color: Colors.white),
                snackPosition: SnackPosition.BOTTOM,
              );
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
