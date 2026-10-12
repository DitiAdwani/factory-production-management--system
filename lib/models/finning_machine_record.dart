class FinningMachineRecord {
  String typeOfFinning;

  String projectName;

  String tubeSize;

  String quantity;

  String newOrRework;

  String machineStart;

  String machineEnd;

  String downCode;

  String downStart;

  String downEnd;

  FinningMachineRecord({
    this.typeOfFinning = '',
    this.projectName = '',
    this.tubeSize = '',
    this.quantity = '',
    this.newOrRework = 'New',
    this.machineStart = '',
    this.machineEnd = '',
    this.downCode = 'None',
    this.downStart = '',
    this.downEnd = '',
  });
  Map<String, dynamic> toMap() => {
    "typeOfFinning": typeOfFinning,
    "projectName": projectName,
    "tubeSize": tubeSize,
    "quantity": quantity,
    "newOrRework": newOrRework,
    "machineStart": machineStart,
    "machineEnd": machineEnd,
    "downCode": downCode,
    "downStart": downStart,
    "downEnd": downEnd,
  };

  factory FinningMachineRecord.fromMap(Map<String, dynamic> map) {
    return FinningMachineRecord()
      ..typeOfFinning = map["typeOfFinning"] ?? ""
      ..projectName = map["projectName"] ?? ""
      ..tubeSize = map["tubeSize"] ?? ""
      ..quantity = map["quantity"] ?? ""
      ..newOrRework = map["newOrRework"] ?? ""
      ..machineStart = map["machineStart"] ?? ""
      ..machineEnd = map["machineEnd"] ?? ""
      ..downCode = map["downCode"] ?? "None"
      ..downStart = map["downStart"] ?? ""
      ..downEnd = map["downEnd"] ?? "";
  }
}
