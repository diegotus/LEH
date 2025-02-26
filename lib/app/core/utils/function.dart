import 'dart:ui';

import '../../data/models/ticket_model.dart';
import 'app_colors.dart';

Color? getTicketColor(TicketModel ticket) {
  if (ticket.totalWon > 0) {
    return AppColors.PRIMARY3;
  } else if (ticket.tirageId == null) {
    return AppColors.YELLOW_CARD;
  }
  return null;
}
