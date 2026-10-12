import '../data/dropdown_data.dart';
import 'preferences_service.dart';

class DropdownLoader {
  static Future<void> loadAll() async {
    try {
      operators = await PreferencesService.loadList("operators");
      vmcOperations = await PreferencesService.loadList("vmc_operations");
      finningTubeSizes = await PreferencesService.loadList("finning_sizes");
      punchingModelNumbers = await PreferencesService.loadList(
        "punching_models",
      );
      bendingPlateThicknesses = await PreferencesService.loadList(
        "bending_thickness",
      );
    } catch (e) {
      print("Firestore Error: $e");
    }

    if (operators.isEmpty) {
      operators = ["Operator 1"];
    }

    if (vmcOperations.isEmpty) {
      vmcOperations = ["A", "B", "C"];
    }

    if (finningTubeSizes.isEmpty) {
      finningTubeSizes = ["A", "B", "C"];
    }

    if (punchingModelNumbers.isEmpty) {
      punchingModelNumbers = ["A", "B", "C"];
    }

    if (bendingPlateThicknesses.isEmpty) {
      bendingPlateThicknesses = ["A", "B", "C"];
    }
  }
}
