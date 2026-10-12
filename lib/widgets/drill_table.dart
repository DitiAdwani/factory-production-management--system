import 'package:flutter/material.dart';
import '../models/drill_record.dart';
// import '../services/csv_service.dart';

List<DrillRecord> drillRecords = [DrillRecord()];

class DrillTable extends StatefulWidget {
  final Function(String) onQuantityChanged;

  const DrillTable({super.key, required this.onQuantityChanged});

  @override
  State<DrillTable> createState() => _DrillTableState();
}

class _DrillTableState extends State<DrillTable> {
  Future<String?> pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked == null) return null;

    return picked.format(context);
  }

  List<DropdownMenuItem<String>> downCodeItems() {
    List<DropdownMenuItem<String>> items = [];

    items.add(const DropdownMenuItem(value: "None", child: Text("None")));

    for (int i = 0; i < 17; i++) {
      String code = String.fromCharCode(65 + i);

      items.add(DropdownMenuItem(value: code, child: Text(code)));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: DataTable(
            border: TableBorder.all(),

            columns: const [
              DataColumn(label: Text("Sr")),

              DataColumn(label: Text("Job Description")),

              DataColumn(label: Text("Job Type")),

              DataColumn(label: Text("Job Thickness")),

              DataColumn(label: Text("No. Holes")),

              DataColumn(label: Text("Quantity")),

              DataColumn(label: Text("Loading Start")),

              DataColumn(label: Text("Loading End")),

              DataColumn(label: Text("Machine Start")),

              DataColumn(label: Text("Machine End")),

              DataColumn(label: Text("Down Code")),

              DataColumn(label: Text("Down Start")),

              DataColumn(label: Text("Down End")),

              DataColumn(label: Text("Delete")),
            ],

            rows: List.generate(drillRecords.length, (index) {
              DrillRecord row = drillRecords[index];

              return DataRow(
                cells: [
                  DataCell(Text("${index + 1}")),
                  DataCell(
                    SizedBox(
                      width: 180,
                      child: TextFormField(
                        initialValue: row.jobDescription,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.jobDescription = value;
                        },
                      ),
                    ),
                  ),

                  DataCell(
                    SizedBox(
                      width: 120,
                      child: TextFormField(
                        initialValue: row.jobType,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.jobType = value;
                        },
                      ),
                    ),
                  ),

                  DataCell(
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        initialValue: row.jobThickness,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.jobThickness = value;
                        },
                      ),
                    ),
                  ),

                  DataCell(
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: row.holesDrilled,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.holesDrilled = value;
                        },
                      ),
                    ),
                  ),

                  DataCell(
                    SizedBox(
                      width: 80,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: row.quantity,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.quantity = value;
                          widget.onQuantityChanged(value);
                        },
                      ),
                    ),
                  ),

                  DataCell(
                    ElevatedButton(
                      onPressed: () async {
                        String? t = await pickTime();
                        if (t != null) {
                          setState(() {
                            row.loadingStart = t;
                          });
                        }
                      },
                      child: Text(
                        row.loadingStart.isEmpty ? "Time" : row.loadingStart,
                      ),
                    ),
                  ),

                  DataCell(
                    ElevatedButton(
                      onPressed: () async {
                        String? t = await pickTime();
                        if (t != null) {
                          setState(() {
                            row.loadingEnd = t;
                          });
                        }
                      },
                      child: Text(
                        row.loadingEnd.isEmpty ? "Time" : row.loadingEnd,
                      ),
                    ),
                  ),

                  DataCell(
                    ElevatedButton(
                      onPressed: () async {
                        String? t = await pickTime();
                        if (t != null) {
                          setState(() {
                            row.machineStart = t;
                          });
                        }
                      },
                      child: Text(
                        row.machineStart.isEmpty ? "Time" : row.machineStart,
                      ),
                    ),
                  ),

                  DataCell(
                    ElevatedButton(
                      onPressed: () async {
                        String? t = await pickTime();
                        if (t != null) {
                          setState(() {
                            row.machineEnd = t;
                          });
                        }
                      },
                      child: Text(
                        row.machineEnd.isEmpty ? "Time" : row.machineEnd,
                      ),
                    ),
                  ),

                  DataCell(
                    SizedBox(
                      width: 90,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: row.downCode,
                        items: downCodeItems(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            row.downCode = value;
                          });
                        },
                      ),
                    ),
                  ),

                  DataCell(
                    ElevatedButton(
                      onPressed: () async {
                        String? t = await pickTime();
                        if (t != null) {
                          setState(() {
                            row.downStart = t;
                          });
                        }
                      },
                      child: Text(
                        row.downStart.isEmpty ? "Time" : row.downStart,
                      ),
                    ),
                  ),

                  DataCell(
                    ElevatedButton(
                      onPressed: () async {
                        String? t = await pickTime();
                        if (t != null) {
                          setState(() {
                            row.downEnd = t;
                          });
                        }
                      },
                      child: Text(row.downEnd.isEmpty ? "Time" : row.downEnd),
                    ),
                  ),

                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        if (drillRecords.length > 1) {
                          setState(() {
                            drillRecords.removeAt(index);
                          });
                        }
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  drillRecords.add(DrillRecord());
                });
              },
              icon: const Icon(Icons.add),
              label: const Text("Add Row"),
            ),
          ],
        ),
      ],
    );
  }
}
