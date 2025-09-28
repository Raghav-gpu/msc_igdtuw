import 'package:flutter/material.dart';

class AddTodoScreen extends StatefulWidget{
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}
class _AddTodoScreenState extends State<AddTodoScreen>{
  final TextEditingController _textFieldController = TextEditingController();

  void _submitTodo(){
    final String text = _textFieldController.text;
    if(text.isNotEmpty){
      Navigator.pop(context,text);
    }
  }

  @override
  void dispose(){
    _textFieldController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Add New To-Do"),),
      body: Padding(padding: const EdgeInsets.all(16),
      child: Column(children: [
        TextField(
          controller: _textFieldController,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: "Enter To-Do title",
            border: OutlineInputBorder(), 
          ),
          onSubmitted: (_) => _submitTodo(),
        ),
        const SizedBox(height: 20,),
        ElevatedButton(
          onPressed: _submitTodo,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
          ),
          child: const Text("Add To-Do", style: TextStyle(fontSize: 18),
        )
      )],)
    )
  );}
}