class ProductionRecord {
  String jobDescription;
  String rev;
  String quantity;

  String loadingStart;
  String loadingEnd;

  String machineStart;
  String machineEnd;

  String downCode;

  String downStart;
  String downEnd;

  String operation;

  ProductionRecord({
    this.jobDescription = '',
    this.rev = '',
    this.operation = '',
    this.quantity = '',
    this.loadingStart = '',
    this.loadingEnd = '',
    this.machineStart = '',
    this.machineEnd = '',
    this.downCode = 'None',
    this.downStart = '',
    this.downEnd = '',
  });
  Map<String, dynamic> toMap() {
    return {
      "jobDescription": jobDescription,
      "rev": rev,
      "operation": operation,
      "quantity": quantity,
      "loadingStart": loadingStart,
      "loadingEnd": loadingEnd,
      "machineStart": machineStart,
      "machineEnd": machineEnd,
      "downCode": downCode,
      "downStart": downStart,
      "downEnd": downEnd,
    };
  }

  factory ProductionRecord.fromMap(Map<String, dynamic> map) {
    return ProductionRecord(
      jobDescription: map["jobDescription"] ?? "",
      rev: map["rev"] ?? "",
      operation: map["operation"] ?? "",
      quantity: map["quantity"] ?? "",
      loadingStart: map["loadingStart"] ?? "",
      loadingEnd: map["loadingEnd"] ?? "",
      machineStart: map["machineStart"] ?? "",
      machineEnd: map["machineEnd"] ?? "",
      downCode: map["downCode"] ?? "None",
      downStart: map["downStart"] ?? "",
      downEnd: map["downEnd"] ?? "",
    );
  }
}
