import 'dart:convert'; // 👈 Required for jsonDecode
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum ApiCallStatus { idle, loading, success, error }

class APICall extends StatefulWidget {
  const APICall({super.key});

  @override
  State<APICall> createState() => _APICallState();
}

class _APICallState extends State<APICall> {
  ApiCallStatus apiCallStatus = ApiCallStatus.idle;
  late Future<List<dynamic>> apiFuture; // 👈 Future returns list of users

  Future<List<dynamic>> fetchData() async {
    setState(() => apiCallStatus = ApiCallStatus.loading);

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body); // 👈 Parse JSON
        setState(() => apiCallStatus = ApiCallStatus.success);
        return jsonData;
      } else {
        setState(() => apiCallStatus = ApiCallStatus.error);
        return [];
      }
    } catch (e) {
      setState(() => apiCallStatus = ApiCallStatus.error);
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    apiFuture = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Call Example')),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: apiFuture,
          builder: (context, snapshot) {
            if (apiCallStatus == ApiCallStatus.loading) {
              return const CircularProgressIndicator(color: Colors.blue);
            }

            if (apiCallStatus == ApiCallStatus.error) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '❌ Something went wrong!',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        apiFuture = fetchData();
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              );
            }

            if (apiCallStatus == ApiCallStatus.success && snapshot.hasData) {
              final data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final user = data[index];
                  return ListTile(
                    title: Text(user['name']),
                    subtitle: Text(user['email']),
                    leading: CircleAvatar(
                      child: Text(user['name'][0]),
                    ),
                  );
                },
              );
            }

            return const Text('Idle...');
          },
        ),
      ),
    );
  }
}
