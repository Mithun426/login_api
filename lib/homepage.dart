import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListData extends StatefulWidget {
  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final response = await http.get('https://dummyjson.com/' as Uri);
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    }
  }

  void handleEditClick(dynamic item) {
    // Navigate to the next page with the clicked item data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextPage(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Data'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return ListTile(
            title: Text(item['title']),
            subtitle: Text(item['subtitle']),
            trailing: ElevatedButton(
              onPressed: () => handleEditClick(item),
              child: Text('Edit'),
            ),
          );
        },
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  final dynamic item;

  NextPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Item Title: ${item['title']}'),
            Text('Item Subtitle: ${item['subtitle']}'),
            // Display the rest of the item data
          ],
        ),
      ),
    );
  }
}
