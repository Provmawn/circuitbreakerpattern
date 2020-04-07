import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CircuitBreaker {
	String state = 'CLOSED';
	int failureThreshold;
	int timeout;
	Duration retryTimePeriod;
	DateTime lastFailureTime;
	int failureCount = 0;

	CircuitBreaker(int timeout, int failureThreshold, Duration retryTimePeriod) {
		this.timeout = timeout;
		this.failureThreshold = failureThreshold;
		this.retryTimePeriod = retryTimePeriod;
	}

	Future<void> call(String url) async {
		setState();
		switch(state) {
			case 'OPEN':
				print('STALE RESPONSE');
				break;
			case 'HALFOPEN':
			case 'CLOSED':
				//make call to API
				try {
					final response = await http.get(url);
					print(response.body);
					List responseJson = json.decode(response.body.toString());
					reset();
				} catch(e) {
					print('API call error');
					failure();
				}
		}
	}

	void setState() {
		if (failureCount > failureThreshold) {
			var now = DateTime.now();
			if ((now.difference(lastFailureTime)).inMilliseconds > (retryTimePeriod.inMilliseconds)) {
				state = 'HALFOPEN';
			} else {
				state = 'OPEN';
			}
		}
	}

	void failure() {
		var now = DateTime.now();
		failureCount += 1;
		lastFailureTime = now;
	}

	void reset() {
		failureCount = null;
		lastFailureTime = null;
		state = 'CLOSED';
	}
}
