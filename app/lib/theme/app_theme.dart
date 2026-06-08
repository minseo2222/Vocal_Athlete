/// 앱 공통 색·라운드 토큰. 화면 전역 하드코딩 색을 1곳으로.
library;

import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();
  static const bg = Color(0xFF0E0F13);       // 배경
  static const surface = Color(0xFF171922);  // 카드/시트
  static const done = Color(0xFF39D98A);     // 완료(green)
  static const now = Color(0xFF6C8CFF);      // 현재(blue)
  static const locked = Color(0xFF3A3F55);   // 잠금/미래
  static const lockedSurface = Color(0xFF2C3142);
  static const textHi = Colors.white;        // 강조 텍스트
  static const textMid = Colors.white60;     // 보조 텍스트
  static const textLow = Colors.white38;     // 흐림 텍스트
}

class AppRadii {
  const AppRadii._();
  static const card = 12.0;
}
