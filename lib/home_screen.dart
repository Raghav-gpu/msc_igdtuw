import 'package:flutter/material.dart';
import 'package:msc/add_todo_screen.dart';
import 'todo_item.dart';
//import 'add_todo_screen.dart';

// HomeScreen is a stateful widget because its content (the to-do list) will change.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final List<TodoItem> _todos = [
    TodoItem(title: 'Complete the todo app'),
    TodoItem(title: 'Write documentation'),
    TodoItem(title: 'Test the app'),
    TodoItem(title: 'Deploy the app'),
  ];

 
  void _addTodoItem() async {
    
    final newTodoTitle = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const AddTodoScreen()),
    );

    
    if (newTodoTitle != null && newTodoTitle.trim().isNotEmpty) {
      setState(() {
        _todos.add(TodoItem(title: newTodoTitle));
      });
    }
  }

  void _toggleTodoItem(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
  }

  
  void _deleteTodoItem(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do App"),
      ),
      
      body: _todos.isEmpty
          
          ? const Center(
              child: Text(
              "To Do list is Empty",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ))
          
          : Center(
            
            child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  final todo = _todos[index];
                
                  return Dismissible(
                    key: Key(todo.title + index.toString()), 
                    onDismissed: (direction) {
                      _deleteTodoItem(index);
                      // Show a snackbar to confirm deletion.
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Deleted "${todo.title}"')));
                    },
                   
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                   
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: ListTile(
                        
                        leading: Checkbox(
                          value: todo.isDone,
                          onChanged: (bool? value) {
                            _toggleTodoItem(index);
                          },
                        ),
                       
                        title: Text(
                          todo.title,
                        
                          style: TextStyle(
                            decoration: todo.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: todo.isDone ? Colors.grey : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ),
    
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodoItem,
        tooltip: 'Add To-Do Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}

