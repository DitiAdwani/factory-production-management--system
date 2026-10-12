import 'package:flutter/material.dart';
import '../models/punching_record.dart';
// import '../services/csv_service.dart';
import '../data/dropdown_data.dart';

List<PunchingRecord> punchingRecords = [PunchingRecord()];

class PunchingTable extends StatefulWidget {
  final Function(String) onQuantityChanged;

  const PunchingTable({super.key, required this.onQuantityChanged});

  @override
  State<PunchingTable> createState() => _PunchingTableState();
}

class _PunchingTableState extends State<PunchingTable> {
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
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          "Punching Machine Production",

          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: DataTable(
            border: TableBorder.all(),

            columns: const [
              DataColumn(label: Text("Sr")),

              DataColumn(label: Text("Model No")),

              DataColumn(label: Text("Program Name")),

              DataColumn(label: Text("Plate Thickness")),

              DataColumn(label: Text("Qty Of Sheets")),

              DataColumn(label: Text("No Of Set")),

              DataColumn(label: Text("Machine Start")),

              DataColumn(label: Text("Machine End")),

              DataColumn(label: Text("Down Code")),

              DataColumn(label: Text("Down Start")),

              DataColumn(label: Text("Down End")),

              DataColumn(label: Text("Delete")),
            ],

            rows: List.generate(punchingRecords.length, (index) {
              PunchingRecord row = punchingRecords[index];

              return DataRow(
                cells: [
                  // Sr
                  DataCell(Text("${index + 1}")),

                  // Model Number Dropdown
                  DataCell(
                    SizedBox(
                      width: 120,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: row.modelNo.isEmpty ? null : row.modelNo,
                        hint: const Text("Model No"),
                        items: punchingModelNumbers.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            row.modelNo = value!;
                          });
                        },
                      ),
                    ),
                  ),

                  // Program Name
                  DataCell(
                    SizedBox(
                      width: 170,
                      child: TextFormField(
                        initialValue: row.programName,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.programName = value;
                        },
                      ),
                    ),
                  ),

                  // Plate Thickness
                  DataCell(
                    SizedBox(
                      width: 120,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: row.plateThickness,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.plateThickness = value;
                        },
                      ),
                    ),
                  ),

                  // Quantity Of Sheets
                  DataCell(
                    SizedBox(
                      width: 120,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: row.qtyOfSheets,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.qtyOfSheets = value;
                          widget.onQuantityChanged(value);
                        },
                      ),
                    ),
                  ),

                  // Number Of Set
                  DataCell(
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: row.noOfSet,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.noOfSet = value;
                        },
                      ),
                    ),
                  ),

                  // Machine Start
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

                  // Machine End
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

                  // Down Code
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

                  // Down Start
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

                  // Down End
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

                  // Delete Button
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        if (punchingRecords.length > 1) {
                          setState(() {
                            punchingRecords.removeAt(index);
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
                  punchingRecords.add(PunchingRecord());
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
