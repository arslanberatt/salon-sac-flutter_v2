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
      var listOfData = response.data['transactions'] as List;
      return listOfData
          .map((transaction) => AppTransaction.fromJson(transaction))
          .toList();
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

  Future<AppTransaction> cancelTransaction(String id) async {
    final response = await _apiServices.put(
      '${ApiConstants.cancelTransaction}/$id',
    );
    if (response.statusCode == 200) {
      return AppTransaction.fromJson(response.data["data"]);
    }
    throw Exception('Transaction iptal edilirken bir hata oluştu');
  }
}
