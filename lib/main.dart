import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class TodoItem {
  final int id;
  final String text;
  bool isDone;

  TodoItem({required this.id, required this.text, this.isDone = false});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<TodoItem> _todos = [TodoItem(id: 1, text: 'hai', isDone: true)];
  final TextEditingController _searchController = TextEditingController();

  List<TodoItem> get _filteredTodos {
    final query = _searchController.text.toLowerCase();
    return _todos.where((todo) => todo.text.toLowerCase().contains(query)).toList();
  }

  void _addTodo(String text) {
    setState(() {
      _todos.insert(0, TodoItem(id: DateTime.now().millisecondsSinceEpoch, text: text));
    });
  }

  void _showAddTodoDialog() {
    final TextEditingController newTaskController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Tugas'),
        content: TextField(
          controller: newTaskController,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Tulis tugas di sini...'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final text = newTaskController.text.trim();
              if (text.isNotEmpty) {
                _addTodo(text);
              }
              Navigator.pop(context);
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }

  void _toggleTodo(int id) {
    setState(() {
      final todo = _todos.firstWhere((item) => item.id == id);
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteTodo(int id) {
    setState(() {
      _todos.removeWhere((item) => item.id == id);
    });
  }

  void _goToSecondPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('📋 To-Do List'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
        child: Column(
          children: [
            // Search bar + tombol halaman kedua
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Cari tugas...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _goToSecondPage,
                  icon: const Icon(Icons.book, color: Colors.deepPurple),
                  tooltip: 'Halaman Kedua',
                ),
              ],
            ),
            const SizedBox(height: 16),
            // List tugas
            Expanded(
              child: ListView.builder(
                itemCount: _filteredTodos.length,
                itemBuilder: (context, index) {
                  final todo = _filteredTodos[index];
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(
                          todo.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: todo.isDone ? Colors.green : Colors.grey,
                        ),
                        onPressed: () => _toggleTodo(todo.id),
                      ),
                      title: Text(
                        todo.text,
                        style: TextStyle(
                          decoration: todo.isDone ? TextDecoration.lineThrough : null,
                          color: todo.isDone ? Colors.grey : Colors.black,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteTodo(todo.id),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Tombol + di kanan bawah
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📘 Halaman Kedua')),
      body: const Center(
        child: Text('Ini adalah halaman kedua.'),
      ),
    );
  }
}
