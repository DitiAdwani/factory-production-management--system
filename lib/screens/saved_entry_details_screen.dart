import 'package:flutter/material.dart';
import '../../data/saved_entries.dart';

class SavedEntryDetailsScreen extends StatelessWidget {
  final SavedEntry entry;

  const SavedEntryDetailsScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Entry Details")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "Operator : ${entry.operator}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Text("Date : ${entry.date}"),
          Text("Shift : ${entry.shift}"),
          Text("Machine Type : ${entry.machineType}"),
          Text("Machine : ${entry.machine}"),

          const SizedBox(height: 20),

          ...entry.records.map((r) {
            return Card(
              margin: const EdgeInsets.only(bottom: 15),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildRecordDetails(Map<String, dynamic>.from(r)),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  List<Widget> _buildRecordDetails(Map<String, dynamic> r) {
    switch (entry.machineType) {
      case "VMC":
        return [
          Text("Job Description : ${r["jobDescription"]}"),
          Text("Revision : ${r["rev"]}"),
          Text("Operation : ${r["operation"]}"),
          Text("Quantity : ${r["quantity"]}"),
          Text("Loading Start : ${r["loadingStart"]}"),
          Text("Loading End : ${r["loadingEnd"]}"),
          Text("Machine Start : ${r["machineStart"]}"),
          Text("Machine End : ${r["machineEnd"]}"),
          Text("Down Code : ${r["downCode"]}"),
          Text("Down Start : ${r["downStart"]}"),
          Text("Down End : ${r["downEnd"]}"),
        ];

      case "Drill":
        return [
          Text("Job Description : ${r["jobDescription"]}"),
          Text("Job Type : ${r["jobType"]}"),
          Text("Job Thickness : ${r["jobThickness"]}"),
          Text("No. of Holes : ${r["holesDrilled"]}"),
          Text("Quantity : ${r["quantity"]}"),
          Text("Loading Start : ${r["loadingStart"]}"),
          Text("Loading End : ${r["loadingEnd"]}"),
          Text("Machine Start : ${r["machineStart"]}"),
          Text("Machine End : ${r["machineEnd"]}"),
          Text("Down Code : ${r["downCode"]}"),
          Text("Down Start : ${r["downStart"]}"),
          Text("Down End : ${r["downEnd"]}"),
        ];

      case "Punching Machine":
        return [
          Text("Model No : ${r["modelNo"]}"),
          Text("Program Name : ${r["programName"]}"),
          Text("Plate Thickness : ${r["plateThickness"]}"),
          Text("Qty Of Sheets : ${r["qtyOfSheets"]}"),
          Text("No Of Set : ${r["noOfSet"]}"),
          Text("Machine Start : ${r["machineStart"]}"),
          Text("Machine End : ${r["machineEnd"]}"),
          Text("Down Code : ${r["downCode"]}"),
          Text("Down Start : ${r["downStart"]}"),
          Text("Down End : ${r["downEnd"]}"),
        ];

      case "Bending Machine":
        return [
          Text("Model No : ${r["modelNo"]}"),
          Text("Item : ${r["item"]}"),
          Text("Plate Thickness : ${r["plateThickness"]}"),
          Text("No Of Set : ${r["noOfSet"]}"),
          Text("Machine Start : ${r["machineStart"]}"),
          Text("Machine End : ${r["machineEnd"]}"),
          Text("Down Code : ${r["downCode"]}"),
          Text("Down Start : ${r["downStart"]}"),
          Text("Down End : ${r["downEnd"]}"),
        ];

      case "Finning Machine":
        return [
          Text("Type Of Finning : ${r["typeOfFinning"]}"),
          Text("Project Name : ${r["projectName"]}"),
          Text("Tube Size : ${r["tubeSize"]}"),
          Text("Quantity : ${r["quantity"]}"),
          Text("New / Rework : ${r["newOrRework"]}"),
          Text("Machine Start : ${r["machineStart"]}"),
          Text("Machine End : ${r["machineEnd"]}"),
          Text("Down Code : ${r["downCode"]}"),
          Text("Down Start : ${r["downStart"]}"),
          Text("Down End : ${r["downEnd"]}"),
        ];

      case "Finning Tubes":
        return [
          Text("Qty Produced : ${r["qtyProduced"]}"),
          Text("Qty Rework : ${r["qtyRework"]}"),
          Text("Qty Rejected : ${r["qtyRejected"]}"),
          Text("Total Qty : ${r["totalQty"]}"),
        ];

      default:
        return [
          const Text(
            "Unknown Machine Type",
            style: TextStyle(color: Colors.red),
          ),
        ];
    }
  }
}
