import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_salary.dart';
import 'package:salon_sac_flutter_v2/models/app_user.dart';
import 'package:salon_sac_flutter_v2/repositories/salary_repository.dart';
import 'package:salon_sac_flutter_v2/services/auth_service.dart';

class BalanceController extends BaseController {
  final SalaryRepository _salaryRepository = Get.find();
  final AuthService _auth = Get.find();

  final salaries = <AppSalary>[].obs;

  final fullName = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;

  Map<String, double> monthlyBonus = {};
  Map<String, double> monthlyAdvance = {};
  Map<String, double> monthlySalary = {};

  AppUser? get user => _auth.currentUser.value;

  double get totalFixedSalary => user?.salary?.toDouble() ?? 0;
  double get prim => user?.commissionRate?.toDouble() ?? 0;

  double get totalBonus => _sumAmountByType('prim');
  double get totalAdvance => _sumAmountByType('avans');
  double get totalSalary => _sumAmountByType('maas');

  double get netBalance => totalFixedSalary + totalBonus - totalAdvance;

  double get percentage {
    return prim;
  }

  @override
  void onInit() {
    super.onInit();
    loadBalanceData();
    _setUserInfo();
  }

  Future<void> loadBalanceData() async {
    try {
      setLoading(true);
      final result = await _salaryRepository.getMySalaries();

      final now = DateTime.now();
      final threeMonthsAgo = DateTime(now.year, now.month - 2, 1);

      final filtered = result.where((s) {
        final date = s.date;
        return date != null && date.isAfter(threeMonthsAgo);
      }).toList();

      salaries.assignAll(filtered);
      _calculateMonthlyTotals(filtered);
    } catch (e) {
      showErrorSnackbar(message: 'Bakiye verileri yüklenemedi');
    } finally {
      setLoading(false);
    }
  }

  void _calculateMonthlyTotals(List<AppSalary> data) {
    monthlyBonus.clear();
    monthlyAdvance.clear();
    monthlySalary.clear();

    for (final s in data) {
      if (s.date == null || s.amount == null) continue;

      final key = '${s.date!.year}-${s.date!.month.toString().padLeft(2, '0')}';

      if (s.type == 'prim') {
        monthlyBonus[key] = (monthlyBonus[key] ?? 0) + s.amount!;
      } else if (s.type == 'avans') {
        monthlyAdvance[key] = (monthlyAdvance[key] ?? 0) + s.amount!;
      } else if (s.type == 'maas') {
        monthlySalary[key] = (monthlySalary[key] ?? 0) + s.amount!;
      }
    }
  }

  void _setUserInfo() {
    final u = user;
    fullName.value = '${u?.name ?? ''} ${u?.lastname ?? ''}';
    email.value = u?.email ?? '';
    phone.value = u?.phone ?? '';
  }

  double _sumAmountByType(String type) {
    return salaries
        .where((s) => s.type == type)
        .fold(0.0, (sum, r) => sum + (r.amount ?? 0));
  }
}
