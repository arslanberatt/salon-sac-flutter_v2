import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/admin/admin_bindings.dart';
import 'package:salon_sac_flutter_v2/modules/admin/admin_page.dart';
import 'package:salon_sac_flutter_v2/modules/advance/advance_page.dart';
import 'package:salon_sac_flutter_v2/modules/advance_request/advance_request_page.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/appointment_detail_page.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/appointment_page.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/update_appointment_page.dart';
import 'package:salon_sac_flutter_v2/modules/calendar/calendar_page.dart';
import 'package:salon_sac_flutter_v2/modules/employe_list/employee_list_page.dart';
import 'package:salon_sac_flutter_v2/modules/employee/employee_bindings.dart';
import 'package:salon_sac_flutter_v2/modules/employee/employee_page.dart';
import 'package:salon_sac_flutter_v2/modules/employee_history/employee_history_page.dart';
import 'package:salon_sac_flutter_v2/modules/employee_managment/employee_managment_page.dart';
import 'package:salon_sac_flutter_v2/modules/login/login_bindings.dart';
import 'package:salon_sac_flutter_v2/modules/login/login_page.dart';
import 'package:salon_sac_flutter_v2/modules/privacy/privacy_page.dart';
import 'package:salon_sac_flutter_v2/modules/profile/change_password_page.dart';
import 'package:salon_sac_flutter_v2/modules/profile/profile_page.dart';
import 'package:salon_sac_flutter_v2/modules/profile/update_profile_page.dart';
import 'package:salon_sac_flutter_v2/modules/register/register_bindings.dart';
import 'package:salon_sac_flutter_v2/modules/register/register_page.dart';
import 'package:salon_sac_flutter_v2/modules/reset_password/forgot_password_page.dart';
import 'package:salon_sac_flutter_v2/modules/reset_password/reset_code_page.dart';
import 'package:salon_sac_flutter_v2/modules/reset_password/reset_password_page.dart';
import 'package:salon_sac_flutter_v2/modules/service/service_page.dart';
import 'package:salon_sac_flutter_v2/modules/service/update_service_page.dart';
import 'package:salon_sac_flutter_v2/modules/setting/setting_page.dart';
import 'package:salon_sac_flutter_v2/modules/splash/splash_bindings.dart';
import 'package:salon_sac_flutter_v2/modules/splash/splash_page.dart';
import 'package:salon_sac_flutter_v2/modules/support/support_page.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/transaction_page.dart';
import 'package:salon_sac_flutter_v2/modules/transaction_dashboard/transaction_dashboard_page.dart';

abstract class AppRoutes {
  static const INITIAL = SPLASH;
  static const SPLASH = '/splash';
  static const REGISTER = '/register';
  static const LOGIN = '/login';
  static const ADMIN = '/admin';
  static const EMPLOYEE = '/employee';
  static const UPDATEPROFILE = '/update-profile';
  static const SETTING = '/setting';
  static const TRANSACTION = '/transaction';
  static const TRANSACTIONDASHBOARD = '/transaction-dashboard';
  static const PROFILE = '/profile';
  static const SERVICE = '/service';
  static const UPDATESERVICE = '/update-service';
  static const CHANGEPASSWORD = '/change-password';
  static const SUPPORT = '/support';
  static const PRIVACY = '/privacy';
  static const EMPLOYEELIST = '/employee-list';
  static const EMPLOYEEMANAGEMENT = '/employee-management';
  static const APPOINTMENT = '/appointment';
  static const CALENDAR = '/calendar';
  static const APPOINTMENTDETAIL = '/appointment-detail';
  static const UPDATEAPPOINTMENT = '/appointment-appointment';
  static const EMPLOYEEHISTORY = '/employe-history';
  static const RESETPASSWORD = '/reset-password';
  static const RESETCODE = '/reset-code';
  static const FORGOTPASSWORD = '/forgot-password';
  static const ADVANCE = '/advance';
  static const ADVANCEREQUEST = '/advance-request';
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
    GetPage(name: AppRoutes.TRANSACTION, page: () => TransactionPage()),
    GetPage(
      name: AppRoutes.TRANSACTIONDASHBOARD,
      page: () => TransactionDashboardPage(),
    ),
    GetPage(name: AppRoutes.UPDATEPROFILE, page: () => UpdateProfilePage()),
    GetPage(name: AppRoutes.PROFILE, page: () => ProfilePage()),
    GetPage(name: AppRoutes.SETTING, page: () => SettingPage()),
    GetPage(name: AppRoutes.SERVICE, page: () => ServicePage()),
    GetPage(name: AppRoutes.UPDATESERVICE, page: () => UpdateServicePage()),
    GetPage(name: AppRoutes.SUPPORT, page: () => SupportPage()),
    GetPage(name: AppRoutes.CHANGEPASSWORD, page: () => ChangePasswordPage()),
    GetPage(name: AppRoutes.PRIVACY, page: () => PrivacyTermsPage()),
    GetPage(name: AppRoutes.APPOINTMENT, page: () => AppointmentPage()),
    GetPage(name: AppRoutes.CALENDAR, page: () => CalendarPage()),
    GetPage(
      name: AppRoutes.UPDATEAPPOINTMENT,
      page: () => UpdateAppointmentPage(),
    ),
    GetPage(
      name: AppRoutes.APPOINTMENTDETAIL,
      page: () => AppointmentDetailPage(),
    ),
    GetPage(
      name: AppRoutes.EMPLOYEEMANAGEMENT,
      page: () => EmployeeManagmentPage(),
    ),
    GetPage(name: AppRoutes.EMPLOYEELIST, page: () => EmployeeListPage()),
    GetPage(name: AppRoutes.EMPLOYEEHISTORY, page: () => EmployeeHistoryPage()),
    GetPage(name: AppRoutes.FORGOTPASSWORD, page: () => ForgotPasswordPage()),
    GetPage(name: AppRoutes.RESETPASSWORD, page: () => ResetPasswordPage()),
    GetPage(name: AppRoutes.RESETCODE, page: () => ResetCodePage()),
    GetPage(name: AppRoutes.ADVANCE, page: () => AdvancePage()),
    GetPage(name: AppRoutes.ADVANCEREQUEST, page: () => AdvanceRequestPage()),
  ];
}
