import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../services/prefs_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notes = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {
    setState(() {
      isLoading = true;
    });

    final data = await DatabaseService().getNotes();   // sesuai materi

    // Simpan timestamp
    final now = DateTime.now().toString();
    await PrefsService.setLastRefresh(now);

    setState(() {
      notes = data;
      isLoading = false;
    });

    // Notifikasi “Data From Cache”
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Data from cache")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => loadNotes(),
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              await PrefsService.clearCache();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Cache cleared")),
              );
              setState(() {});
            },
          )
        ],
      ),

      body: Column(
        children: [
          // timestamp tampil di UI
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "Last Refresh: ${PrefsService.getLastRefresh()}",
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),

          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : notes.isEmpty
                    ? const Center(child: Text("No notes"))
                    : ListView.builder(
                        itemCount: notes.length,
                        itemBuilder: (context, i) {
                          final n = notes[i];
                          return ListTile(
                            title: Text(n.title),
                            subtitle: Text(n.content),
                          );
                        },
                      ),
          )
        ],
      ),
    );
  }
}
