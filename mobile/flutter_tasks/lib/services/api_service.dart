import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';
import '../config.dart';

class ApiService {
  final http.Client client;
  final String baseUrl;

  ApiService({http.Client? client, String? baseUrl})
      : client = client ?? http.Client(),
        baseUrl = baseUrl ?? ApiConfig.baseUrl;

  Future<List<Task>> fetchTasks() async {
    final res = await client.get(Uri.parse('$baseUrl/tasks'));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body) as List;
      return data.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Error cargando tareas: ${res.statusCode}');
    }
  }

  Future<Task> createTask(Task t) async {
    final res = await client.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': t.title}),
    );
    if (res.statusCode == 201 || res.statusCode == 200) {
      return Task.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Error creando tarea: ${res.statusCode}');
    }
  }

  Future<Task> updateTask(Task t) async {
    final id = t.id;
    if (id == null) throw Exception('ID requerido para update');
    final res = await client.put(
      Uri.parse('$baseUrl/tasks/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': t.title, 'isCompleted': t.done}),
    );
    if (res.statusCode == 200) {
      return Task.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Error actualizando tarea: ${res.statusCode}');
    }
  }

  Future<void> deleteTask(int id) async {
    final res = await client.delete(Uri.parse('$baseUrl/tasks/$id'));
    if (res.statusCode == 200 || res.statusCode == 204) {
      return;
    } else {
      throw Exception('Error eliminando tarea: ${res.statusCode}');
    }
  }
}
