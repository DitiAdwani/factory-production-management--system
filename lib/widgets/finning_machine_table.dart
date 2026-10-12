import 'package:flutter/material.dart';
import '../models/finning_machine_record.dart';
import '../data/dropdown_data.dart';
// import '../services/csv_service.dart';

List<FinningMachineRecord> finningMachineRecords = [FinningMachineRecord()];

class FinningMachineTable extends StatefulWidget {
  final Function(String) onQuantityChanged;

  const FinningMachineTable({super.key, required this.onQuantityChanged});

  @override
  State<FinningMachineTable> createState() => _FinningMachineTableState();
}

class _FinningMachineTableState extends State<FinningMachineTable> {
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

  List<DropdownMenuItem<String>> newReworkItems() {
    return const [
      DropdownMenuItem(value: "New", child: Text("New")),

      DropdownMenuItem(value: "Rework", child: Text("Rework")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          "Finning Machine Production",

          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: DataTable(
            border: TableBorder.all(),

            columns: const [
              DataColumn(label: Text("Sr")),

              DataColumn(label: Text("Type Of Finning")),

              DataColumn(label: Text("Project Name")),

              DataColumn(label: Text("Tube Size")),

              DataColumn(label: Text("Quantity")),

              DataColumn(label: Text("New/Rework")),

              DataColumn(label: Text("Machine Start")),

              DataColumn(label: Text("Machine End")),

              DataColumn(label: Text("Down Code")),

              DataColumn(label: Text("Down Start")),

              DataColumn(label: Text("Down End")),

              DataColumn(label: Text("Delete")),
            ],

            rows: List.generate(finningMachineRecords.length, (index) {
              FinningMachineRecord row = finningMachineRecords[index];

              return DataRow(
                cells: [
                  DataCell(Text("${index + 1}")),
                  DataCell(
                    SizedBox(
                      width: 170,
                      child: TextFormField(
                        initialValue: row.typeOfFinning,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.typeOfFinning = value;
                        },
                      ),
                    ),
                  ),

                  DataCell(
                    SizedBox(
                      width: 180,
                      child: TextFormField(
                        initialValue: row.projectName,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.projectName = value;
                        },
                      ),
                    ),
                  ),

                  DataCell(
                    SizedBox(
                      width: 120,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: row.tubeSize.isEmpty ? null : row.tubeSize,
                        hint: const Text("Tube Size"),
                        items: finningTubeSizes.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            row.tubeSize = value!;
                          });
                        },
                      ),
                    ),
                  ),

                  DataCell(
                    SizedBox(
                      width: 90,
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
                    SizedBox(
                      width: 120,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: row.newOrRework,
                        items: newReworkItems(),
                        onChanged: (value) {
                          if (value == null) return;

                          setState(() {
                            row.newOrRework = value;
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
                        if (finningMachineRecords.length > 1) {
                          setState(() {
                            finningMachineRecords.removeAt(index);
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
                  finningMachineRecords.add(FinningMachineRecord());
                });
              },
              icon: const Icon(Icons.add),
              label: const Text("Add Row"),
            ),
          ],
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}
