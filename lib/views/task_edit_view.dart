import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_edit_controller.dart';

class EditTaskView extends StatelessWidget {
  final TaskEditController controller = Get.put(TaskEditController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Tarea'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(controller.nameController, 'Nombre', Icons.title),
            const SizedBox(height: 16),
            _buildTextField(controller.detailsController, 'Detalles', Icons.description, maxLines: 3),
            const SizedBox(height: 16),
            Obx(
              () => _buildDropdown(
                'Estado', 
                Icons.check_circle, 
                controller.selectedStatus.value, 
                (value) => controller.selectedStatus.value = value!,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.updateTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen, 
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4, // Sombra suave
                ),
                icon: const Icon(Icons.save, color: Colors.black), 
                label: const Text(
                  'Guardar Cambios',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {int maxLines = 1}) {
    return Container(
      decoration: _boxDecoration(),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: _inputDecoration(label, icon),
      ),
    );
  }

  
  Widget _buildDropdown(String label, IconData icon, String value, Function(String?) onChanged) {
    return Container(
      decoration: _boxDecoration(),
      child: DropdownButtonFormField<String>(
        value: value,
        items: ['pendiente', 'completado', 'en progreso']
            .map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status.capitalizeFirst!),
                ))
            .toList(),
        onChanged: onChanged,
        decoration: _inputDecoration(label, icon),
      ),
    );
  }

  
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blueAccent),
      border: InputBorder.none, // Sin bordes visibles
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
    );
  }

  
  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1), 
          blurRadius: 8, 
          offset: const Offset(2, 4),
        ),
      ],
    );
  }
}
