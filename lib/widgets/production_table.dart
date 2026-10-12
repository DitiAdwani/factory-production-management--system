import 'package:flutter/material.dart';
import '../models/production_record.dart';
import '../data/dropdown_data.dart';
// import '../services/csv_service.dart';

List<ProductionRecord> productionRecords = [ProductionRecord()];

class ProductionTable extends StatefulWidget {
  final Function(String) onQuantityChanged;

  const ProductionTable({super.key, required this.onQuantityChanged});

  @override
  State<ProductionTable> createState() => _ProductionTableState();
}

class _ProductionTableState extends State<ProductionTable> {
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
        const SizedBox(height: 20),

        const Text(
          "Production Details",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            border: TableBorder.all(),

            columns: const [
              DataColumn(label: Text("Sr")),

              DataColumn(label: Text("Job Description")),

              DataColumn(label: Text("Rev")),

              DataColumn(label: Text("Operation")),

              DataColumn(label: Text("Qty")),

              DataColumn(label: Text("Loading Start")),

              DataColumn(label: Text("Loading End")),

              DataColumn(label: Text("Machine Start")),

              DataColumn(label: Text("Machine End")),

              DataColumn(label: Text("Down Code")),

              DataColumn(label: Text("Down Start")),

              DataColumn(label: Text("Down End")),

              DataColumn(label: Text("Delete")),
            ],

            rows: List.generate(productionRecords.length, (index) {
              ProductionRecord row = productionRecords[index];

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
                      width: 70,
                      child: TextFormField(
                        initialValue: row.rev,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.rev = value;
                        },
                      ),
                    ),
                  ),

                  DataCell(
                    SizedBox(
                      width: 120,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: row.operation.isEmpty ? null : row.operation,
                        hint: const Text("Operation"),
                        items: vmcOperations.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            row.operation = value!;
                          });
                        },
                      ),
                    ),
                  ),

                  DataCell(
                    SizedBox(
                      width: 70,
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
                        if (productionRecords.length > 1) {
                          setState(() {
                            productionRecords.removeAt(index);
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
                  productionRecords.add(ProductionRecord());
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
