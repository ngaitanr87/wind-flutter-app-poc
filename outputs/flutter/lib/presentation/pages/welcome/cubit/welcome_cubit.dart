import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:base_app/app/assets.dart';

class WelcomeState {
  const WelcomeState({this.navigateToHeroes = false});

  final bool navigateToHeroes;
}

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(const WelcomeState()) {
    _precacheBackground();
  }

  void exploreHeroes() => emit(const WelcomeState(navigateToHeroes: true));

  void navigationHandled() => emit(const WelcomeState());

  void _precacheBackground() {
    const imageProvider = AssetImage(Assets.welcomeBg);
    final stream = imageProvider.resolve(ImageConfiguration.empty);
    late final ImageStreamListener listener;
    listener = ImageStreamListener(
      (_, __) {
        stream.removeListener(listener);
      },
      onError: (_, __) {
        stream.removeListener(listener);
      },
    );
    stream.addListener(listener);
  }
}
