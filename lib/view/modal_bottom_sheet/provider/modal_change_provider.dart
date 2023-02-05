import 'package:drink_app/view/modal_bottom_sheet/notifier/modal_sheet_change_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final modalChangeProvider = ChangeNotifierProvider<ModalSheetChangeNotifier>(
  (ref) => ModalSheetChangeNotifier(),
);
