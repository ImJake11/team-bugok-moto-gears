import 'package:flutter/material.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';

class SearchBarResult {
  OverlayEntry? _overlayEntry;
  List<ProductModel>? products;

  void showSearchBarResult(
    BuildContext context, {
    Offset offset = Offset.zero,
  }) {
    // Avoid showing multiple overlays
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: 310,
          top: 70,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 500,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: const [
                  ListTile(title: Text("Result 1")),
                  ListTile(title: Text("Result 2")),
                  ListTile(title: Text("Result 3")),
                ],
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  void removeSearchBarResult() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
