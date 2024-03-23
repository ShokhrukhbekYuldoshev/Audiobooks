part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class DeletingDownloads extends SettingsState {}

final class AllDownloadsDeleted extends SettingsState {}
