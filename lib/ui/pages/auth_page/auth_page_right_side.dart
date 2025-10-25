import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/ui/pages/auth_page/widgets/auth_page_message.dart';
import 'package:team_bugok_business/ui/widgets/title_bar.dart';
import 'package:team_bugok_business/utils/provider/auth_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class AuthPageRightSide extends StatefulWidget {
  const AuthPageRightSide({super.key});

  @override
  State<AuthPageRightSide> createState() => _AuthPageRightSideState();
}

class _AuthPageRightSideState extends State<AuthPageRightSide> {
  bool _isLoginBtnHovered = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = context.watch<MyThemeProvider>();
    final provider = context.watch<AuthProvider>();
    final hasError = provider.hasError;
    final isLoading = provider.isLoading;
    final isLoggedIn = provider.isLoggedIn;
    final message = provider.message;

    var textField = SizedBox(
      width: 300,
      height: 50,
      child: TextFormField(
        onChanged: (value) {
          Provider.of<AuthProvider>(
            context,
            listen: false,
          ).addInput(int.parse(value));
        },
        cursorColor: theme.primary,
        textAlign: TextAlign.center,
        obscureText: true,
        obscuringCharacter: "◉",
        style: TextStyle(
          color: theme.primary,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        maxLength: 6,
        decoration: InputDecoration(
          hintText: "Enter Pin",
          hintStyle: TextStyle(
            color: Colors.grey.shade600,
          ),
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: theme.primary,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: theme.primary,
            ),
          ),
        ),
      ),
    );

    var loginButton = GestureDetector(
      onTap: () =>
          Provider.of<AuthProvider>(context, listen: false).checkPassword(),
      child: MouseRegion(
        onEnter: (event) => setState(() => _isLoginBtnHovered = true),
        onExit: (event) => setState(() => _isLoginBtnHovered = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            color: _isLoginBtnHovered ? theme.secondary : theme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: isLoading
              ? Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Logging in'),
                    SpinKitFadingCircle(
                      size: 25,
                      color: Colors.white,
                    ),
                  ],
                )
              : Center(child: Text('Login')),
        ),
      ),
    );

    return SizedBox(
      width: size.width * .50,
      height: size.height,
      child: Column(
        children: [
          TitleBar(
            showLogo: false,
          ),
          Image.asset(
            'assets/images/moto-gears-icon-no-bg.png',
            width: 250,
          ),
          Expanded(
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                textField,
                loginButton,
                const Spacer(),
                AuthPageMessage(
                  hasError: hasError,
                  isLoggedIn: isLoggedIn,
                  message: message,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
