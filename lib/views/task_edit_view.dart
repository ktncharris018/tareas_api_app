import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_edit_controller.dart';

class EditTaskView extends StatelessWidget {
  final TaskEditController controller = Get.put(TaskEditController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controller.detailsController,
              decoration: InputDecoration(
                labelText: 'Detalles',
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Obx(() => DropdownButtonFormField<String>(
                  value: controller.selectedStatus.value,
                  items: ['Pendiente', 'Completada', 'En progreso']
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
                  onChanged: (value) => controller.selectedStatus.value = value!,
                  decoration: InputDecoration(
                    labelText: 'Estado',
                    prefixIcon: Icon(Icons.check_circle),
                    border: OutlineInputBorder(),
                  ),
                )),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: controller.updateTask,
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
