import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'history_menu.dart';
import 'item_menu.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        centerTitle: true,
        title: Text(
          'craFtNRent',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: const <Widget>[
            ItemMenu(),
            HistoryMenu(),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.blueGrey,
          buttonBackgroundColor: Colors.black,
          color: Colors.black87,
          height: 65,
          items: const <Widget>[
            Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.history_outlined,
              size: 30,
              color: Colors.white,
            )
          ],
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut);
          },
        ),
    );
  }
}