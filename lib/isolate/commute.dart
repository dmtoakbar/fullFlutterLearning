import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> parseData(String responseBody) async {
  final parsed = jsonDecode(responseBody);
  return parsed;
}

Future<List<dynamic>> fetchData() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return compute(parseData, response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

class CommuteApiScreen extends StatefulWidget {
  const CommuteApiScreen({super.key});

  @override
  State<CommuteApiScreen> createState() => _CommuteApiScreenState();
}

class _CommuteApiScreenState extends State<CommuteApiScreen> {
  late Future<List<dynamic>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API with Isolate')),
      body: FutureBuilder<List<dynamic>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index]['title']),
                  subtitle: Text(posts[index]['body']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
