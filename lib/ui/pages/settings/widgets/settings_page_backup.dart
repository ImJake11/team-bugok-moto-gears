import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:team_bugok_business/ui/widgets/snackbar.dart';
import 'package:team_bugok_business/utils/database/repositories/cache_repository.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:path_provider/path_provider.dart';

class SettingsPageBackup extends StatefulWidget {
  const SettingsPageBackup({super.key});

  @override
  State<SettingsPageBackup> createState() => _SettingsPageBackupState();
}

class _SettingsPageBackupState extends State<SettingsPageBackup>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late CacheRepository _cacheRepository;
  bool _isLoading = false;
  bool _hasError = false;
  DateTime? _latestSync;

  @override
  void initState() {
    super.initState();

    _cacheRepository = CacheRepository();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fetchLastSync();
  }

  Future<void> _fetchLastSync() async {
    try {
      final result = await _cacheRepository.getLatestSync();

      if (!mounted) return;

      setState(() => _latestSync = result);
    } catch (e, st) {
      print(e);
      print(st);
    }
  }

  Future<void> _sync() async {
    try {
      final supabase = Supabase.instance.client;

      // reset the state
      setState(() {
        _isLoading = true;
        _hasError = false;
      });
      _controller.repeat(reverse: false);

      // get main db path
      final dir = await getApplicationDocumentsDirectory();
      final dbFile = File('${dir.path}/motogears_db.sqlite');

      if (!await dbFile.exists()) {
        setState(() => _hasError = true);
        return;
      }

      final filePath = "backup-files/${DateTime.now()}";

      await supabase.storage.from("backup-files").upload(filePath, dbFile);
      await _cacheRepository.setLastSync();

      setState(() => _latestSync = DateTime.now());
      CustomSnackBar(
        duration: Duration(seconds: 5),
        context: context,
        message: "Moto Gears Data Synced Successfully",
      ).show();
    } catch (e, st) {
      print("Failed to backup database ${e}");
      print(st);
      setState(() => _hasError = true);
      CustomSnackBar(context: context, message: "Failed to sync data").show();
    } finally {
      setState(() => _isLoading = false);
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // always dispose controllers!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();
    final now = DateTime.now();

    final nowFormattedDate = DateFormat(
      "MMMM dd, yyyy",
    ).format(now);

    final formattedDate = DateFormat(
      "MMMM dd, yyyy",
    ).format(_latestSync ?? now);
    final formattedTime = DateFormat("h:mm a").format(_latestSync ?? now);

    bool hasSyncedToday =
        _latestSync != null && formattedDate == nowFormattedDate;

    Widget button(
      Widget child,
      Color bg,
    ) => GestureDetector(
      onTap: () => _sync(),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: child,
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
      ),
      child: Row(
        spacing: 10,
        children: [
          Text(
            "Cloud Storage Sync",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            _latestSync == null
                ? "- No record found"
                : "- Last sync $formattedDate @ $formattedTime",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const Spacer(),
          if (!hasSyncedToday)
            Builder(
              builder: (context) {
                if (_hasError) {
                  return button(
                    Row(
                      spacing: 10,
                      children: [
                        Text(
                          "Retry",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.error_outline_rounded,
                        ),
                      ],
                    ),
                    Colors.red,
                  );
                }

                return button(
                  Row(
                    spacing: 10,
                    children: [
                      Text(
                        _isLoading ? "Syncing" : "Sync",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) => Transform.rotate(
                          angle: _controller.value * 2 * pi,
                          child: Icon(Icons.sync_rounded),
                        ),
                      ),
                    ],
                  ),
                  theme.primary,
                );
              },
            ),
        ],
      ),
    );
  }
}
