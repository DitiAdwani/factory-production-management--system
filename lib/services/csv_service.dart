import 'package:csv/csv.dart';
import 'dart:html' as html;

import '../models/production_record.dart';
import '../models/drill_record.dart';
import '../models/finning_machine_record.dart';
import '../models/finning_tubes_record.dart';
import '../models/punching_record.dart';
import '../models/bending_record.dart';
import '../data/saved_entries.dart';

class CsvService {
  // ================== VMC ==================
  static void generateProductionCsv(
    List<ProductionRecord> records,
    String operator,
    String date,
    String shift,
    String machine,
  ) {
    List<List<dynamic>> rows = [];

    rows.add([
      'Operator',
      'Date',
      'Shift',
      'Machine',
      'Job Description',
      'Rev',
      'Operation',
      'Quantity',
      'Loading Start',
      'Loading End',
      'Machine Start',
      'Machine End',
      'Down Code',
      'Down Start',
      'Down End',
    ]);

    for (var row in records) {
      rows.add([
        operator,
        date,
        shift,
        machine,
        row.jobDescription,
        row.rev,
        row.operation,
        row.quantity,
        row.loadingStart,
        row.loadingEnd,
        row.machineStart,
        row.machineEnd,
        row.downCode,
        row.downStart,
        row.downEnd,
      ]);
    }

    _downloadCsv(rows, "vmc_production.csv");
  }

  static void exportAllEntries(List<SavedEntry> entries) {
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
    _downloadCsv(rows, "all_saved_entries.csv");
  }

  // ================== DRILL ==================
  static void generateDrillCsv(
    List<DrillRecord> records,
    String operator,
    String date,
    String shift,
    String machine,
  ) {
    List<List<dynamic>> rows = [];

    rows.add([
      'Operator',
      'Date',
      'Shift',
      'Machine',
      'Job Description',
      'Job Type',
      'Job Thickness',
      'No Holes',
      'Quantity',
      'Loading Start',
      'Loading End',
      'Machine Start',
      'Machine End',
      'Down Code',
      'Down Start',
      'Down End',
    ]);

    for (var row in records) {
      rows.add([
        operator,
        date,
        shift,
        machine,
        row.jobDescription,
        row.jobType,
        row.jobThickness,
        row.holesDrilled,
        row.quantity,
        row.loadingStart,
        row.loadingEnd,
        row.machineStart,
        row.machineEnd,
        row.downCode,
        row.downStart,
        row.downEnd,
      ]);
    }

    _downloadCsv(rows, "drill_production.csv");
  }

  // ================== FINNING MACHINE ==================
  static void generateFinningMachineCsv(
    List<FinningMachineRecord> records,
    String operator,
    String date,
    String shift,
    String machine,
  ) {
    List<List<dynamic>> rows = [];

    rows.add([
      'Operator',
      'Date',
      'Shift',
      'Machine',
      'Type Of Finning',
      'Project Name',
      'Tube Size',
      'Quantity',
      'New/Rework',
      'Machine Start',
      'Machine End',
      'Down Code',
      'Down Start',
      'Down End',
    ]);

    for (var row in records) {
      rows.add([
        operator,
        date,
        shift,
        machine,
        row.typeOfFinning,
        row.projectName,
        row.tubeSize,
        row.quantity,
        row.newOrRework,
        row.machineStart,
        row.machineEnd,
        row.downCode,
        row.downStart,
        row.downEnd,
      ]);
    }
    _downloadCsv(rows, "finning_machine_production.csv");
  }

  // ================== FINNING TUBES ==================
  static void generateFinningTubesCsv(
    List<FinningTubesRecord> records,
    String operator,
    String date,
    String shift,
    String machine,
  ) {
    List<List<dynamic>> rows = [];

    rows.add([
      'Operator',
      'Date',
      'Shift',
      'Machine',
      'Qty Produced',
      'Qty Rework',
      'Qty Rejected',
      'Total Qty',
    ]);

    for (var row in records) {
      rows.add([
        operator,
        date,
        shift,
        machine,
        row.qtyProduced,
        row.qtyRework,
        row.qtyRejected,
        row.totalQty,
      ]);
    }

    _downloadCsv(rows, "finning_tubes_production.csv");
  }

  // ================== PUNCHING ==================
  static void generatePunchingCsv(
    List<PunchingRecord> records,
    String operator,
    String date,
    String shift,
    String machine,
  ) {
    List<List<dynamic>> rows = [];

    rows.add([
      'Operator',
      'Date',
      'Shift',
      'Machine',
      'Model No',
      'Program Name',
      'Plate Thickness',
      'Qty Of Sheets',
      'No Of Set',
      'Machine Start',
      'Machine End',
      'Down Code',
      'Down Start',
      'Down End',
    ]);

    for (var row in records) {
      rows.add([
        operator,
        date,
        shift,
        machine,
        row.modelNo,
        row.programName,
        row.plateThickness,
        row.qtyOfSheets,
        row.noOfSet,
        row.machineStart,
        row.machineEnd,
        row.downCode,
        row.downStart,
        row.downEnd,
      ]);
    }

    _downloadCsv(rows, "punching_production.csv");
  }

  // ================== BENDING ==================
  static void generateBendingCsv(
    List<BendingRecord> records,
    String operator,
    String date,
    String shift,
    String machine,
  ) {
    List<List<dynamic>> rows = [];

    rows.add([
      'Operator',
      'Date',
      'Shift',
      'Machine',
      'Model No',
      'Item',
      'Plate Thickness',
      'No Of Set',
      'Machine Start',
      'Machine End',
      'Down Code',
      'Down Start',
      'Down End',
    ]);

    for (var row in records) {
      rows.add([
        operator,
        date,
        shift,
        machine,
        row.modelNo,
        row.item,
        row.plateThickness,
        row.noOfSet,
        row.machineStart,
        row.machineEnd,
        row.downCode,
        row.downStart,
        row.downEnd,
      ]);
    }

    _downloadCsv(rows, "bending_production.csv");
  }

  // ================== COMMON DOWNLOAD ==================
  static void _downloadCsv(List<List<dynamic>> rows, String fileName) {
    String csvData = const ListToCsvConverter().convert(rows);

    final blob = html.Blob([csvData], 'text/csv;charset=utf-8');

    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();

    html.Url.revokeObjectUrl(url);
  }

  static void downloadGenericCsv(List<List<dynamic>> rows, String fileName) {
    _downloadCsv(rows, fileName);
  }
}
