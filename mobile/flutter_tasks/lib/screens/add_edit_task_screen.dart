import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task? task;
  const AddEditTaskScreen({this.task, Key? key}) : super(key: key);

  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  String? description;
  bool saving = false;

  @override
  void initState() {
    super.initState();
    title = widget.task?.title ?? '';
    
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => saving = true);
    final prov = Provider.of<TaskProvider>(context, listen: false);
    try {
      if (widget.task == null) {
        await prov.addTask(Task(title: title));
      } else {
        final updated = Task(id: widget.task!.id, title: title, done: widget.task!.done);
        await prov.updateTask(updated);
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? 'Nueva tarea' : 'Editar tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              initialValue: title,
              onSaved: (v) => title = v!.trim(),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'El título es obligatorio' : null,
              decoration: InputDecoration(labelText: 'Título'),
            ),    
            SizedBox(height: 20),
            saving ? CircularProgressIndicator() : ElevatedButton(onPressed: _save, child: Text('Guardar')),
          ]),
        ),
      ),
    );
  }
}
