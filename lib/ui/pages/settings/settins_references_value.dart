import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/ui/widgets/loading_widget.dart';
import 'package:team_bugok_business/ui/widgets/primary_button.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';
import 'package:team_bugok_business/utils/database/repositories/store_setup_repository.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';
import 'package:team_bugok_business/utils/provider/references_values_cache_provider.dart';

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

      final results = await _setupRepository.getReferencesValues(
        widget.reference,
      );
      await Future.delayed(Duration(seconds: 1));
      _references = results;
      _initializedControllers();
      setState(() => _isInitialized = true);
    } catch (e, st) {
      print("Failed to fetch ${widget.reference} ${e}");
      print(st);
      setState(() => _hasError = true);
    }
  }

  Future<void> _saveValues() async {
    try {
      setState(() => _isInitialized = false);

      await _setupRepository.saveReferenceValue(_references, widget.reference);
      await Future.delayed(Duration(seconds: 1));
      await _fetchReferenceValue();
      context.read<ReferencesValuesProviderCache>().fetchReferenceValues();
    } catch (e, st) {
      print("Failed to save values ${e}");
      print(st);
      setState(() => _hasError = true);
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
            return Row(
              children: [
                CustomTextfield(
                  textEditingController: _controllers[index],
                  fillColor: Theme.of(context).colorScheme.surfaceDim,
                  maxLength: 100,
                  placeholder: "Enter new value",
                  showShadow: false,
                  onChange: (value) {
                    _references[index] = (_references[index].$1, value);
                  },
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
              onTap: () => _addNew(),
              child: Center(
                child: Text("Add New"),
              ),
            ),
            CustomButton(
              onTap: () => _saveValues(),
              child: Center(
                child: Text("Save Changes"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
