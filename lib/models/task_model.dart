class TaskModel {
  int? id;
  String nombre;
  String detalle;
  String estado;

  TaskModel({
    this.id,
    required this.nombre,
    required this.detalle,
    required this.estado,
  });

  // Método para convertir JSON a TaskModel
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      detalle: json['detalle'] ?? '',
      estado: json['estado'] ?? 'pendiente',
    );
  }

  // Método para convertir TaskModel a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'detalle': detalle,
      'estado': estado,
    };
  }
}
