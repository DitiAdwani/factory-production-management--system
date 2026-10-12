class PunchingRecord {
  String modelNo;

  String programName;

  String plateThickness;

  String qtyOfSheets;

  String noOfSet;

  String machineStart;

  String machineEnd;

  String downCode;

  String downStart;

  String downEnd;

  PunchingRecord({
    this.modelNo = '',
    this.programName = '',
    this.plateThickness = '',
    this.qtyOfSheets = '',
    this.noOfSet = '',
    this.machineStart = '',
    this.machineEnd = '',
    this.downCode = 'None',
    this.downStart = '',
    this.downEnd = '',
  });
  Map<String, dynamic> toMap() => {
    "modelNo": modelNo,
    "programName": programName,
    "plateThickness": plateThickness,
    "qtyOfSheets": qtyOfSheets,
    "noOfSet": noOfSet,
    "machineStart": machineStart,
    "machineEnd": machineEnd,
    "downCode": downCode,
    "downStart": downStart,
    "downEnd": downEnd,
  };

  factory PunchingRecord.fromMap(Map<String, dynamic> map) {
    return PunchingRecord()
      ..modelNo = map["modelNo"] ?? ""
      ..programName = map["programName"] ?? ""
      ..plateThickness = map["plateThickness"] ?? ""
      ..qtyOfSheets = map["qtyOfSheets"] ?? ""
      ..noOfSet = map["noOfSet"] ?? ""
      ..machineStart = map["machineStart"] ?? ""
      ..machineEnd = map["machineEnd"] ?? ""
      ..downCode = map["downCode"] ?? "None"
      ..downStart = map["downStart"] ?? ""
      ..downEnd = map["downEnd"] ?? "";
  }
}
