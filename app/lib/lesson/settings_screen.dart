/// Task 4 — 설정 화면 (미니멀). 마이크 권한 상태·버전·알림 토글.
library;

import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key = const Key('settings-screen'),
    required this.onBack,
    this.micGranted = false,
    this.version = '0.1.0',
    this.onChangeGenre,
  });

  final VoidCallback onBack;
  final bool micGranted;
  final String version;

  /// 졸업/유지 모드에서만 비-null — 장르 변경 진입점.
  final VoidCallback? onChangeGenre;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notify = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0F13),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0F13),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          key: const Key('settings-back'),
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text('설정', style: TextStyle(fontSize: 18)),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            key: const Key('settings-notify'),
            title: const Text('알림', style: TextStyle(color: Colors.white)),
            value: _notify,
            onChanged: (v) => setState(() => _notify = v),
          ),
          if (widget.onChangeGenre != null)
            ListTile(
              key: const Key('settings-change-genre'),
              title: const Text('장르 변경',
                  style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.chevron_right, color: Colors.white38),
              onTap: widget.onChangeGenre,
            ),
          ListTile(
            title: const Text('마이크 권한',
                style: TextStyle(color: Colors.white)),
            trailing: Text(widget.micGranted ? '허용됨' : '미허용',
                style: const TextStyle(color: Colors.white60)),
          ),
          ListTile(
            title: const Text('버전',
                style: TextStyle(color: Colors.white)),
            trailing: Text(widget.version,
                style: const TextStyle(color: Colors.white38)),
          ),
        ],
      ),
    );
  }
}
