import 'package:audiobooks/src/core/di/service_locator.dart';
import 'package:audiobooks/src/core/extensions/string_extensions.dart';
import 'package:audiobooks/src/core/helpers/helpers.dart';
import 'package:audiobooks/src/core/themes/app_theme.dart';
import 'package:audiobooks/src/core/themes/cubit/theme_cubit.dart';
import 'package:audiobooks/src/presentation/bloc/settings/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    _getPackageInfo();
  }

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _getPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is AllDownloadsDeleted) {
          showSnackBar(
            context,
            'All downloads deleted',
          );
        }
        if (state is DeletingDownloads) {
          showSnackBar(
            context,
            'Deleting downloads...',
          );
        }
      },
      child: Scaffold(
        // package info
        bottomNavigationBar: _buildBottomBar(),
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: ListView(
          children: [
            // change theme
            const ChangeThemeTile(),
            // delete downloaded audiobooks
            ListTile(
              title: const Text('Delete downloaded audiobooks'),
              subtitle: const Text('This action is permanent'),
              trailing: const Icon(Icons.delete_forever),
              onTap: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete downloaded audiobooks'),
                    content: const Text(
                      'Are you sure you want to delete all downloaded audiobooks?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );

                if (confirmed == true && context.mounted) {
                  context.read<SettingsCubit>().deleteAllDownloads();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Container _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _packageInfo.appName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Version ${_packageInfo.version}+${_packageInfo.buildNumber}',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class ChangeThemeTile extends StatelessWidget {
  const ChangeThemeTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return ListTile(
          title: const Text('Theme'),
          subtitle: FutureBuilder(
            future: sl<AppTheme>().getThemeMode(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox.shrink();
              }
              ThemeMode themeMode = snapshot.data as ThemeMode;
              return Text(themeMode.name.capitalize());
            },
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () async {
            // show theme selection
            await showDialog(
              context: context,
              builder: (context) {
                return FutureBuilder(
                    future: sl<AppTheme>().getThemeMode(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox.shrink();
                      }
                      ThemeMode themeMode = snapshot.data as ThemeMode;
                      return SimpleDialog(
                        title: const Text('Select theme'),
                        children: [
                          RadioListTile<ThemeMode>(
                            value: ThemeMode.system,
                            groupValue: themeMode,
                            onChanged: (value) => context
                                .read<ThemeCubit>()
                                .themeModeChanged(value!),
                            title: const Text('System'),
                          ),
                          RadioListTile<ThemeMode>(
                            value: ThemeMode.light,
                            groupValue: themeMode,
                            onChanged: (value) => context
                                .read<ThemeCubit>()
                                .themeModeChanged(value!),
                            title: const Text('Light'),
                          ),
                          RadioListTile<ThemeMode>(
                            value: ThemeMode.dark,
                            groupValue: themeMode,
                            onChanged: (value) => context
                                .read<ThemeCubit>()
                                .themeModeChanged(value!),
                            title: const Text('Dark'),
                          ),
                        ],
                      );
                    });
              },
            );
          },
        );
      },
    );
  }
}
