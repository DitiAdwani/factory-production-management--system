class FinningTubesRecord {
  String qtyProduced;

  String qtyRework;

  String qtyRejected;

  String totalQty;

  FinningTubesRecord({
    this.qtyProduced = '',

    this.qtyRework = '',

    this.qtyRejected = '',

    this.totalQty = '',
  });
  Map<String, dynamic> toMap() => {
    "qtyProduced": qtyProduced,
    "qtyRework": qtyRework,
    "qtyRejected": qtyRejected,
    "totalQty": totalQty,
  };

  factory FinningTubesRecord.fromMap(Map<String, dynamic> map) {
    return FinningTubesRecord()
      ..qtyProduced = map["qtyProduced"] ?? ""
      ..qtyRework = map["qtyRework"] ?? ""
      ..qtyRejected = map["qtyRejected"] ?? ""
      ..totalQty = map["totalQty"] ?? "";
  }
}
