import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 400,
                  // Render inline widget
                  child: showPicker(
                    isInlinePicker: true,
                    elevation: 1,
                    value: _time,
                    onChange: onTimeChanged,
                    minuteInterval: TimePickerInterval.FIVE,
                    iosStylePicker: iosStyle,
                    minHour: 9,
                    maxHour: 21,
                    is24HrFormat: false,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "IOS Style",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          showPicker(
                            showSecondSelector: true,
                            context: context,
                            value: _time,
                            onChange: onTimeChanged,
                            minuteInterval: TimePickerInterval.FIVE,
                            // Optional onChange to receive value as DateTime
                            onChangeDateTime: (DateTime dateTime) {
                              // print(dateTime);
                              debugPrint("[debug datetime]:  $dateTime");
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Open time picker",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 200),
                  child: Switch(
                    value: iosStyle,
                    onChanged: (newVal) {
                      setState(() {
                        iosStyle = newVal;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}