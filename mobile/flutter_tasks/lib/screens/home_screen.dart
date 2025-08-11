import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';
import 'add_edit_task_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Mis Tareas')),
      body: prov.isLoading
          ? Center(child: CircularProgressIndicator())
          : prov.error != null
              ? Center(child: Text('Error: ${prov.error}'))
              : RefreshIndicator(
                  onRefresh: prov.loadTasks,
                  child: prov.tasks.isEmpty
                      ? ListView(
                          children: [SizedBox(height: 200), Center(child: Text('No hay tareas'))],
                        )
                      : ListView.builder(
                          itemCount: prov.tasks.length,
                          itemBuilder: (context, index) => TaskTile(task: prov.tasks[index]),
                        ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddEditTaskScreen())),
        child: Icon(Icons.add),
      ),
    );
  }
}
