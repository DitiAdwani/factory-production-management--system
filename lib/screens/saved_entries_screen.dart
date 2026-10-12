import 'package:flutter/material.dart';
import '../../services/entry_storage.dart';
import '../../services/csv_service.dart';
import '../../data/saved_entries.dart';
import 'saved_entry_details_screen.dart';

class SavedEntriesScreen extends StatefulWidget {
  const SavedEntriesScreen({super.key});

  @override
  State<SavedEntriesScreen> createState() => _SavedEntriesScreenState();
}

class _SavedEntriesScreenState extends State<SavedEntriesScreen> {
  late Future<List<SavedEntry>> futureEntries;

  @override
  void initState() {
    super.initState();
    futureEntries = EntryStorage.loadEntries();
  }

  Future<void> refresh() async {
    setState(() {
      futureEntries = EntryStorage.loadEntries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Entries"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              final entries = await EntryStorage.loadEntries();

              CsvService.exportAllEntries(entries);

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("CSV Downloaded")));
            },
          ),
        ],
      ),

      body: FutureBuilder<List<SavedEntry>>(
        future: futureEntries,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final entries = snapshot.data!;

          if (entries.isEmpty) {
            return const Center(
              child: Text(
                "No saved entries yet",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: refresh,
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SavedEntryDetailsScreen(entry: entry),
                        ),
                      );
                    },

                    leading: const Icon(Icons.factory),

                    title: Text(
                      "${entry.machineType} - ${entry.machine}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Operator: ${entry.operator}"),
                        Text("Date: ${entry.date}"),
                        Text("Shift: ${entry.shift}"),
                        Text("Quantity: ${entry.quantity}"),
                      ],
                    ),

                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        final updated = List<SavedEntry>.from(entries)
                          ..removeAt(index);

                        await EntryStorage.saveEntries(updated);

                        refresh();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Entry deleted")),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
