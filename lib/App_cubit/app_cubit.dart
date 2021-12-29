import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Shared/network/Local/shared_prefrences.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());
  AppCubit get(context) => BlocProvider.of(context);
  bool isDark = false;
  void changeMode({fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppModeChange());
    } else {
      isDark = !isDark;
      CacheHelper.putBolean(key: "isDark", value: isDark)
          .then((value) => emit(AppModeChange()));
    }
  }
}
