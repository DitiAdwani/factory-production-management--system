import 'package:flutter/material.dart';
import '../../data/dropdown_data.dart';
import '../../services/preferences_service.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController operatorController = TextEditingController();
  final TextEditingController vmcController = TextEditingController();
  final TextEditingController finningController = TextEditingController();
  final TextEditingController punchingController = TextEditingController();
  final TextEditingController bendingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    operators = await PreferencesService.loadList("operators");
    print("Loaded operators = $operators");
    vmcOperations = await PreferencesService.loadList("vmc_operations");
    finningTubeSizes = await PreferencesService.loadList("finning_sizes");
    punchingModelNumbers = await PreferencesService.loadList("punching_models");
    bendingPlateThicknesses = await PreferencesService.loadList(
      "bending_thickness",
    );

    if (operators.isEmpty) {
      operators = ["Operator 1"];
    }

    if (vmcOperations.isEmpty) {
      vmcOperations = ["A", "B", "C"];
    }

    if (finningTubeSizes.isEmpty) {
      finningTubeSizes = ["A", "B", "C"];
    }

    if (punchingModelNumbers.isEmpty) {
      punchingModelNumbers = ["A", "B", "C"];
    }

    if (bendingPlateThicknesses.isEmpty) {
      bendingPlateThicknesses = ["A", "B", "C"];
    }

    setState(() {});
  }

  Future<void> addItem(
    List<String> list,
    TextEditingController controller,
    String key,
  ) async {
    if (controller.text.isNotEmpty) {
      setState(() {
        list.add(controller.text);
      });

      await PreferencesService.saveList(key, list);

      // 👇 Add these two lines
      final saved = await PreferencesService.loadList(key);
      print("Saved $key = $saved");

      controller.clear();
    }
  }

  Future<void> editItem(
    List<String> list,
    int index,
    TextEditingController controller,
    String title,
    String key,
  ) async {
    controller.text = list[index];

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Edit $title"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: title,
              border: const OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.clear();
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    list[index] = controller.text;
                  });

                  await PreferencesService.saveList(key, list);
                }

                controller.clear();
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteItem(List<String> list, int index, String key) async {
    setState(() {
      list.removeAt(index);
    });

    await PreferencesService.saveList(key, list);
  }

  Widget buildSection(
    String title,
    List<String> list,
    TextEditingController controller,
    String key,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 15),

        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: "New $title",
            border: const OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 10),

        ElevatedButton(
          onPressed: () async {
            await addItem(list, controller, key);
          },
          child: Text("Add $title"),
        ),

        const SizedBox(height: 20),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(list[index]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        editItem(list, index, controller, title, key);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        deleteItem(list, index, key);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 40),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Panel")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildSection(
              "Operators",
              operators,
              operatorController,
              "operators",
            ),

            buildSection(
              "VMC Operations",
              vmcOperations,
              vmcController,
              "vmc_operations",
            ),

            buildSection(
              "Finning Tube Sizes",
              finningTubeSizes,
              finningController,
              "finning_sizes",
            ),

            buildSection(
              "Punching Model Numbers",
              punchingModelNumbers,
              punchingController,
              "punching_models",
            ),

            buildSection(
              "Bending Plate Thickness",
              bendingPlateThicknesses,
              bendingController,
              "bending_thickness",
            ),
          ],
        ),
      ),
    );
  }
}
