import 'package:flutter/material.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/composite/files/file.dart';

class AudioFile extends File {
  const AudioFile(String title, int size)
      : super(
          title: title,
          size: size,
          icon: Icons.music_note,
        );
}
