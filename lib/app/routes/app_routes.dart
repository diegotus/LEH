part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  static const ROOT = _Paths.ROOT;
  static const CONNECTION = _Paths.CONNECTION;
  static const CONNECTIONHOME = _Paths.CONNECTION + _Paths.CONNECTIONHOME;
  static const LOGIN = _Paths.CONNECTION + _Paths.LOGIN;
  static const SIGNUP = _Paths.CONNECTION + _Paths.SIGNUP;

  static const FORGET_PASSWORD_ROOT = _Paths.FORGET_PASSWORD_ROOT;
  static const FORGET_PASSWORD =
      _Paths.FORGET_PASSWORD_ROOT + _Paths.FORGET_PASSWORD;
  static const FORGET_PASSWORD_OTP =
      _Paths.FORGET_PASSWORD_ROOT + _Paths.FORGET_PASSWORD_OTP;
  static const LOTRI = _Paths.LOTRI;
  static const HOME = _Paths.LOTRI + _Paths.HOME;
  static const GAMES = _Paths.LOTRI + _Paths.GAMES;
  static const TICKETS = _Paths.LOTRI + _Paths.TICKETS;
  static const LOTO_RESULTS = _Paths.LOTRI + _Paths.LOTO_RESULTS;
  static String LOTO_GAME(String productId) => "$GAMES/$productId";
  static const TRANSACTIONS = _Paths.TRANSACTIONS;
  static const CASH_IN = _Paths.TRANSACTIONS + _Paths.CASH_IN;
  static const CASH_OUT = _Paths.TRANSACTIONS + _Paths.CASH_OUT;
  static const RECEIVE_MONEY = _Paths.TRANSACTIONS + _Paths.RECEIVE_MONEY;
  static const SEND_MONEY = _Paths.TRANSACTIONS + _Paths.SEND_MONEY;
  static const TRANSACTION_RECEIPT =
      _Paths.TRANSACTIONS + _Paths.TRANSACTION_RECEIPT;
  static const TRANSACTION_DETAILS =
      _Paths.TRANSACTIONS + _Paths.TRANSACTION_DETAILS;
  static const SETTINGS = _Paths.SETTINGS;
  static const CHANGE_PASSWORD = _Paths.SETTINGS + _Paths.CHANGE_PASSWORD;
  static const EDIT_PROFIL = _Paths.SETTINGS + _Paths.EDIT_PROFIL;
  static const TCHALA = _Paths.TCHALA;
}

abstract class _Paths {
  _Paths._();
  static const ROOT = '/';
  static const CONNECTION = '/connection';
  static const CONNECTIONHOME = '/connection';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const FORGET_PASSWORD_ROOT = '/forget-password';
  static const FORGET_PASSWORD = '/page';
  static const FORGET_PASSWORD_OTP = '/OTP';
  static const LOTRI = '/lotri';
  static const HOME = '/home';
  static const GAMES = '/games';
  static const TICKETS = '/tickets';
  static const LOTO_RESULTS = '/loto-results';
  static const LOTO_GAME = '/:type_game';
  static const TRANSACTIONS = '/transactions';
  static const CASH_IN = '/cash-in';
  static const CASH_OUT = '/cash-out';
  static const RECEIVE_MONEY = '/receive-money';
  static const SEND_MONEY = '/send-money';
  static const TRANSACTION_RECEIPT = '/receipt';
  static const TRANSACTION_DETAILS = '/details';
  static const CHANGE_PASSWORD = '/change-password';
  static const SETTINGS = '/settings';
  static const EDIT_PROFIL = "/edit_profil";
  static const TCHALA = '/tchala';
}
