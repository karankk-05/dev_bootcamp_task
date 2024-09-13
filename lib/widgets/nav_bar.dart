// nav_page.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../list_all/screen.dart';
import '../live_feed.dart/screen.dart';
import '../notifications/service.dart';

// ignore: must_be_immutable
class NavPage extends StatefulWidget {
  int selectedIndex;

  NavPage({required this.selectedIndex});

  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  // List of pages
  static final List<Widget> _widgetOptions = <Widget>[
    ListAllPage(), // First page
    LiveFeed(), // Second page
  ];

  @override
  void initState() {
    super.initState();
    _requestNotificationPermission();
    LocalNotificationService.initialize(); // Initialize notification service
  }

  // Request notification permission for Android 13 and above
  Future<void> _requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  // Function to trigger random notifications
  void _triggerNotification() {
    final List<String> funnyTitles = [
      'Panic Alert!',
      'Guide to Disaster',
      'Coffee Please!',
      'Midsem Slayed?',
      'MidSem Trauma',
    ];

    final List<String> funnyMessages = [
      'That moment when you realize half the syllabus is in Greek!',
      'Coffee: Our last hope for surviving midsems.',
      'One does not simply finish the syllabus before midnight.',
      'The one time you regret taking this course... again.'
    ];

    // Pick a random funny title and message
    String randomTitle = funnyTitles[Random().nextInt(funnyTitles.length)];
    String randomMessage =
        funnyMessages[Random().nextInt(funnyMessages.length)];

    // Show a test notification with random title and message
    LocalNotificationService.showNotification(
      id: Random()
          .nextInt(1000), // Random ID to prevent notification overwrites
      title: randomTitle,
      body: randomMessage,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // AppBar (removed notification icon from here)
      appBar: null,

      // Floating Action Button to trigger notifications
      floatingActionButton: FloatingActionButton(
        heroTag: "Unique",
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(500),
        ),
        onPressed: _triggerNotification, // Trigger notification when clicked
        child: Icon(
          Icons.notifications,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),

      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.height * 0.08,
        color: Theme.of(context).colorScheme.secondaryContainer,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: widget.selectedIndex == 0
                  ? Icon(
                      Icons.list_alt,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    )
                  : Icon(
                      Icons.list_alt_outlined,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              onPressed: () => _onItemTapped(0),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: widget.selectedIndex == 1
                    ? Icon(
                        Icons.live_tv,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      )
                    : Icon(
                        Icons.live_tv_outlined,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                onPressed: () => _onItemTapped(1),
              ),
            ),
          ],
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(111, 77, 80, 80), // Very Dark Gray
              Color.fromARGB(255, 0, 0, 0),
            ],
          ),
        ),
        // Use the updated widget list
        child: _widgetOptions.elementAt(widget.selectedIndex),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
