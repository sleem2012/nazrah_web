import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:nazarih/widgets/translate_on_hover/translate_on_hover.dart';

extension HoverExtensions on Widget {
  Widget get showCursorOnHover {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: this, // the widget we're using the extension on
    );
  }

  Widget get mouseUpOnHover {
    return TranslateOnHover(
      child: this,
    );
  }
}
