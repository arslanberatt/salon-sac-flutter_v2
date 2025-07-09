import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_salary.dart';
import 'package:salon_sac_flutter_v2/repositories/salary_repository.dart';

class SalaryController extends BaseController {
  final SalaryRepository _salaryRepository = Get.find();

  final salaries = <AppSalary>[].obs;

  double get totalBonus => _sumAmountByType('prim');
  double get totalAdvance => _sumAmountByType('avans');
  double get totalSalary => _sumAmountByType('maas');

  @override
  void onInit() {
    super.onInit();
    loadMySalaryRecords();
  }

  Future<void> loadMySalaryRecords() async {
    try {
      setLoading(true);
      final result = await _salaryRepository.getMySalaries();

      final now = DateTime.now();
      final threeMonthsAgo = DateTime(
        now.year,
        now.month - 2,
        1,
      ); // bu ay dahil son 3 ay

      final filtered = result.where((s) {
        final date = s.date;
        return date != null && date.isAfter(threeMonthsAgo);
      }).toList();

      salaries.assignAll(filtered);
    } catch (e) {
      print(e);
      showErrorSnackbar(message: "İşlem geçmişi yüklenirken hata oluştu");
    } finally {
      setLoading(false);
    }
  }

  double _sumAmountByType(String type) {
    return salaries
        .where((s) => s.type == type)
        .fold(0.0, (sum, r) => sum + (r.amount ?? 0));
  }
}
