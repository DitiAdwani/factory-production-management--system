class DrillRecord {
  String jobDescription;
  String jobType;
  String jobThickness;
  String holesDrilled;
  String quantity;

  String loadingStart;
  String loadingEnd;

  String machineStart;
  String machineEnd;

  String downCode;
  String downStart;
  String downEnd;

  DrillRecord({
    this.jobDescription = '',
    this.jobType = '',
    this.jobThickness = '',
    this.holesDrilled = '',
    this.quantity = '',
    this.loadingStart = '',
    this.loadingEnd = '',
    this.machineStart = '',
    this.machineEnd = '',
    this.downCode = 'None',
    this.downStart = '',
    this.downEnd = '',
  });
  Map<String, dynamic> toMap() => {
    "jobDescription": jobDescription,
    "jobType": jobType,
    "jobThickness": jobThickness,
    "holesDrilled": holesDrilled,
    "quantity": quantity,
    "loadingStart": loadingStart,
    "loadingEnd": loadingEnd,
    "machineStart": machineStart,
    "machineEnd": machineEnd,
    "downCode": downCode,
    "downStart": downStart,
    "downEnd": downEnd,
  };

  factory DrillRecord.fromMap(Map<String, dynamic> map) {
    return DrillRecord()
      ..jobDescription = map["jobDescription"] ?? ""
      ..jobType = map["jobType"] ?? ""
      ..jobThickness = map["jobThickness"] ?? ""
      ..holesDrilled = map["holesDrilled"] ?? ""
      ..quantity = map["quantity"] ?? ""
      ..loadingStart = map["loadingStart"] ?? ""
      ..loadingEnd = map["loadingEnd"] ?? ""
      ..machineStart = map["machineStart"] ?? ""
      ..machineEnd = map["machineEnd"] ?? ""
      ..downCode = map["downCode"] ?? "None"
      ..downStart = map["downStart"] ?? ""
      ..downEnd = map["downEnd"] ?? "";
  }
}
