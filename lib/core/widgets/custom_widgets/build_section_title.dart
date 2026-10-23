import 'package:flutter/material.dart';

import '../../utils/text_style.dart';

 Widget buildSectionTitle(String title,  {TextStyle? style}) {
      return Padding(
        padding: const EdgeInsets.only(right: 4, bottom: 8),
        child: Text(
            title,
            style: style?? const TextStyle(
              fontSize: 11,fontWeight: FontWeight.bold, color: Colors.grey
            )
        )
      );
    }


