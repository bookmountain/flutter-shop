import 'package:flutter/material.dart';

class HttpException implements Exception {
  final dynamic message;

  HttpException(this.message);

  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}
