import 'package:flutter/material.dart';
import 'second_page.dart';

void main() => runApp(const TodoListApp());

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<Map<String, dynamic>> _todoList = [];
  final TextEditingController _textController = TextEditingController();

  void _addTodoItem() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _todoList.add({'text': text, 'done': false});
        _textController.clear();
      });
    }
  }

  void _toggleDone(int index) {
    setState(() {
      _todoList[index]['done'] = !_todoList[index]['done'];
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📋 My To-Do List'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            tooltip: 'Halaman Kedua',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SecondPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Tambahkan tugas...',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.add_circle,
                        color: Colors.teal,
                        size: 28,
                      ),
                      onPressed: _addTodoItem,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  _todoList.isEmpty
                      ? const Center(
                        child: Text(
                          'Belum ada tugas ☁️',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                      : ListView.separated(
                        itemCount: _todoList.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final item = _todoList[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 4,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: IconButton(
                                icon: Icon(
                                  item['done']
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color:
                                      item['done'] ? Colors.teal : Colors.grey,
                                ),
                                onPressed: () => _toggleDone(index),
                              ),
                              title: Text(
                                item['text'],
                                style: TextStyle(
                                  decoration:
                                      item['done']
                                          ? TextDecoration.lineThrough
                                          : null,
                                  color:
                                      item['done'] ? Colors.grey : Colors.black,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _deleteItem(index),
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
