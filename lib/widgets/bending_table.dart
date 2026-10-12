import 'package:flutter/material.dart';
import '../models/bending_record.dart';
import '../data/dropdown_data.dart';
// import '../services/csv_service.dart';

List<BendingRecord> bendingRecords = [BendingRecord()];

class BendingTable extends StatefulWidget {
  final Function(String) onQuantityChanged;

  const BendingTable({super.key, required this.onQuantityChanged});

  @override
  State<BendingTable> createState() => _BendingTableState();
}

class _BendingTableState extends State<BendingTable> {
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
          "Bending Machine Production",

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

              DataColumn(label: Text("Item")),

              DataColumn(label: Text("Plate Thickness")),

              DataColumn(label: Text("No Of Set")),

              DataColumn(label: Text("Machine Start")),

              DataColumn(label: Text("Machine End")),

              DataColumn(label: Text("Down Code")),

              DataColumn(label: Text("Down Start")),

              DataColumn(label: Text("Down End")),

              DataColumn(label: Text("Delete")),
            ],

            rows: List.generate(bendingRecords.length, (index) {
              BendingRecord row = bendingRecords[index];

              return DataRow(
                cells: [
                  DataCell(Text("${index + 1}")),
                  DataCell(
                    SizedBox(
                      width: 120,
                      child: TextFormField(
                        initialValue: row.modelNo,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.modelNo = value;
                        },
                      ),
                    ),
                  ),

                  DataCell(
                    SizedBox(
                      width: 180,
                      child: TextFormField(
                        initialValue: row.item,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.item = value;
                        },
                      ),
                    ),
                  ),

                  DataCell(
                    SizedBox(
                      width: 120,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: row.plateThickness.isEmpty
                            ? null
                            : row.plateThickness,
                        hint: const Text("Thickness"),
                        items: bendingPlateThicknesses.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            row.plateThickness = value!;
                          });
                        },
                      ),
                    ),
                  ),

                  DataCell(
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: row.noOfSet,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.noOfSet = value;
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
                        if (bendingRecords.length > 1) {
                          setState(() {
                            bendingRecords.removeAt(index);
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
                  bendingRecords.add(BendingRecord());
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
