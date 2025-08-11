import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../screens/add_edit_task_screen.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile({required this.task, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TaskProvider>(context, listen: false);
    return Dismissible(
      key: Key('${task.id ?? task.title}_${task.done}'),
      direction: DismissDirection.endToStart,
      background: Container(
          color: Colors.red, alignment: Alignment.centerRight, padding: EdgeInsets.only(right: 20), child: Icon(Icons.delete, color: Colors.white)),
      confirmDismiss: (_) async {
        final ok = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Eliminar'),
            content: Text('¿Eliminar tarea?'),
            actions: [
              TextButton(child: Text('No'), onPressed: () => Navigator.pop(ctx, false)),
              TextButton(child: Text('Sí'), onPressed: () => Navigator.pop(ctx, true)),
            ],
          ),
        );
        return ok ?? false;
      },
      onDismissed: (_) async {
        try {
          await prov.deleteTask(task);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tarea eliminada')));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al eliminar')));
        }
      },
      child: ListTile(
        title: Text(task.title, style: TextStyle(decoration: task.done ? TextDecoration.lineThrough : null)),
        leading: Checkbox(
          value: task.done,
          onChanged: (_) async {
            try {
              await prov.toggleComplete(task);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al actualizar')));
            }
          },
        ),
        onTap: () async {
          // según spec: un solo toque marca/desmarca como completada
          try {
            await prov.toggleComplete(task);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al actualizar')));
          }
        },
        trailing: IconButton(icon: Icon(Icons.edit), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddEditTaskScreen(task: task)))),
      ),
    );
  }
}
