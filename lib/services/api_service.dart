import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../models/task_model.dart';

class ApiService {
  //final String baseUrl = 'https://nk0blh78-8000.use2.devtunnels.ms';
  //final String baseUrl = 'https://x8ki-letl-twmt.n7.xano.io/api:wka2okkc';
  final String baseUrl = 'https://x8ki-letl-twmt.n7.xano.io/api:UIdqgh6f';
  final Logger logger = Logger();

  // Obtener todas las tareas
  Future<List<TaskModel>> getTasks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tareas'));

      logger.i('GET $baseUrl/tareas/ - Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => TaskModel.fromJson(json)).toList();
      } else {
        logger.e('Error ${response.statusCode}: ${response.body}');
        throw Exception('Error al obtener tareas: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Exception: $e');
      throw Exception('Error al obtener tareas');
    }
  }

  // Obtener una tarea por ID
  Future<TaskModel> getTaskById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tareas/$id'));

      logger.i('GET $baseUrl/tareas/$id - Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        return TaskModel.fromJson(json.decode(response.body));
      } else {
        logger.e('Error ${response.statusCode}: ${response.body}');
        throw Exception('Error al obtener tarea: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Exception: $e');
      throw Exception('Error al obtener tarea');
    }
  }

  // Crear una nueva tarea
  Future<TaskModel> createTask(TaskModel task) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tareas'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(task.toJson()),
      );

      logger.i('POST $baseUrl/tareas - Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        return TaskModel.fromJson(json.decode(response.body));
      } else {
        logger.e('Error ${response.statusCode}: ${response.body}');
        throw Exception('Error al crear tarea: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Exception: $e');
      throw Exception('Error al crear tarea');
    }
  }

  // Actualizar una tarea
  Future<TaskModel> updateTask(int id, TaskModel task) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/tareas/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(task.toJson()),
      );

      logger.i('PUT $baseUrl/tareas/$id - Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        return TaskModel.fromJson(json.decode(response.body));
      } else {
        logger.e('Error ${response.statusCode}: ${response.body}');
        throw Exception('Error al actualizar tarea: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Exception: $e');
      throw Exception('Error al actualizar tarea');
    }
  }

  // Eliminar una tarea
  Future<void> deleteTask(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/tareas/$id'));

      logger.i('DELETE $baseUrl/tareas/$id - Status: ${response.statusCode}');

      if (response.statusCode != 200) {
        logger.e('Error ${response.statusCode}: ${response.body}');
        throw Exception('Error al eliminar tarea: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Exception: $e');
      throw Exception('Error al eliminar tarea');
    }
  }
}
