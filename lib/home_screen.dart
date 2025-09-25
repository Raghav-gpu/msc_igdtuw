import 'package:flutter/material.dart';
import 'package:msc/todo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();


}

class _HomeScreenState extends State<HomeScreen> {

  final List<TodoItem> _todos = [TodoItem(title: 'Complete the todo app',),
  TodoItem(title: 'Write documentation'),
  TodoItem(title: 'Test the app',),
  TodoItem(title: 'Deploy the app'),
  
  ];

  void _addTodoItem () async{
    final newTodotitle = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const AddTodoScreen()),
    );

    if(newTodotitle != null && newTodotitle.trim().isNotEmpty){
      setState(() {
        _todos.add(TodoItem(title: newTodotitle));
      });
    }
  }

  // mark the tasks done or not done
  void _toggleTodoItem(int index){
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
  }


  void _deleteTodoItem(int index){
    setState(() {
      _todos.removeAt(index);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do App",),),
      body: _todos.isEmpty ? const Center(child: Text("To Do list is Empty", style: TextStyle(fontSize: 18 , color: Colors.grey), ) ,
      ) : ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index){
          final todo = _todos[index];
          return Dismissible(key: Key(todo.title + index.toString()), 
          onDismissed: (direction){
            _deleteTodoItem(index);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted "${todo.title}"')));
          }
          background: Container(color: Colors.red,),
          ,child: Card(ListTile(leading: Checkbox(value: todo.isDone, onChanged: (bool? value){
            _toggleTodoItem(index);
          }),
          title: Text(todo.title),
          
          ),),
          )
        }
      )
    )
    
  }

} 