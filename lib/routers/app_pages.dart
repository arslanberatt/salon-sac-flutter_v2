import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/admin/admin_bindings.dart';
import 'package:salon_sac_flutter_v2/modules/admin/admin_page.dart';
import 'package:salon_sac_flutter_v2/modules/employee/employee_bindings.dart';
import 'package:salon_sac_flutter_v2/modules/employee/employee_page.dart';
import 'package:salon_sac_flutter_v2/modules/login/login_bindings.dart';
import 'package:salon_sac_flutter_v2/modules/login/login_page.dart';
import 'package:salon_sac_flutter_v2/modules/register/register_bindings.dart';
import 'package:salon_sac_flutter_v2/modules/register/register_page.dart';
import 'package:salon_sac_flutter_v2/modules/setting/setting_page.dart';
import 'package:salon_sac_flutter_v2/modules/splash/splash_bindings.dart';
import 'package:salon_sac_flutter_v2/modules/splash/splash_page.dart';

abstract class AppRoutes {
  static const INITIAL = SPLASH;
  static const SPLASH = '/splash';
  static const REGISTER = '/register';
  static const LOGIN = '/login';
  static const ADMIN = '/admin';
  static const EMPLOYEE = '/employee';
  static const PROFILE = '/profile';
  static const SETTING = '/setting';
  static const TRANSACTION = '/transaction';
}

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBindings(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: AppRoutes.ADMIN,
      page: () => AdminPage(),
      binding: AdminBindings(),
    ),
    GetPage(
      name: AppRoutes.EMPLOYEE,
      page: () => EmployeePage(),
      binding: EmployeeBindings(),
    ),
    GetPage(name: AppRoutes.TRANSACTION, page: () => EmployeePage()),
    GetPage(name: AppRoutes.SETTING, page: () => SettingPage()),
  ];
}
