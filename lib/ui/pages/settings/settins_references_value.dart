import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/ui/widgets/custom_button.dart';
import 'package:team_bugok_business/ui/widgets/loading_widget.dart';
import 'package:team_bugok_business/ui/widgets/snackbar.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';
import 'package:team_bugok_business/utils/database/repositories/store_setup_repository.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';
import 'package:team_bugok_business/utils/provider/settings_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class SettingsReferencesValue extends StatefulWidget {
  final ReferenceType reference;

  const SettingsReferencesValue({
    super.key,
    required this.reference,
  });

  @override
  State<SettingsReferencesValue> createState() =>
      _SettingsReferencesValueState();
}

class _SettingsReferencesValueState extends State<SettingsReferencesValue> {
  final StoreSetupRepository _setupRepository = StoreSetupRepository();
  List<(int, String)> _references = [];
  List<TextEditingController> _controllers = [];

  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchReferenceValue();
  }

  Future<void> _fetchReferenceValue() async {
    try {
      if (_isInitialized) {
        setState(() {
          _hasError = false;
          _isInitialized = false;
        });
      }

      if (!mounted) return;

      final results = await _setupRepository.getReferencesValues(
        widget.reference,
      );
      await Future.delayed(Duration(seconds: 1));
      _references = results;
      _initializedControllers();
    } catch (e, st) {
      print("Failed to fetch ${widget.reference} ${e}");
      print(st);
      setState(() => _hasError = true);
    } finally {
      setState(() => _isInitialized = true);
    }
  }

  Future<void> _saveValues() async {
    final setting = context.read<SettingsProvider>();

    try {
      bool isValid = _references.every((e) => e.$2.isNotEmpty);

      setting.toggleViewContentButton();
      if (!isValid) {
        CustomSnackBar(
          context: context,
          message: "Some fields are empty!",
        ).show();
        return;
      }
      ;

      setState(() => _isInitialized = false);

      await _setupRepository.saveReferenceValue(_references, widget.reference);
      await _fetchReferenceValue();
    } catch (e, st) {
      print("Failed to save values ${e}");
      print(st);
      setState(() => _hasError = true);
    } finally {
      setting.toggleViewContentButton();
    }
  }

  void _initializedControllers() {
    _controllers = List.generate(
      _references.length,
      (i) => TextEditingController(text: _references[i].$2),
    );
  }

  void _addNew() {
    _references.add((0, ""));
    _initializedControllers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    if (!_isInitialized) {
      return LoadingWidget();
    }

    if (_hasError) {
      return Center(child: Text("Failed to get ${widget.reference.name}"));
    }

    if (_references.isEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Text(
              "No list of ${widget.reference.name} found",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
            CustomButton(
              showShadow: false,
              onTap: () => _addNew(),
              child: Center(
                child: Text("Add New"),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      spacing: 20,
      children: [
        ...List.generate(
          _references.length,
          (index) {
            bool showButton = _references[index].$1 <= 0;

            return Row(
              spacing: 10,
              children: [
                CustomTextfield(
                  textEditingController: _controllers[index],
                  fillColor: theme.surfaceDim,
                  maxLength: 100,
                  placeholder: "Enter new value",
                  showShadow: false,
                  onChange: (value) {
                    _references[index] = (_references[index].$1, value);
                  },
                ),

                if (showButton)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _references.removeAt(index);
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.red.withAlpha(20),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.red,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.delete_rounded,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),

        Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButton(
              showShadow: false,
              height: 45,
              width: 100,
              onTap: () => _addNew(),
              child: Center(
                child: Text(
                  "Add New",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            CustomButton(
              height: 45,
              showShadow: false,
              onTap: () => _saveValues(),
              child: Center(
                child: Text(
                  "Save Changes",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
