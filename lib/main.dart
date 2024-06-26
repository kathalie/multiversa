import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/presentation/app.dart';

void main() {
  runApp(
    const ProviderScope(child: MultiversaApp()),
  );
}