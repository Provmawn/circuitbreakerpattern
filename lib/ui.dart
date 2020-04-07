import 'package:flutter/material.dart';
import 'circuit_breaker.dart';

class ServicesState extends State<Services> {
	
	Widget _buildLayout() {
		return ListView(
			padding: const EdgeInsets.all(16.0),
			children: <Widget>[
				RaisedButton(
					onPressed: () => { callAPI(null) }, // callAPI(String link)
					color: Colors.blue[100],
					child: const Center(child: Text('Service A')),
				),
				RaisedButton(
					onPressed: () => { callAPI(null) }, // callAPI(String link)
					color: Colors.blue[200],
					child: const Center(child: Text('Service B')),
				),
				RaisedButton(
					onPressed: () => { callAPI(null) }, // callAPI(String link)
					color: Colors.blue[300],
					child: const Center(child: Text('Service C')),
				),
			]
		);
	}

	// Create CircuitBreaker
	final CircuitBreaker cb = CircuitBreaker(3000, 5, Duration(milliseconds: 2000));

	void callAPI(String link) {
		if (link != null) {
			cb.call(link);
		}
	}
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Services'),
			),
			body: _buildLayout(),
		);
	}
	
}

class Services extends StatefulWidget {
	ServicesState createState() => ServicesState();
}

