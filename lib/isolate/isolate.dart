import 'package:flutter/material.dart';
import 'isolate_api_caller.dart'; // import the class file

class IsolateApiDemo extends StatefulWidget {
  const IsolateApiDemo({super.key});

  @override
  State<IsolateApiDemo> createState() => _IsolateApiDemoState();
}

class _IsolateApiDemoState extends State<IsolateApiDemo> {
  bool _loading = false;
  List<dynamic> _posts = [];

  Future<void> _fetchData() async {
    setState(() => _loading = true);

    final apiCaller = IsolateApiCaller();
    final result = await apiCaller.fetch(
      'https://jsonplaceholder.typicode.com/posts',
      params: {'_limit': '10'}, // optional parameter
    );

    setState(() => _loading = false);

    if (result['status'] == 'success') {
      setState(() => _posts = result['data']);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${result['message']}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Isolate API Caller")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _fetchData,
              child: const Text("Fetch Posts"),
            ),
            const SizedBox(height: 16),
            if (_loading) const CircularProgressIndicator(),
            Expanded(
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  return Card(
                    child: ListTile(
                      title: Text(post['title']),
                      subtitle: Text(post['body']),
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
