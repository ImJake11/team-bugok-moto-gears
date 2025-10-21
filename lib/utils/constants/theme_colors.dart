import 'dart:ui';

class ColorProp {
  final String name;
  final List<Color> colors;

  ColorProp({required this.name, required this.colors});
}

final List<ColorProp> colorAccents = [
  ColorProp(
    name: "Team Bugok Theme",
    colors: [
      Color(0xFFE64A19), // Deep Orange (Primary)
      Color(0xFFF68B1F), // Vivid Orange (Secondary)
      Color(0xFFFFC041), // Warm Amber (Tertiary)
    ],
  ),
  ColorProp(
    name: "Soft Ocean",
    colors: [
      Color(0xFF1565C0), // Deep Blue
      Color(0xFF42A5F5), // Sky Blue
      Color(0xFF90CAF9), // Soft Baby Blue
    ],
  ),
  ColorProp(
    name: "Verdant Mist",
    colors: [
      Color(0xFF2E7D32), // Deep Forest Green
      Color(0xFF66BB6A), // Leafy Mid Green
      Color(0xFFA5D6A7), // Soft Mint Green
    ],
  ),
  ColorProp(
    name: "Tranquil Teal",
    colors: [
      Color(0xFF00695C), // Deep Teal
      Color(0xFF26A69A), // Aqua Teal
      Color(0xFF80CBC4), // Light Mint Aqua
    ],
  ),
  ColorProp(
    name: "Vibrant Coral",
    colors: [
      Color(0xFFD81B60), // Bold Pinkish Red
      Color(0xFFF06292), // Bright Coral
      Color(0xFFF8BBD0), // Soft Rose Pink
    ],
  ),
  ColorProp(
    name: "Sunset Glow",
    colors: [
      Color(0xFFD84315), // Darker Orange
      Color(0xFFFF7043), // Mid Orange
      Color(0xFFFFAB91), // Soft Peach
    ],
  ),
  ColorProp(
    name: "Tropical Lime",
    colors: [
      Color(0xFF9E9D24), // Deep Lime Olive
      Color(0xFFCDDC39), // Vibrant Lime
      Color(0xFFF0F4C3), // Soft Yellow-Lime
    ],
  ),
  ColorProp(
    name: "Yellow Harmony",
    colors: [
      Color(0xFFF9A825), // Primary - Golden Yellow
      Color(0xFFFFD54F), // Secondary - Bright Amber
      Color(0xFFFFF59D), // Tertiary - Soft Pastel Yellow
    ],
  ),
];
