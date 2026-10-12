import 'package:flutter/material.dart';
import '../../data/saved_entries.dart';
import '../../services/entry_storage.dart';
import '../../services/csv_service.dart';
import '../../widgets/production_table.dart';
import '../../widgets/drill_table.dart';
import '../../widgets/finning_machine_table.dart';
import '../../widgets/finning_tubes_table.dart';
import '../../widgets/punching_table.dart';
import '../../widgets/bending_table.dart';

class PreviewScreen extends StatelessWidget {
  final String operator;
  final String date;
  final String shift;
  final String machineType;
  final String machine;
  final String quantity;

  const PreviewScreen({
    super.key,
    required this.operator,
    required this.date,
    required this.shift,
    required this.machineType,
    required this.machine,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    List<dynamic> currentRecords = [];

    if (machineType == "VMC") {
      currentRecords = List.from(productionRecords);
    } else if (machineType == "Drill") {
      currentRecords = List.from(drillRecords);
    } else if (machineType == "Finning Machine") {
      currentRecords = List.from(finningMachineRecords);
    } else if (machineType == "Finning Tubes") {
      currentRecords = List.from(finningTubeRecords);
    } else if (machineType == "Punching Machine") {
      currentRecords = List.from(punchingRecords);
    } else if (machineType == "Bending Machine") {
      currentRecords = List.from(bendingRecords);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Production Preview")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text("Operator"),
                subtitle: Text(operator),
              ),
            ),

            Card(
              child: ListTile(title: const Text("Date"), subtitle: Text(date)),
            ),

            Card(
              child: ListTile(
                title: const Text("Shift"),
                subtitle: Text(shift),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text("Machine Type"),
                subtitle: Text(machineType),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text("Machine"),
                subtitle: Text(machine),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text("Quantity"),
                subtitle: Text(quantity),
              ),
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final entry = SavedEntry(
                        operator: operator,
                        date: date,
                        shift: shift,
                        machineType: machineType,
                        machine: machine,
                        quantity: quantity,
                        records: currentRecords.map((e) => e.toMap()).toList(),
                      );

                      await EntryStorage.addEntry(entry);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Saved Successfully")),
                      );
                    },
                    child: const Text("Save"),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 248, 247, 246),
                    ),
                    child: const Text("Edit"),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final entries = await EntryStorage.loadEntries();

                      List<List<dynamic>> rows = [];

                      for (var e in entries) {
                        // ================= VMC =================
                        if (e.machineType == "VMC") {
                          rows.add([
                            "Operator",
                            "Date",
                            "Shift",
                            "Machine Type",
                            "Machine",
                            "Job Description",
                            "Rev",
                            "Operation",
                            "Quantity",
                            "Loading Start",
                            "Loading End",
                            "Machine Start",
                            "Machine End",
                            "Down Code",
                            "Down Start",
                            "Down End",
                          ]);

                          for (var r in e.records) {
                            rows.add([
                              e.operator,
                              e.date,
                              e.shift,
                              e.machineType,
                              e.machine,
                              r["jobDescription"],
                              r["rev"],
                              r["operation"],
                              r["quantity"],
                              r["loadingStart"],
                              r["loadingEnd"],
                              r["machineStart"],
                              r["machineEnd"],
                              r["downCode"],
                              r["downStart"],
                              r["downEnd"],
                            ]);
                          }
                        }
                        // ================= DRILL =================
                        else if (e.machineType == "Drill") {
                          rows.add([
                            "Operator",
                            "Date",
                            "Shift",
                            "Machine Type",
                            "Machine",
                            "Job Description",
                            "Job Type",
                            "Job Thickness",
                            "No Holes",
                            "Quantity",
                            "Loading Start",
                            "Loading End",
                            "Machine Start",
                            "Machine End",
                            "Down Code",
                            "Down Start",
                            "Down End",
                          ]);

                          for (var r in e.records) {
                            rows.add([
                              e.operator,
                              e.date,
                              e.shift,
                              e.machineType,
                              e.machine,
                              r["jobDescription"],
                              r["jobType"],
                              r["jobThickness"],
                              r["holesDrilled"],
                              r["quantity"],
                              r["loadingStart"],
                              r["loadingEnd"],
                              r["machineStart"],
                              r["machineEnd"],
                              r["downCode"],
                              r["downStart"],
                              r["downEnd"],
                            ]);
                          }
                        }
                        // ================= FINNING MACHINE =================
                        else if (e.machineType == "Finning Machine") {
                          rows.add([
                            "Operator",
                            "Date",
                            "Shift",
                            "Machine Type",
                            "Machine",
                            "Type Of Finning",
                            "Project Name",
                            "Tube Size",
                            "Quantity",
                            "New/Rework",
                            "Machine Start",
                            "Machine End",
                            "Down Code",
                            "Down Start",
                            "Down End",
                          ]);

                          for (var r in e.records) {
                            rows.add([
                              e.operator,
                              e.date,
                              e.shift,
                              e.machineType,
                              e.machine,
                              r["typeOfFinning"],
                              r["projectName"],
                              r["tubeSize"],
                              r["quantity"],
                              r["newOrRework"],
                              r["machineStart"],
                              r["machineEnd"],
                              r["downCode"],
                              r["downStart"],
                              r["downEnd"],
                            ]);
                          }
                        }
                        // ================= FINNING TUBES =================
                        else if (e.machineType == "Finning Tubes") {
                          rows.add([
                            "Operator",
                            "Date",
                            "Shift",
                            "Machine Type",
                            "Machine",
                            "Qty Produced",
                            "Qty Rework",
                            "Qty Rejected",
                            "Total Qty",
                          ]);

                          for (var r in e.records) {
                            rows.add([
                              e.operator,
                              e.date,
                              e.shift,
                              e.machineType,
                              e.machine,
                              r["qtyProduced"],
                              r["qtyRework"],
                              r["qtyRejected"],
                              r["totalQty"],
                            ]);
                          }
                        }
                        // ================= PUNCHING =================
                        else if (e.machineType == "Punching Machine") {
                          rows.add([
                            "Operator",
                            "Date",
                            "Shift",
                            "Machine Type",
                            "Machine",
                            "Model No",
                            "Program Name",
                            "Plate Thickness",
                            "Qty Of Sheets",
                            "No Of Set",
                            "Machine Start",
                            "Machine End",
                            "Down Code",
                            "Down Start",
                            "Down End",
                          ]);

                          for (var r in e.records) {
                            rows.add([
                              e.operator,
                              e.date,
                              e.shift,
                              e.machineType,
                              e.machine,
                              r["modelNo"],
                              r["programName"],
                              r["plateThickness"],
                              r["qtyOfSheets"],
                              r["noOfSet"],
                              r["machineStart"],
                              r["machineEnd"],
                              r["downCode"],
                              r["downStart"],
                              r["downEnd"],
                            ]);
                          }
                        }
                        // ================= BENDING =================
                        else if (e.machineType == "Bending Machine") {
                          rows.add([
                            "Operator",
                            "Date",
                            "Shift",
                            "Machine Type",
                            "Machine",
                            "Model No",
                            "Item",
                            "Plate Thickness",
                            "No Of Set",
                            "Machine Start",
                            "Machine End",
                            "Down Code",
                            "Down Start",
                            "Down End",
                          ]);

                          for (var r in e.records) {
                            rows.add([
                              e.operator,
                              e.date,
                              e.shift,
                              e.machineType,
                              e.machine,
                              r["modelNo"],
                              r["item"],
                              r["plateThickness"],
                              r["noOfSet"],
                              r["machineStart"],
                              r["machineEnd"],
                              r["downCode"],
                              r["downStart"],
                              r["downEnd"],
                            ]);
                          }
                        }

                        rows.add([]);
                      }

                      CsvService.downloadGenericCsv(
                        rows,
                        "production_report.csv",
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 248, 247, 246),
                    ),
                    child: const Text("CSV"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
