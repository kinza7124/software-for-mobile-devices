import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp UI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF075E54)),
      ),
      home: const WhatsAppHome(),
    );
  }
}

class WhatsAppHome extends StatefulWidget {
  const WhatsAppHome({super.key});

  @override
  State<WhatsAppHome> createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  // Data structure matching all chat items in the screenshot
  final List<Map<String, String>> chatList = const [
    {
      'name': 'FLUTTER Batch23',
      'message': '+91 90807 69068 added +91 47689...',
      'time': '6:27 PM',
      'type': 'flutter',
    },
    {'name': 'Ben', 'message': 'Hi bruh', 'time': '6:13 PM', 'type': 'person'},
    {
      'name': 'Betty Manager',
      'message': 'Mail it when its done',
      'time': '5:56 PM',
      'type': 'person',
    },
    {
      'name': 'Mom',
      'message': 'Had coffee???',
      'time': '5:35 PM',
      'type': 'default',
    },
    {
      'name': 'Johny Bro',
      'message': 'Wb the meeting?',
      'time': '10:07 AM',
      'type': 'person',
    },
    {
      'name': 'Flutter Devs',
      'message': 'Johny: Good mrng guys!',
      'time': '9:11 AM',
      'type': 'flutter_devs',
    },
    {
      'name': 'Sam Bombay',
      'message': 'Meeting with BOSS tomorrow!',
      'time': 'Yesterday',
      'type': 'person',
    },
    {
      'name': 'Stacy',
      'message': 'Call me asap',
      'time': 'Tuesday',
      'type': 'person',
    },
    {
      'name': 'Andrew',
      'message': 'Okay its fine',
      'time': 'Tuesday',
      'type': 'person',
    },
    {'name': 'Sara', 'message': 'Hmmm', 'time': 'Monday', 'type': 'default'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, initialIndex: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Helper widget to render avatar icons matching the reference image
  Widget _getAvatar(String type) {
    if (type == 'flutter') {
      return const CircleAvatar(
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.android, color: Colors.white),
      );
    } else if (type == 'flutter_devs') {
      return CircleAvatar(
        backgroundColor: Colors.white,
        child: ClipOval(
          child: Transform.scale(
            scale: 1.12,
            child: Image.asset(
              'lib/icons/Screenshot 2026-09-06 003618.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else if (type == 'default') {
      return CircleAvatar(
        backgroundColor: Colors.grey.shade400,
        child: const Icon(Icons.person, color: Colors.white),
      );
    }
    return CircleAvatar(
      backgroundColor: Colors.grey.shade300,
      child: const Icon(Icons.person, color: Colors.black54),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        title: const Text(
          'WhatsApp',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: const [
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 16),
          Icon(Icons.more_vert, color: Colors.white),
          SizedBox(width: 10),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3.0,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(icon: Icon(Icons.camera_alt, size: 22)),
            Tab(text: 'CHATS'),
            Tab(text: 'STATUS'),
            Tab(text: 'CALLS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const Center(child: Text('Camera View')),

          // CHATS TAB
          ListView.builder(
            itemCount: chatList.length + 1, // +1 for the Archived row
            itemBuilder: (context, index) {
              if (index == 0) {
                // Archived Header Row
                return const ListTile(
                  leading: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.archive_outlined, color: Colors.grey),
                  ),
                  title: Text(
                    'Archived',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  trailing: Text(
                    '7',
                    style: TextStyle(
                      color: Color(0xFF075E54),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                );
              }

              final item = chatList[index - 1];
              return ListTile(
                leading: _getAvatar(item['type']!),
                title: Text(
                  item['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  item['message']!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                trailing: Text(
                  item['time']!,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              );
            },
          ),

          const Center(child: Text('Status View')),
          const Center(child: Text('Calls View')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF25D366),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {},
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}
