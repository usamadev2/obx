import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late DateTime _endTime;
  late Timer _timer;
  String _timeRemaining = '';

  Future<void> _setEndTime() async {
    final prefs = await SharedPreferences.getInstance();
    final endTimeMillis = prefs.getInt('endTime');
    if (endTimeMillis != null) {
      _endTime = DateTime.fromMillisecondsSinceEpoch(endTimeMillis);
      _startTimer();
    } else {
      _setEndTimeToTomorrow();
    }
  }

  Future<void> _setEndTimeToTomorrow() async {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('endTime', tomorrow.millisecondsSinceEpoch);
    _endTime = tomorrow;
    _startTimer();
  }

  void _startTimer() {
    final now = DateTime.now();
    if (_endTime.isBefore(now)) {
      _timeRemaining = 'Time is up!';
      return;
    }
    final remaining = _endTime.difference(now);
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimeRemaining);
    setState(() {
      _timeRemaining =
          '${remaining.inHours}:${remaining.inMinutes.remainder(60)}:${remaining.inSeconds.remainder(60)}';
    });
  }

  Future<void> _cancelTimer() async {
    _timer.cancel();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('endTime');
  }

  void _updateTimeRemaining(Timer timer) {
    final now = DateTime.now();
    if (_endTime.isBefore(now)) {
      _timer.cancel();
      setState(() {
        _timeRemaining = 'Time is up!';
      });
      _cancelTimer();
      return;
    }
    final remaining = _endTime.difference(now);
    setState(() {
      _timeRemaining =
          '${remaining.inHours}:${remaining.inMinutes.remainder(60)}:${remaining.inSeconds.remainder(60)}';
    });
  }

  @override
  void initState() {
    super.initState();
    _setEndTime();
  }

  @override
  void dispose() {
    _timer.cancel();
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          _timeRemaining,
          style: const TextStyle(fontSize: 32, color: Colors.black),
        ),
      ),
    );
  }
}
