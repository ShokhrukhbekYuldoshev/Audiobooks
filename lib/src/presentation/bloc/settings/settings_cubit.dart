import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  Future<void> deleteAllDownloads() async {
    emit(DeletingDownloads());
    Directory? savedDir = await getExternalStorageDirectory();
    if (savedDir != null) {
      await savedDir.delete(recursive: true);
    }
    emit(AllDownloadsDeleted());
  }
}
