import 'package:flutter/material.dart';

@immutable
class Settings {
  final bool deleteOnComplete;
  const Settings({
    this.deleteOnComplete = false,
  });
}
