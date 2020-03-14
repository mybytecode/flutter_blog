/*
 * Copyright 2019 mybytecode
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class Utils {
  Color getRandomColor() {
    List color = [
      Colors.blue,
      Colors.redAccent,
      Colors.amber,
      Colors.greenAccent
    ];

    int random = Random().nextInt(4 - 0);

    return color[random];
  }

  String dateParse(String date) {
    Duration parsedDate = DateTime.parse(date).difference(DateTime.now());

    var hours = parsedDate.inHours;
    var minutes = parsedDate.inMinutes;
    var days = parsedDate.inDays;

    if (hours < 0 && hours > -24) {
      String time = hours.toString() + " hours ago";
      return time.replaceAll("-", "");
    } else if (minutes > -59) {
      String time = minutes.toString() + " minutes ago";
      return time.replaceAll("-", "");
    } else if (days < 0) {
      String time = days.toString() + " days ago";
      return time.replaceAll("-", "");
    }
  }

  String parseHTML(String string) {
    var document = parse(string);

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  String dateParseComment(String date) {
    Duration parsedDate = DateTime.parse(date).difference(DateTime.now());

    var hours = parsedDate.inHours;
    var minutes = parsedDate.inMinutes;
    var days = parsedDate.inDays;

    if (hours < 0 && hours > -24) {
      String time = hours.toString() + "h";
      return time.replaceAll("-", "");
    } else if (minutes > -59) {
      String time = minutes.toString() + "m";
      return time.replaceAll("-", "");
    } else if (days < 0) {
      String time = days.toString() + "d";
      return time.replaceAll("-", "");
    }
    return " ";
  }
}
