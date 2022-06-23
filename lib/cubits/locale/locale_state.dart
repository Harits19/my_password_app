part of 'locale_cubit.dart';

abstract class LocaleState extends Equatable {
  const LocaleState();

  @override
  List<Object> get props => [];
}

class LocaleLoaded extends LocaleState {
  final Locale activeLocale;

  LocaleLoaded(this.activeLocale);
}

class LocaleIdle extends LocaleState{
  
}
