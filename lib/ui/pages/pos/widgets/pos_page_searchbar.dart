import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';

class PosPageSearchbar extends StatelessWidget {
  const PosPageSearchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceDim,
        borderRadius: BorderRadius.circular(10),
         boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 3,
            color: Colors.black87,
            offset: Offset(3, 3),
          ),
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 3,
            color: Colors.grey.shade800.withAlpha(120),
            offset: Offset(-3, -3),
          ),
        ],
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: TextField(
        onChanged: (value) =>
            context.read<PosBloc>().add(PosSearch(query: value)),
        decoration: InputDecoration(
          hintText: "Search Model",
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
