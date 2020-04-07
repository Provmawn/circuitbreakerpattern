import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'circuit_breaker.dart';
import 'ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Service Ordering',
			home: Services(),
		);
	}

}
