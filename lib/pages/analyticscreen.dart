import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:parkingslot/pages/bottom_nav_bar.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  List<dynamic> data = [];
  final int totalSlots = 60;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://192.168.198.46:5000/api/statistik'));
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: const Text("Analytics"),
      ),
      body: data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                int belumTerisi = data[index]['Belum terisi'];
                int occSlot = totalSlots - belumTerisi;
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('Belum terisi: $belumTerisi'),
                    subtitle: Text('Waktu: ${data[index]['Waktu']}'),
                    trailing: Text(
                        'Terisi: $occSlot'), // Menampilkan sisa slot parkir
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 1),
    );
  }
}
