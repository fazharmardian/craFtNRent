import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/lending.dart';
import '../../model/returning.dart';
import 'return_detail.dart';

class HistoryMenu extends StatefulWidget {
  const HistoryMenu({super.key});

  @override
  State<HistoryMenu> createState() => _HistoryMenuState();
}

class _HistoryMenuState extends State<HistoryMenu> {
  String? userId;
  Future<List<Lending>>? futureLendings;
  Future<List<Returning>>? futureReturning;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
      if (userId != null) {
        futureLendings = fetchLendings(userId!);
        futureReturning = fetchReturn(userId!);
      }
    });
  }

  Future<List<Lending>> fetchLendings(String userId) async {
    final response = await http.get(Uri.parse('http://192.168.252.17/craftnrent/ApiV1/user/get_returned.php?id_user=$userId'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Lending.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load current lendings');
    }
  }

  Future<List<Returning>> fetchReturn(String userId) async {
  final response = await http.get(Uri.parse('http://192.168.252.17/craftnrent/ApiV1/user/get_lent.php?id_user=$userId'));

  if (response.statusCode == 200) {
    print('Response Body: ${response.body}');
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map<Returning>((data) => Returning.fromJson(data)).toList();
  } else {
    print('Failed to load returned items with status code: ${response.statusCode}');
    throw Exception('Failed to load returned items');
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900,
              Colors.black,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 65),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Currently Renting",
                style: TextStyle(
                  color: Colors.white.withOpacity(.4),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
  height: 200,
  child: FutureBuilder<List<Returning>>(
    future: futureReturning,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        print('Error: ${snapshot.error}'); 
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text('No current rental items found'));
      } else {
        print('Returning Items: ${snapshot.data}'); 
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final item = snapshot.data![index];
            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReturnDetail(item: item),
                    ),
                  );
                },
                child: Card(
                  elevation: 20,
                  color: Colors.white.withOpacity(.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.itemName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item.itemBrand,
                          style: TextStyle(
                            color: Colors.white.withOpacity(.5),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Must Return at: ${item.returnDate}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(.5),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }
    },
  ),
),

            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Your Few Last Renting",
                style: TextStyle(
                  color: Colors.white.withOpacity(.4),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: FutureBuilder<List<Lending>>(
                future: futureLendings,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No rental items found'));
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: InkWell(
                            onTap: () {},
                            child: Card(
                              elevation: 20,
                              color: Colors.white.withOpacity(.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.itemName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      item.itemBrand,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(.5),
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Rent at: ${item.returnDate}',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(.5),
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          'Return at: ${item.rentDate}',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(.5),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
