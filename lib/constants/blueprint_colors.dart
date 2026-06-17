import 'package:flutter/material.dart';

const _colors = <String, Color>{
  'poop': Color(0xFF8B6914),
  'pee': Color(0xFFF5C842),
  'walk': Color(0xFF0F7173),
  'medication': Color(0xFF9B59B6),
  'play': Color(0xFFF05D5E),
  'training': Color(0xFF2ECC71),
};

Color blueprintColor(String key) => _colors[key] ?? const Color(0xFFD8A47F);
