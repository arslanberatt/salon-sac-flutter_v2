import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/models/app_transaction.dart';
import 'package:salon_sac_flutter_v2/services/api_service.dart';

class TransactionRepository extends GetxService {
  late final ApiServices _apiServices;

  @override
  void onInit() {
    super.onInit();
    _apiServices = Get.find<ApiServices>();
  }

  Future<List<AppTransaction>> getTransactions() async {
    final response = await _apiServices.get(ApiConstants.transactions);
    if (response.statusCode == 200) {
      final data = response.data['data'];
      if (data is List) {
        return data.map((e) => AppTransaction.fromJson(e)).toList();
      }
      throw Exception('Beklenmeyen data formatı: ${data.runtimeType}');
    }
    throw Exception('Transactionlar getirilirken bir hata oluştu');
  }

  Future<void> createTransaction(AppTransaction transaction) async {
    final response = await _apiServices.post(
      ApiConstants.createTransaction,
      data: transaction.toJson(),
    );

    if (response.statusCode == 201) {
      return;
    }

    throw Exception('Transaction eklenirken bir hata oluştu');
  }

  Future<AppTransaction?> cancelTransaction(String id) async {
    final res = await _apiServices.put(
      '${ApiConstants.cancelTransaction}/$id',
      options: Options(validateStatus: (status) => status! < 500),
    );
    if (res.statusCode == 200) {
      final data = res.data['data'];

      if (data is Map<String, dynamic>) {
        return AppTransaction.fromJson(data);
      } else {
        return null;
      }
    }
    return null;
  }
}
