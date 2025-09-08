import 'package:flutter/material.dart';
import '../../features/splash/view/splash_page.dart';
import '../../features/animation/view/animation_page.dart';
import '../../features/auth/view/auth_page.dart';
import '../../features/auth/view/login_page.dart';
import '../../features/auth/view/signup_page.dart';
import '../../features/auth/view/forgot_password_page.dart';
import '../../features/auth/view/otp_page.dart';
import '../../features/auth/view/reset_password_page.dart';
import '../../features/navigation/view/main_navigation_page.dart';
import '../../features/account/view/account_information_page.dart';
import '../../features/account/view/edit_information_page.dart';
import '../../features/account/view/edit_password_page.dart';
import '../../features/help/view/help_support_page.dart';
import '../../features/terms/view/terms_condition_page.dart';
import '../../features/privacy/view/privacy_policy_page.dart';
import '../../features/events/view/create_event_page.dart';
import '../../features/events/view/event_details_page.dart';
import '../../features/events/view/edit_event_page.dart';
import '../../features/settings/view/settings_page.dart';
import '../../features/reminders/view/reminders_page.dart';
import '../../features/home/view/home_page.dart';
import '../../features/events/view/events_page.dart';
import '../../features/finances/view/finances_page.dart';
import '../../features/finance_history/view/finance_history_page.dart';
import '../../features/finances_view/view/finances_view_page.dart';
import '../../features/edit_financial_details/view/edit_financial_details_page.dart';
import '../../features/feedback/view/feedback_page.dart';
import '../../features/search/view/search_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String animation = '/animation';
  static const String auth = '/auth';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String otp = '/otp';
  static const String resetPassword = '/reset-password';
  static const String mainNavigation = '/main';
  static const String accountInformation = '/account-information';
  static const String editInformation = '/edit-information';
  static const String editPassword = '/edit-password';
  static const String helpSupport = '/help-support';
  static const String termsCondition = '/terms-condition';
  static const String privacyPolicy = '/privacy-policy';
  static const String createEvent = '/create-event';
  static const String eventDetails = '/event-details';
  static const String editEvent = '/edit-event';
  static const String settings = '/settings';
  static const String reminders = '/reminders';
  static const String home = '/home';
  static const String events = '/events';
  static const String finances = '/finances';
  static const String financeHistory = '/finance-history';
  static const String financesView = '/finances-view';
  static const String editFinancialDetails = '/edit-financial-details';
  static const String feedback = '/feedback';
  static const String search = '/search';

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState? get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );
      case animation:
        return MaterialPageRoute(
          builder: (_) => const AnimationPage(),
          settings: settings,
        );
      case auth:
        return MaterialPageRoute(
          builder: (_) => const AuthPage(),
          settings: settings,
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
      case signup:
        return MaterialPageRoute(
          builder: (_) => const SignUpPage(),
          settings: settings,
        );
      case forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordPage(),
          settings: settings,
        );
      case otp:
        final email = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => OtpPage(email: email),
          settings: settings,
        );
      case resetPassword:
        final email = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => ResetPasswordPage(email: email),
          settings: settings,
        );
      case mainNavigation:
        final args = settings.arguments as Map<String, dynamic>?;
        final initialIndex = args?['initialIndex'] as int? ?? 0;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => 
            MainNavigationPage(initialIndex: initialIndex),
          settings: settings,
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      case accountInformation:
        return MaterialPageRoute(
          builder: (_) => const AccountInformationPage(),
          settings: settings,
        );
      case editInformation:
        final args = settings.arguments as Map<String, String?>? ?? {};
        return MaterialPageRoute(
          builder: (_) => EditInformationPage(
            name: args['name'],
            email: args['email'],
            birthDate: args['birthDate'],
            city: args['city'],
          ),
          settings: settings,
        );
      case editPassword:
        return MaterialPageRoute(
          builder: (_) => const EditPasswordPage(),
          settings: settings,
        );
      case helpSupport:
        return MaterialPageRoute(
          builder: (_) => const HelpSupportPage(),
          settings: settings,
        );
      case termsCondition:
        return MaterialPageRoute(
          builder: (_) => const TermsConditionPage(),
          settings: settings,
        );
      case privacyPolicy:
        return MaterialPageRoute(
          builder: (_) => const PrivacyPolicyPage(),
          settings: settings,
        );
      case createEvent:
        return MaterialPageRoute(
          builder: (_) => const CreateEventPage(),
          settings: settings,
        );
      case eventDetails:
        final eventId = settings.arguments as String? ?? '1';
        return MaterialPageRoute(
          builder: (_) => EventDetailsPage(eventId: eventId),
          settings: settings,
        );
      case editEvent:
        final eventId = settings.arguments as String? ?? '1';
        return MaterialPageRoute(
          builder: (_) => EditEventPage(eventId: eventId),
          settings: settings,
        );
      case '/settings':
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
          settings: settings,
        );
      case reminders:
        return MaterialPageRoute(
          builder: (_) => const RemindersPage(),
          settings: settings,
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      case events:
        return MaterialPageRoute(
          builder: (_) => const EventsPage(),
          settings: settings,
        );
      case finances:
        return MaterialPageRoute(
          builder: (_) => const FinancesPage(),
          settings: settings,
        );
      case financeHistory:
        return MaterialPageRoute(
          builder: (_) => const FinanceHistoryPage(),
          settings: settings,
        );
      case financesView:
        final args = settings.arguments as Map<String, dynamic>?;
        final eventId = args?['eventId'] as String?;
        return MaterialPageRoute(
          builder: (_) => FinancesViewPage(eventId: eventId),
          settings: settings,
        );
      case editFinancialDetails:
        final args = settings.arguments as Map<String, dynamic>?;
        final financialDetailsId = args?['financialDetailsId'] as String?;
        return MaterialPageRoute(
          builder: (_) => EditFinancialDetailsPage(financialDetailsId: financialDetailsId),
          settings: settings,
        );
      case feedback:
        return MaterialPageRoute(
          builder: (_) => const FeedbackPage(),
          settings: settings,
        );
      case search:
        return MaterialPageRoute(
          builder: (_) => const SearchPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );
    }
  }

  static Future<dynamic> navigateToAnimation() {
    return navigator!.pushReplacementNamed(animation);
  }

  static Future<dynamic> navigateToAuth() {
    return navigator!.pushReplacementNamed(auth);
  }

  static Future<dynamic> navigateToMain({int initialIndex = 0}) {
    return navigator!.pushNamedAndRemoveUntil(
      mainNavigation,
      (route) => false,
      arguments: {'initialIndex': initialIndex},
    );
  }

  static Future<dynamic> navigateToLogin() {
    return navigator!.pushNamed(login);
  }

  static Future<dynamic> navigateToSignUp() {
    return navigator!.pushNamed(signup);
  }

  static Future<dynamic> navigateToForgotPassword() {
    return navigator!.pushNamed(forgotPassword);
  }

  static Future<dynamic> navigateToOtp(String email) {
    return navigator!.pushNamed(otp, arguments: email);
  }

  static Future<dynamic> navigateToResetPassword(String email) {
    return navigator!.pushNamed(resetPassword, arguments: email);
  }

  static Future<dynamic> navigateToAccountInformation() {
    return navigator!.pushNamed(accountInformation);
  }

  static Future<dynamic> navigateToEditInformation({
    String? name,
    String? email,
    String? birthDate,
    String? city,
  }) {
    return navigator!.pushNamed(
      editInformation,
      arguments: {
        'name': name,
        'email': email,
        'birthDate': birthDate,
        'city': city,
      },
    );
  }

  static Future<dynamic> navigateToEditPassword() {
    return navigator!.pushNamed(editPassword);
  }

  static Future<dynamic> navigateToHelpSupport() {
    return navigator!.pushNamed(helpSupport);
  }

  static Future<dynamic> navigateToTermsCondition() {
    return navigator!.pushNamed(termsCondition);
  }

  static Future<dynamic> navigateToPrivacyPolicy() {
    return navigator!.pushNamed(privacyPolicy);
  }

  static Future<dynamic> navigateToCreateEvent() {
    return navigator!.pushNamed(createEvent);
  }

  static Future<dynamic> navigateToEventDetails(String eventId) {
    return navigator!.pushNamed(eventDetails, arguments: eventId);
  }

  static Future<dynamic> navigateToEditEvent(String eventId) {
    return navigator!.pushNamed(editEvent, arguments: eventId);
  }

  static Future<dynamic> navigateToSettings() {
    return navigator!.pushNamed(settings);
  }

  static Future<dynamic> navigateToReminders() {
    return navigator!.pushNamed(reminders);
  }

  static Future<dynamic> navigateToHome() {
    return navigator!.pushNamed(home);
  }

  static Future<dynamic> navigateToEvents() {
    return navigator!.pushNamed(events);
  }

  static Future<dynamic> navigateToFinances() {
    return navigator!.pushNamed(finances);
  }

  static Future<dynamic> navigateToFinanceHistory() {
    return navigator!.pushNamed(financeHistory);
  }

  static Future<dynamic> navigateToFinancesView({String? eventId}) {
    return navigator!.pushNamed(
      financesView,
      arguments: {'eventId': eventId},
    );
  }

  static Future<dynamic> navigateToEditFinancialDetails({String? financialDetailsId}) {
    return navigator!.pushNamed(
      editFinancialDetails,
      arguments: {'financialDetailsId': financialDetailsId},
    );
  }

  static Future<dynamic> navigateToFeedback() {
    return navigator!.pushNamed(feedback);
  }

  static Future<dynamic> navigateToSearch() {
    return navigator!.pushNamed(search);
  }

  static void goBack() {
    if (navigator!.canPop()) {
      navigator!.pop();
    }
  }

  static void goToHome() {
    navigator!.popUntil((route) => route.isFirst);
  }
}
