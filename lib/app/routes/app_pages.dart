import 'package:get/get.dart';

import '../data/middleware/auth_gard.dart';
import '../data/middleware/transaction_detail_gard.dart';
import '../modules/connection/bindings/connection_binding.dart';
import '../modules/connection/forgetPassword/bindings/forget_password_binding.dart';
import '../modules/connection/forgetPassword/views/forget_password_view.dart';
import '../modules/connection/login/bindings/login_binding.dart';
import '../modules/connection/login/views/login_view.dart';
import '../modules/connection/signup/bindings/signup_binding.dart';
import '../modules/connection/signup/views/signup_view.dart';
import '../modules/connection/views/connection_view.dart';
import '../modules/games/bindings/games_binding.dart';
import '../modules/games/views/games_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/lotoGame/bindings/play_game_binding.dart';
import '../modules/lotoGame/views/play_game_view.dart';
import '../modules/lotoResults/bindings/loto_results_binding.dart';
import '../modules/lotoResults/views/loto_results_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/changePassword/bindings/change_password_binding.dart';
import '../modules/profile/changePassword/views/change_password_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/tickets/bindings/tickets_binding.dart';
import '../modules/tickets/views/tickets_view.dart';
import '../modules/transactions/bindings/transactions_binding.dart';
import '../modules/transactions/cashIn/bindings/cash_in_binding.dart';
import '../modules/transactions/cashIn/views/cash_in_view.dart';
import '../modules/transactions/cashOut/bindings/cash_out_binding.dart';
import '../modules/transactions/cashOut/views/cash_out_view.dart';
import '../modules/transactions/receipt/bindings/receipt_binding.dart';
import '../modules/transactions/receipt/views/receipt_view.dart';
import '../modules/transactions/receiveMoney/bindings/receive_money_binding.dart';
import '../modules/transactions/receiveMoney/views/receive_money_view.dart';
import '../modules/transactions/sendMoney/bindings/send_money_binding.dart';
import '../modules/transactions/sendMoney/views/send_money_view.dart';
import '../modules/transactions/transactionDetails/bindings/transaction_details_binding.dart';
import '../modules/transactions/transactionDetails/views/transaction_details_view.dart';
import '../modules/transactions/transactionHistory/bindings/transaction_history_binding.dart';
import '../modules/transactions/transactionHistory/views/transaction_history_view.dart';
import '../modules/transactions/transactionReceipt/bindings/transaction_receipt_binding.dart';
import '../modules/transactions/transactionReceipt/views/transaction_receipt_view.dart';
import '../modules/transactions/views/transactions_view.dart';
import '../views/views/lotri_view.dart';
import '../views/views/root_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CONNECTION;

  static final routes = [
    GetPage(
      name: _Paths.ROOT,
      page: () => RootView(),
      participatesInRootNavigator: true,
      preventDuplicates: true,
      middlewares: [EnsureNotAuthentificated()],
      children: [
        GetPage(
          name: _Paths.LOTRI,
          page: () => const LotriView(),
          // binding: HomeBinding(),
          middlewares: [EnsureAuthentificated()],
          // participatesInRootNavigator: true,
          preventDuplicates: true,
          children: [
            GetPage(
              name: _Paths.HOME,
              page: () => const HomeView(),
              // participatesInRootNavigator: false,
              binding: HomeBinding(),
              preventDuplicates: true,
            ),
            GetPage(
              name: _Paths.GAMES,
              page: () => const GamesView(),
              binding: GamesBinding(),
              transition: Transition.noTransition,
              children: [
                GetPage(
                  name: _Paths.LOTO_GAME,
                  page: () => const PlayGame(),
                  binding: PlayGameBinding(),
                  // inheritParentPath: false,
                  participatesInRootNavigator: true,
                  transition: Transition.noTransition,
                ),
              ],
            ),
            GetPage(
              name: _Paths.TICKETS,
              page: () => const TicketsView(),
              binding: TicketsBinding(),
              transition: Transition.noTransition,
            ),
            GetPage(
              name: _Paths.LOTO_RESULTS,
              page: () => const LotoResultsView(),
              binding: LotoResultsBinding(),
              transition: Transition.noTransition,
            ),
          ],
        ),
        GetPage(
            name: _Paths.PROFILE,
            page: () => const ProfileView(),
            binding: ProfileBinding(),
            children: [
              GetPage(
                name: _Paths.CHANGE_PASSWORD,
                page: () => const ChangePasswordView(),
                binding: ChangePasswordBinding(),
                participatesInRootNavigator: true,
              )
            ]),
        GetPage(
          name: _Paths.TRANSACTIONS,
          page: () => const TransactionsView(),
          binding: TransactionsBinding(),
          preventDuplicates: true,
          participatesInRootNavigator: false,
          children: [
            GetPage(
              name: _Paths.TRANSACTION_HISTORY,
              page: () => const TransactionHistoryView(),
              binding: TransactionHistoryBinding(),
            ),
            GetPage(
              name: _Paths.CASH_IN,
              page: () => const CashInView(),
              binding: CashInBinding(),
              // participatesInRootNavigator: true,chi
            ),
            GetPage(
              name: _Paths.CASH_OUT,
              page: () => const CashOutView(),
              binding: CashOutBinding(),
              // participatesInRootNavigator: true,
            ),
            GetPage(
              name: _Paths.RECEIVE_MONEY,
              page: () => const ReceiveMoneyView(),
              middlewares: [EnsureAuthentificated()],
              binding: ReceiveMoneyBinding(),
              // participatesInRootNavigator: true,
            ),
            GetPage(
              name: _Paths.SEND_MONEY,
              page: () => const SendMoneyView(),
              binding: SendMoneyBinding(),
              // participatesInRootNavigator: true,
              preventDuplicates: true,
            ),
            GetPage(
              name: "${_Paths.TRANSACTION_RECEIPT}/:method",
              page: () => const TransactionReceiptView(),
              binding: TransactionReceiptBinding(),
              // participatesInRootNavigator: true,
              preventDuplicates: true,
            ),
            GetPage(
                name: _Paths.TRANSACTION_DETAILS,
                page: () => const TransactionDetailsView(),
                binding: TransactionDetailsBinding(),
                middlewares: [TransactionDetailGard()]),
          ],
        ),
        GetPage(
          name: _Paths.CONNECTION,
          page: () => const ConnectionView(),
          binding: ConnectionBinding(),
          middlewares: [EnsureNotAuthentificated()],
          // participatesInRootNavigator: true,
          children: [
            GetPage(
              name: _Paths.LOGIN,
              page: () => const LoginView(),
              binding: LoginBinding(),
              participatesInRootNavigator: true,
            ),
            GetPage(
              participatesInRootNavigator: true,
              name: _Paths.SIGNUP,
              page: () => const SignupView(),
              binding: SignupBinding(),
            ),
            GetPage(
              name: _Paths.FORGET_PASSWORD,
              participatesInRootNavigator: true,
              page: () => const ForgetPasswordView(),
              binding: ForgetPasswordBinding(),
            ),
          ],
        ),
      ],
    ),
  ];
}
