class BendingRecord {
  String modelNo;

  String item;

  String plateThickness;

  String noOfSet;

  String machineStart;

  String machineEnd;

  String downCode;

  String downStart;

  String downEnd;

  BendingRecord({
    this.modelNo = '',
    this.item = '',
    this.plateThickness = '',
    this.noOfSet = '',
    this.machineStart = '',
    this.machineEnd = '',
    this.downCode = 'None',
    this.downStart = '',
    this.downEnd = '',
  });
  Map<String, dynamic> toMap() => {
    "modelNo": modelNo,
    "item": item,
    "plateThickness": plateThickness,
    "noOfSet": noOfSet,
    "machineStart": machineStart,
    "machineEnd": machineEnd,
    "downCode": downCode,
    "downStart": downStart,
    "downEnd": downEnd,
  };

  factory BendingRecord.fromMap(Map<String, dynamic> map) {
    return BendingRecord()
      ..modelNo = map["modelNo"] ?? ""
      ..item = map["item"] ?? ""
      ..plateThickness = map["plateThickness"] ?? ""
      ..noOfSet = map["noOfSet"] ?? ""
      ..machineStart = map["machineStart"] ?? ""
      ..machineEnd = map["machineEnd"] ?? ""
      ..downCode = map["downCode"] ?? "None"
      ..downStart = map["downStart"] ?? ""
      ..downEnd = map["downEnd"] ?? "";
  }
}
