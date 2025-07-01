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
      final dataMap = response.data['data'] as Map<String, dynamic>;
      final rawList = (dataMap['transactions'] as List<dynamic>?) ?? [];
      final transactions = rawList
          .map((e) => AppTransaction.fromJson(e))
          .toList();
      return transactions;
    }
    throw Exception('Transactionlar getirilirken bir hata oluştu');
  }

  Future<AppTransaction> createTransaction(AppTransaction transaction) async {
    final response = await _apiServices.post(
      ApiConstants.createTransaction,
      data: transaction.toJson(),
    );
    if (response.statusCode == 201) {
      return AppTransaction.fromJson(response.data);
    }
    throw Exception('Transactionlar eklenirken bir hata oluştu');
  }

  Future<AppTransaction?> cancelTransaction(String id) async {
    final res = await _apiServices.put(
      '${ApiConstants.cancelTransaction}/$id',
      options: Options(
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    if (res.statusCode == 200 && res.data['data'] != null) {
      return AppTransaction.fromJson(res.data['data']);
    } else if (res.statusCode == 404) {
      print('İşlem bulunamadı veya zaten iptal edilmiş.');
      return null;
    } else {
      print('Sunucu hatası: ${res.statusCode}');
      return null;
    }
  }
}
