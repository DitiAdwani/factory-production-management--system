import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/production_table.dart';
import '../../widgets/drill_table.dart';
import '../../widgets/finning_machine_table.dart';
import '../../widgets/finning_tubes_table.dart';
import '../../widgets/punching_table.dart';
import '../../widgets/bending_table.dart';
import '../../data/dropdown_data.dart';
import '../../services/preferences_service.dart';
import '../saved_entries_screen.dart';
import '.././admin_login_screen.dart';

// ✅ ADD THIS IMPORT (fix path as per your project)
import '../../screens/preview/preview_screen.dart';

Map<String, dynamic> productionRecord = {};

class DataEntryScreen extends StatefulWidget {
  const DataEntryScreen({super.key});

  @override
  State<DataEntryScreen> createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  String selectedOperator = "Operator 1";
  String quantity = "";
  DateTime selectedDate = DateTime.now();

  String machineType = "VMC";
  String selectedMachine = "VMC-1";
  String selectedShift = "1";

  @override
  void initState() {
    super.initState();
    loadDropdowns();
  }

  Future<void> loadDropdowns() async {
    operators = await PreferencesService.loadList("operators");

    if (operators.isEmpty) {
      operators = ["Operator 1"];
    }

    setState(() {
      selectedOperator = operators.first;
    });
  }

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  List<String> getMachines() {
    switch (machineType) {
      case "VMC":
        return ["VMC-1", "VMC-2", "VMC-3", "VMC-4"];

      case "Drill":
        return ["Drill-1", "Drill-2", "Drill-3", "Drill-4"];

      case "Finning Machine":
        return ["Finning-1", "Finning-2"];

      case "Finning Tubes":
        return ["Finning Tubes"];

      case "Punching Machine":
        return ["Punching-1", "Punching-2"];

      case "Bending Machine":
        return ["Bending-1", "Bending-2"];

      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Production Entry"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt), // Saved entries button
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SavedEntriesScreen()),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            tooltip: "Admin Login",
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AdminLoginScreen()),
              );

              // Reload operators in case the admin changed them
              await loadDropdowns();

              setState(() {
                if (!operators.contains(selectedOperator)) {
                  selectedOperator = operators.first;
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Production Details",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),

            DropdownButtonFormField<String>(
              value: selectedOperator,
              decoration: const InputDecoration(
                labelText: "Operator Name",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              items: operators.map((operator) {
                return DropdownMenuItem(value: operator, child: Text(operator));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedOperator = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            InkWell(
              onTap: pickDate,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Date",
                  prefixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(),
                ),
                child: Text(DateFormat("dd-MM-yyyy").format(selectedDate)),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: machineType,
              decoration: const InputDecoration(
                labelText: "Machine Type",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "VMC", child: Text("VMC")),
                DropdownMenuItem(value: "Drill", child: Text("Drill")),
                DropdownMenuItem(
                  value: "Finning Machine",
                  child: Text("Finning Machine"),
                ),
                DropdownMenuItem(
                  value: "Finning Tubes",
                  child: Text("Finning Tubes"),
                ),
                DropdownMenuItem(
                  value: "Punching Machine",
                  child: Text("Punching Machine"),
                ),
                DropdownMenuItem(
                  value: "Bending Machine",
                  child: Text("Bending Machine"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  machineType = value!;
                  selectedMachine = getMachines().first;
                });
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedMachine,
              decoration: const InputDecoration(
                labelText: "Machine",
                border: OutlineInputBorder(),
              ),
              items: getMachines()
                  .map(
                    (machine) =>
                        DropdownMenuItem(value: machine, child: Text(machine)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedMachine = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedShift,
              decoration: const InputDecoration(
                labelText: "Shift",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "1", child: Text("1")),
                DropdownMenuItem(value: "2", child: Text("2")),
                DropdownMenuItem(value: "3", child: Text("3")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedShift = value!;
                });
              },
            ),

            const SizedBox(height: 30),

            // MACHINE TABLES
            if (machineType == "VMC")
              ProductionTable(
                onQuantityChanged: (value) {
                  quantity = value;
                },
              ),
            if (machineType == "Drill")
              DrillTable(
                onQuantityChanged: (value) {
                  quantity = value;
                },
              ),
            if (machineType == "Finning Machine")
              FinningMachineTable(
                onQuantityChanged: (value) {
                  quantity = value;
                },
              ),
            if (machineType == "Finning Tubes")
              FinningTubesTable(
                onQuantityChanged: (value) {
                  quantity = value;
                },
              ),
            if (machineType == "Punching Machine")
              PunchingTable(
                onQuantityChanged: (value) {
                  quantity = value;
                },
              ),
            if (machineType == "Bending Machine")
              BendingTable(
                onQuantityChanged: (value) {
                  quantity = value;
                },
              ),

            const SizedBox(height: 30),

            // ✅ PREVIEW BUTTON (ADDED HERE)
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PreviewScreen(
                      operator: selectedOperator,
                      date: DateFormat("dd-MM-yyyy").format(selectedDate),
                      shift: selectedShift,
                      machineType: machineType,
                      machine: selectedMachine,
                      quantity: quantity,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.preview),
              label: const Text("Preview"),
            ),
          ],
        ),
      ),
    );
  }
}
