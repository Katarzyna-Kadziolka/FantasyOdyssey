import 'package:fantasy_odyssey/Controllers/login_controller.dart';
import 'package:fantasy_odyssey/Pages/login_page.dart';
import 'package:fantasy_odyssey/Persistence/cache.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Persistence/storage_service.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  double _currentSliderValue = 75;
  double _currentUpdateStepsInputValue = 0;
  final StorageService storage = Get.find();
  final Cache cache = Get.find();
  final List<bool> _isOpen = [false, false];
  final loginController = Get.put(LoginController());
  final StorageService _storage = Get.find();

  void saveStepLength(double value) async {
    await storage.saveStepLengthAsync(toKm(value));
    setState(() {
      _currentSliderValue = value;
    });
  }

  double toCm(double value) {
    return value * 100000;
  }

  double toKm(double value) {
    return value / 100000;
  }

  Future resetProgress() async {
    await cache.resetProgressAsync();
  }

  Future updateProgress() async {
    var steps = cache.getSavedSteps();
    steps.updateTime = DateTime.now();
    steps.steps = (_currentUpdateStepsInputValue * 100000) ~/ _currentSliderValue;
    await _storage.saveStepsAsync(steps);
    cache.clearCache();
  }

  void _logOut() {
    loginController.logout().whenComplete(() => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    var stepLength = _getStepLength();
    setState(() {
      _currentSliderValue = toCm(stepLength);
    });
  }

  double _getStepLength() {
    return storage.getStepLength();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF121212),
      child: DefaultTextStyle(
        style: const TextStyle(color: Color(0xFFE0F2F1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ExpansionPanelList(
                children: [
                  ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (context, isOpen) {
                      return Container(
                        margin: const EdgeInsets.all(15),
                        child: const Text(
                          "Danger Zone",
                          style: TextStyle(
                            color: Color(0xFFee4941),
                            fontSize: 17,
                          ),
                        ),
                      );
                    },
                    body: Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      child: TextButton(
                        onPressed: () async => await resetProgress(),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF302c2c),
                          fixedSize: const Size(300, 25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                              color: Color(0xFF3c4038),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Reset progress',
                          style: TextStyle(
                              color: Color(0xFFee4941),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    isExpanded: _isOpen[0],
                    backgroundColor: const Color(0xFF282424),
                  ),
                  ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (context, isOpen) {
                      return Container(
                        margin: const EdgeInsets.all(15),
                        child: const Text(
                          "Developer zone",
                          style: TextStyle(
                            color: Color(0xFFE0F2F1),
                            fontSize: 17,
                          ),
                        ),
                      );
                    },
                    body: Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Color(0xFFE0F2F1)),
                              onChanged: (value) => setState(() {
                                _currentUpdateStepsInputValue =
                                    double.parse(value);
                              }),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFE0F2F1))),
                                  hintText: 'Distance in km',
                                  hintStyle:
                                      TextStyle(color: Color(0xFFE0F2F1))),
                            ),
                          ),
                          TextButton(
                            onPressed: () async => await updateProgress(),
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFF302c2c),
                              fixedSize: const Size(300, 25),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(
                                  color: Color(0xFF3c4038),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Set progress',
                              style: TextStyle(
                                  color: Color(0xFFE0F2F1),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    isExpanded: _isOpen.isEmpty ? false : _isOpen[1],
                    backgroundColor: const Color(0xFF282424),
                  ),
                ],
                expansionCallback: (i, isExpanded) => setState(() {
                  _isOpen[i] = !isExpanded;
                }),
              ),
              Column(children: [
                Text(
                  "Step length: ${_currentSliderValue.toStringAsFixed(0)} cm",
                  style: const TextStyle(fontSize: 20),
                ),
                Slider(
                  value: _currentSliderValue,
                  min: 65,
                  max: 85,
                  divisions: 20,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) => saveStepLength(value),
                  activeColor: const Color(0xFF00695C),
                ),
              ]),
              TextButton(
                onPressed: () => _logOut(),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF302c2c),
                  fixedSize: const Size(300, 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Color(0xFF3c4038),
                    ),
                  ),
                ),
                child: const Text(
                  'Log out',
                  style: TextStyle(
                    color: Color(0xFFE0F2F1),
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
