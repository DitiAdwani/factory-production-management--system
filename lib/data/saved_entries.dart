class SavedEntry {
  final String operator;
  final String date;
  final String shift;
  final String machineType;
  final String machine;
  final String quantity;
  final List<dynamic> records;

  SavedEntry({
    required this.operator,
    required this.date,
    required this.shift,
    required this.machineType,
    required this.machine,
    required this.quantity,
    required this.records,
  });

  Map<String, dynamic> toMap() {
    return {
      "operator": operator,
      "date": date,
      "shift": shift,
      "machineType": machineType,
      "machine": machine,
      "quantity": quantity,
      "records": records, // ← FIXED
    };
  }

  factory SavedEntry.fromMap(Map<String, dynamic> map) {
    return SavedEntry(
      operator: map["operator"] ?? "",
      date: map["date"] ?? "",
      shift: map["shift"] ?? "",
      machineType: map["machineType"] ?? "",
      machine: map["machine"] ?? "",
      quantity: map["quantity"] ?? "",
      records: List<dynamic>.from(map["records"] ?? []),
    );
  }
}
