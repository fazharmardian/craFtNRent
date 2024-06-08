import 'package:flutter/material.dart';
import '/screens/activity/activity_navigation.dart';
import '/screens/login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'information/about.dart';
import 'information/profil.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map<String, dynamic>? userData;
  String? userId;

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

  Future<void> fetchUserData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.252.17/craftnrent/ApiV1/user/get_profil.php?id=$userId'));

      if (response.statusCode == 200) {
        setState(() {
          userData = jsonDecode(response.body)[0];
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _initializePage() async {
    await _loadUserId();
    await fetchUserData();
  }

  @override
  void initState() {
    super.initState();
    _initializePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.only(left: 16),
            child: IconButton(
              icon: Icon(
                Icons.donut_small,
                size: 24,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'CraftNRent',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      drawer: customDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 20), 
                child: Column(
                  children: [
                    SizedBox(
                        height: AppBar()
                            .preferredSize
                            .height), 
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 10),
                        child: Text(
                          "Welcome To craFtNRent",
                          style: const TextStyle(
                              letterSpacing: 2,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 36),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 32),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(13, 71, 140, 0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: Image(
                                image: AssetImage(
                                    'images/books.png')),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "CraftNRent",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "CraftNRent is a platform where users can rent and lend craft supplies and tools. Whether you're a hobbyist or a professional, you can find a wide range of items for your crafting needs.",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 32),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(13, 71, 140, 0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: Image(
                                image: AssetImage(
                                    'images/books.png')),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Rent Item",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Let's rent an item! Discover amazing tools and supplies for your crafting projects.",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context, MaterialPageRoute(builder: (context) => ActivityPage())
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(300,40),
                              backgroundColor:
                                  const Color.fromRGBO(0, 48, 143, 0.5), 
                              shadowColor: Colors.black54,
                              foregroundColor: Colors.white, 
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              textStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8), 
                              ),
                            ),
                            child: Text(
                              'Rent Now!',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget circleIcon() {
    return Icon(
      Icons.circle,
      color: Colors.white.withOpacity(.5),
      size: 10,
    );
  }

  Widget circleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        circleIcon(),
        circleIcon(),
      ],
    );
  }

  Widget customDrawer() {
    return Drawer(
      clipBehavior: Clip.none,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue.shade900,
              Colors.black
            ]
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Stack(
                children: [
                  Image.asset(
                    'images/drawer-bg.jpg',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData?['username'] ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          userData?['telephone'] ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard, color: Colors.black87),
              title: Text('Dashboard', style: TextStyle(color: Colors.black87)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.book, color: Colors.black87),
              title: Text('Renting', style: TextStyle(color: Colors.black87)),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: ((context) => ActivityPage()))
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.black87),
              title: Text('Profile', style: TextStyle(color: Colors.black87)),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: ((context) => ProfilPage()))
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.black87),
              title: Text('About', style: TextStyle(color: Colors.black87)),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: ((context) => AboutPage()))
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_circle_left,
                  color: const Color.fromRGBO(244, 67, 54, 0.5)),
              title: Text('Logout',
                  style:
                      TextStyle(color: const Color.fromRGBO(244, 67, 54, 0.5))),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: ((context) => LoginPage()))
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
