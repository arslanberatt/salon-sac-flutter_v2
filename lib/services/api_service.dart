import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:salon_sac_flutter_v2/services/storage_service.dart';

abstract class ApiConstants {
  static const String baseUrl =
      'https://salonsacserverv2-production.up.railway.app';

  // Auth
  static const String login = '/api/login';
  static const String register = '/api/register';
  static const String forgetPassword = '/api/forget-password';
  static const String resetPassword = '/api/reset-password';

  // User
  static const String profile = '/api/me';
  static const String updateProfile = '/api/update-user';
  static const String activeUsers = '/api/active';
  static const String passiveUsers = '/api/passive';
  static const String updateUser = '/api/users/';

  // Transactions
  static const String transactions = '/api/transactions';
  static const String createTransaction = '/api/add-transaction';
  static const String cancelTransaction = '/api/cancel-transaction';

  // Categories (TransactionCategory)
  static const String categories = '/api/categories';
  static const String createCategory = '/api/add-category';
  static const String updateCategory = '/api/update-category';

  // Services
  static const String services = '/api/services';
  static const String createService = '/api/create-service';
  static const String updateService = '/api/update-service';

  // // Appointments
  static const String appointments = '/api/appointments';
  static const String createAppointment = '/api/create-appointment';
  static const String markAsDone = '/api/mark-as-done';
  static const String cancelAppointment = '/api/cancel';
  static const String updateAppointments = '/api/update-appointment';

  // // Salary
  // static const String mySalaryRecords = '/my-salary-records';
  // static const String allSalaryRecords = '/salary-records';
  // static const String salaryAdd = '/salary-record';

  // // Advance
  // static const String requestAdvance = '/advance-request';
  // static const String myAdvanceRequests = '/my-advance-requests';
  // static const String allAdvanceRequests = '/all-advance-requests';
}

class ApiServices extends GetxService {
  late StorageService _storageService;
  late Dio _dio;

  Future<ApiServices> init() async {
    _storageService = Get.find<StorageService>();
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        contentType: "application/json",
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = _storageService.getValue<String>(StorageKeys.userToken);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _storageService.remove(StorageKeys.userToken);
          }
          return handler.next(error);
        },
      ),
    );
    return this;
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      print('Dio hata verdi $e');
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      if (e is DioException) {
        print('HATA DATA: ${e.response?.data}');
      }
      rethrow;
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      print('Dio hata verdi $e');
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      print('Dio hata verdi $e');
      rethrow;
    }
  }

  Future<Response> register({
    required String name,
    required String lastname,
    required String email,
    required String phone,
    required String password,
  }) async {
    final data = {
      "name": name,
      "lastname": lastname,
      "email": email,
      "phone": phone,
      "password": password,
    };

    return await post(
      ApiConstants.register,
      data: data,
      options: Options(contentType: 'application/json'), // bunu kullan
    );
  }
}
