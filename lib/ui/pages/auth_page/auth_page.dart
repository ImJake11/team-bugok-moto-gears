import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:team_bugok_business/ui/pages/auth_page/widgets/auth_page_pin_button.dart';
import 'package:team_bugok_business/ui/pages/auth_page/widgets/auth_page_pin_input_indicator.dart';
import 'package:team_bugok_business/utils/provider/auth_provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _keyboardFocusNode = FocusNode();

  String _keyPress = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final provider = context.read<AuthProvider>();

    provider.addListener(
      () async {
        final isLoggedIn = provider.isLoggedIn;

        if (!isLoggedIn) return;

        Future.delayed(
          Duration(seconds: 2),
          () => context.goNamed('dashboard'),
        );
      },
    );
  }

  void _keyEventHandler(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    final provider = context.read<AuthProvider>();
    final pressedKey = event.physicalKey.debugName?.toLowerCase();

    if (pressedKey == null) return;

    if (pressedKey == "backspace") {
      provider.deleteLast();
      return;
    }

    if (pressedKey.startsWith("digit")) {
      final digit = pressedKey.replaceAll("digit", ""); // Get only the number
      if (digit.isEmpty) return;

      final input = int.tryParse(digit);
      if (input == null) return;

      provider.addInput(input);
      setState(() {
        _keyPress = digit;
      });
    }
  }

  @override
  void dispose() {
    _keyboardFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;

    final provider = context.watch<AuthProvider>();
    final password = provider.password;
    final hasError = provider.hasError;
    final isLoading = provider.isLoading;
    final isLoggedIn = provider.isLoggedIn;

    final numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, "←", 0];

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                color: theme.surfaceDim,
              ),
            ),
          ),

          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/moto-gears-icon-no-bg.png",
                  width: 150,
                ),
                isLoading
                    ? SpinKitCircle(
                        color: theme.primary,
                        duration: Duration(milliseconds: 1000),
                        size: 40,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: List.generate(
                          6,
                          (index) => AuthPagePinInputIndicator(
                            isContained: password.length > index,
                          ),
                        ),
                      ),

                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Text(
                    hasError
                        ? "Wrong pin"
                        : isLoggedIn
                        ? "Logged in"
                        : "",
                    style: TextStyle(
                      color: hasError ? Colors.red : Colors.green,
                    ),
                  ),
                ),

                Expanded(
                  child: KeyboardListener(
                    autofocus: true,
                    focusNode: _keyboardFocusNode,
                    onKeyEvent: _keyEventHandler,
                    child: Center(
                      child: SizedBox(
                        width: 350,
                        height: 470,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: numbers.length,
                          padding: EdgeInsets.all(10),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                          itemBuilder: (context, index) => AuthPagePinButton(
                            isPressed: numbers[index].toString() == _keyPress,
                            index: index,
                            label: "${numbers[index]}",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Row(
              children: [
                Checkbox(
                  activeColor: theme.primary,
                  side: BorderSide(
                    color: Colors.grey.shade800,
                  ),
                  value: provider.isPinRemember,
                  onChanged: (_) => provider.toggleCheckBox(),
                ),
                Text("Remember Pin"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
