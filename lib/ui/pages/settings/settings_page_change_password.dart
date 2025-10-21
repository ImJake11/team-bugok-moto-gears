import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:team_bugok_business/ui/widgets/loading_widget.dart';
import 'package:team_bugok_business/ui/widgets/snackbar.dart';
import 'package:team_bugok_business/utils/database/repositories/cache_repository.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class SettingsPageChangePassword extends StatefulWidget {
  const SettingsPageChangePassword({super.key});

  @override
  State<SettingsPageChangePassword> createState() =>
      _SettingsPageChangePasswordState();
}

class _SettingsPageChangePasswordState
    extends State<SettingsPageChangePassword> {
  final CacheRepository _cacheRepository = CacheRepository();

  final _currentPin = TextEditingController();
  final _newPin = TextEditingController();
  final _confirmPin = TextEditingController();

  bool _isInitialized = false;
  bool _initializedError = false;
  bool _hasError = false;
  bool _isSaving = false;
  bool _isSuccessful = false;
  String? _errorMessage;
  int? _pin;

  String? _passwordOnView;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPassword();
  }

  Future<void> _getPassword() async {
    try {
      final pin = await _cacheRepository.getPassword();
      _pin = pin;
      await Future.delayed(Duration(seconds: 1));
      setState(() => _isInitialized = true);
    } catch (e, st) {
      print("Failed to get pin please contact developer ${e}");
      print(st);
      CustomSnackBar(
        context: context,
        message: "Failed to get pin please contact developer",
      ).show();
      setState(() => _initializedError = true);
    }
  }

  Future<void> _saveNewPin() async {
    try {
      final newPin = _newPin.text;
      final confirmPin = _confirmPin.text;
      final currentPin = _currentPin.text;

      setState(() {
        _hasError = false;
        _isSaving = true;
      });

      if (currentPin != _pin.toString()) {
        _showErrorMessage("Invalid current PIN. Please try again");
        return;
      } else if (newPin != confirmPin) {
        _showErrorMessage("Pins did not matched");
        return;
      } else if (newPin.length < 6 ||
          confirmPin.length < 6 ||
          currentPin.length < 6) {
        _showErrorMessage("Pin length must be 6 digits");
        return;
      } else {
        await _cacheRepository.saveNewPin(int.parse(newPin));

        _pin = int.parse(newPin);

        _newPin.text = "";
        _currentPin.text = "";
        _confirmPin.text = "";

        await Future.delayed(Duration(seconds: 1));

        setState(() {
          _isSuccessful = true;
        });
      }
    } catch (e, st) {
      print(e);
      print(st);
      setState(() {
        _hasError = true;
        _errorMessage = "Failed to update pin";
      });
    } finally {
      setState(() => _isSaving = false);
    }
  }

  void _showErrorMessage(String error) async {
    setState(() {
      _hasError = true;
      _errorMessage = error;
    });
  }

  void _viewPassword(String label) {
    setState(() => _passwordOnView = label);
    Future.delayed(
      Duration(seconds: 3),
      () => setState(() => _passwordOnView = null),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    if (!_isInitialized) {
      return LoadingWidget();
    }

    if (_initializedError) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            Icon(
              Icons.error,
              size: 50,
              color: Colors.red,
            ),
            Text(
              "Updating Pin is unavailable due to system bugs, Please contact your developer.",
              style: TextStyle(fontSize: 14, color: Colors.red),
            ),
          ],
        ),
      );
    }

    OutlineInputBorder border(
      Color? borderColor,
    ) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: borderColor ?? theme.primary,
      ),
    );

    Widget textfields(
      String label,
      TextEditingController controller,
    ) => Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        Row(
          spacing: 20,
          children: [
            SizedBox(
              height: 50,
              width: 300,
              child: TextField(
                controller: controller,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                maxLength: 6,
                textAlign: TextAlign.center,
                obscureText: _passwordOnView != label,
                obscuringCharacter: "◉",
                decoration: InputDecoration(
                  counterText: "",
                  enabledBorder: border(null),
                  focusedBorder: border(null),
                  errorBorder: border(Colors.red),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _viewPassword(label);
              },
              child: Icon(
                _passwordOnView == label
                    ? Icons.lock_open_rounded
                    : Icons.lock_rounded,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 20,
      children: [
        textfields("Current Pin", _currentPin),
        textfields("New Pin", _newPin),
        textfields("Confirm New Pin", _confirmPin),
        const SizedBox(height: 30),
        if (_hasError)
          Text(
            _errorMessage ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        if (_isSuccessful)
          Text(
            'Pin successfully updated.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                _saveNewPin();
              },
              child: Container(
                height: 50,
                width: _isSaving ? 170 : 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _isSaving ? Colors.grey.shade900 : Colors.red,
                  ),
                  color: _isSaving
                      ? Colors.grey.shade900.withAlpha(120)
                      : Colors.red.withAlpha(20),
                ),
                child: _isSaving
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Text(
                            "Saving Changes",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),

                          SpinKitFadingCircle(
                            color: theme.primary,
                            size: 20,
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                          "Update Pin",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
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
