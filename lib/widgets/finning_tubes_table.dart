import 'package:flutter/material.dart';
import '../models/finning_tubes_record.dart';
// import '../services/csv_service.dart';

List<FinningTubesRecord> finningTubeRecords = [FinningTubesRecord()];

class FinningTubesTable extends StatefulWidget {
  final Function(String) onQuantityChanged;

  const FinningTubesTable({super.key, required this.onQuantityChanged});

  @override
  State<FinningTubesTable> createState() => _FinningTubesTableState();
}

class _FinningTubesTableState extends State<FinningTubesTable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          "Finning Tubes Production",

          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: DataTable(
            border: TableBorder.all(),

            columns: const [
              DataColumn(label: Text("Sr")),

              DataColumn(label: Text("Qty Produced")),

              DataColumn(label: Text("Qty Rework")),

              DataColumn(label: Text("Qty Rejected")),

              DataColumn(label: Text("Total Qty")),

              DataColumn(label: Text("Delete")),
            ],

            rows: List.generate(finningTubeRecords.length, (index) {
              FinningTubesRecord row = finningTubeRecords[index];

              return DataRow(
                cells: [
                  DataCell(Text("${index + 1}")),
                  DataCell(
                    SizedBox(
                      width: 120,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: row.qtyProduced,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.qtyProduced = value;
                        },
                      ),
                    ),
                  ),

                  DataCell(
                    SizedBox(
                      width: 120,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: row.qtyRework,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.qtyRework = value;
                        },
                      ),
                    ),
                  ),

                  DataCell(
                    SizedBox(
                      width: 120,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: row.qtyRejected,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (value) {
                          row.qtyRejected = value;

                          int produced = int.tryParse(row.qtyProduced) ?? 0;

                          int rework = int.tryParse(row.qtyRework) ?? 0;

                          int rejected = int.tryParse(row.qtyRejected) ?? 0;

                          row.totalQty = (produced + rework + rejected)
                              .toString();

                          widget.onQuantityChanged(row.totalQty);

                          setState(() {});
                        },
                      ),
                    ),
                  ),

                  DataCell(
                    SizedBox(
                      width: 120,
                      child: TextFormField(
                        readOnly: true,
                        controller: TextEditingController(text: row.totalQty),
                        decoration: const InputDecoration(isDense: true),
                      ),
                    ),
                  ),

                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        if (finningTubeRecords.length > 1) {
                          setState(() {
                            finningTubeRecords.removeAt(index);
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
                  finningTubeRecords.add(FinningTubesRecord());
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
