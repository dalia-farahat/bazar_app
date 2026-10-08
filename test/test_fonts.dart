import 'dart:io';

import 'package:flutter/services.dart';

/// يحمّل خطوط التطبيق اللي تحتاجها اختبارات الشاشات.
///
/// `flutter test` مبيحمّلش خطوط المشروع ولا MaterialIcons، وبدائلهم خط
/// الاختبار الواسع (بيزحزح القياسات ويرسم مربعات مكان الأيقونات)، فبنسجلهم
/// من ملفات assets بنفسنا قبل أي اختبار.
Future<void> loadAppFonts() async {
  const Map<String, List<String>> faces = <String, List<String>>{
    'Roboto': <String>[
      'assets/fonts/Roboto-Regular.ttf',
      'assets/fonts/Roboto-Medium.ttf',
      'assets/fonts/Roboto-Bold.ttf',
    ],
    // عائلات Open Sans وInter اللي بتستخدمها شاشات التطبيق.
    'Open Sans': <String>[
      'assets/fonts/OpenSans-Regular.ttf',
      'assets/fonts/OpenSans-SemiBold.ttf',
      'assets/fonts/OpenSans-Bold.ttf',
    ],
    'Inter': <String>[
      'assets/fonts/Inter-Medium.ttf',
      'assets/fonts/Inter-SemiBold.ttf',
    ],
  };
  for (final MapEntry<String, List<String>> entry in faces.entries) {
    for (final String asset in entry.value) {
      final FontLoader loader = FontLoader(entry.key)
        ..addFont(_readFont(asset));
      await loader.load();
    }
  }
  await _loadMaterialIcons();
}

/// بيسجّل خط MaterialIcons اللي مع Flutter SDK نفسه.
///
/// الملف موجود في مجلد كاش الـSDK؛ لو مالقيناهش بنعدّي بهدوء (بيتأثر
/// بس رسم الأيقونات في الصور، باقي الاختبارات تفضل شغالة).
Future<void> _loadMaterialIcons() async {
  for (final File file in _materialIconCandidates()) {
    if (!file.existsSync()) {
      continue;
    }
    final FontLoader loader = FontLoader('MaterialIcons')
      ..addFont(_readFile(file));
    await loader.load();
    return;
  }
}

Iterable<File> _materialIconCandidates() sync* {
  Directory? dir = File(Platform.resolvedExecutable).parent;
  // الملف إما في material_fonts مباشرة أو مستوى أعمق لما الاختبار يشتغل
  // من مجلد artifacts/engine/... فبنطلع لفوق ٦ مستويات بحثًا عنه.
  for (int i = 0; i < 6 && dir != null; i++, dir = dir.parent) {
    for (final String name in <String>[
      'materialicons-regular.otf',
      'MaterialIcons-Regular.otf',
    ]) {
      yield File(
        <String>[dir.path, 'material_fonts', name].join(Platform.pathSeparator),
      );
      yield File(
        <String>[
          dir.path,
          'artifacts',
          'material_fonts',
          name,
        ].join(Platform.pathSeparator),
      );
    }
  }
}

/// الأول من rootBundle، ولو مش موجود نقرأه من الملف مباشرة (مش دايمًا
/// متسجّلين في asset manifest بتاع الاختبارات).
Future<ByteData> _readFont(String path) async {
  try {
    return await rootBundle.load(path);
  } catch (_) {
    return _readFile(File(path));
  }
}

Future<ByteData> _readFile(File file) async {
  final Uint8List bytes = await file.readAsBytes();
  return ByteData.view(bytes.buffer, bytes.offsetInBytes, bytes.length);
}
