import 'package:flutter/material.dart';

abstract class IFile {
  int getSize();
  Widget render(BuildContext context);
}
