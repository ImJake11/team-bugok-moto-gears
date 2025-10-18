import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/ui/pages/auth_page/widgets/auth_page_pin_button.dart';
import 'package:team_bugok_business/ui/pages/auth_page/widgets/auth_page_pin_input_indicator.dart';
import 'package:team_bugok_business/utils/provider/auth_provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;

    final provider = context.watch<AuthProvider>();
    final password = provider.password;
    final hasError = provider.hasError;

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
                Row(
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
                    hasError ? "Wrong pin" : "",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),

                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 350,
                      height: 470,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: numbers.length,
                        padding: EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) => AuthPagePinButton(
                          index: index,
                          label: "${numbers[index]}",
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
