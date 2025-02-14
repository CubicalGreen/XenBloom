import 'package:xen_bloom/features/apis/get_settings.dart';

import '../Elements/customContainer.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import '../apis/change_device_range.dart';
import '../authentication_screens/globalVariable.dart';
import '../extras/thumb_art.dart';
import 'package:google_fonts/google_fonts.dart';

class PpmContainer extends StatefulWidget {
  @override
  _PpmContainerState createState() => _PpmContainerState();
}

class _PpmContainerState extends State<PpmContainer> {
  String _maxConcentration = tds_max.toString();
  String _minConcentration = tds_min.toString();
  double staticValue = 827;

  double _updatedMinConcentration = (tds_min ?? 0).toDouble();
  double _updatedMaxConcentration = (tds_max ?? 0).toDouble();
  bool _isSliderActive = false;

  final settings = GetSettings();
  final deviceService = DeviceService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   fetchAndStoreTDSSettings();
    // });
    fetchAndStoreTDSSettings();
  }

  Future<void> fetchAndStoreTDSSettings() async {
    setState(() {
      _isLoading = false; // Start loading
    });

    try {
      var data = await settings.getDeviceSettings();

      if (data != null) {
        dynamic TDS = data['TDS'];
        setState(() {
          tds_min = (TDS['min']);
          tds_max = TDS['max'];
          _updatedMaxConcentration = (tds_max ?? 0).toDouble();
          _updatedMinConcentration = (tds_min ?? 0).toDouble();
          _isLoading = false; // Data loaded, stop loading
        });
        print("Max TDS $tds_max, Min TDS: $tds_min");
      } else {
        print("Data retrieved was null!");
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Failed to access TDS Settings $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showBottomSheet() {
    fetchAndStoreTDSSettings();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateModal) {
          return Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: Container(
                    color: const Color(0xFF494e52).withOpacity(0.5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35.0, right: 0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.36,
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : Column(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        'Concentration',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 16.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.13,
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.03),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 8.0, right: 8.0),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF9cfca6),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Text(
                                                  'Recommended',
                                                  style: GoogleFonts.poppins(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0050),
                                          // right here
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: _isSliderActive
                                                ? _buildRangeSlider(
                                                    setStateModal)
                                                : _buildStaticSlider(),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 16.0),
                                    child: Row(
                                      children: [
                                        _buildValueContainer(
                                            'Min.',
                                            _updatedMinConcentration
                                                .toString()),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02),
                                        _buildValueContainer(
                                            'Max.',
                                            _updatedMaxConcentration
                                                .toString()),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  _buildButtons(setStateModal),
                                ],
                              ),
                            )
                          ],
                        ),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  Widget _buildStaticSlider() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
          trackHeight: 8,
          activeTrackColor: Colors.black,
          inactiveTrackColor: Colors.black,
          thumbShape: CustomStaticThumbShape(staticValue)),
      child: Slider(
        value: staticValue,
        min: 600,
        max: 1200,
        onChanged: (_) {},
      ),
    );
  }

  Widget _buildRangeSlider(Function setStateModal) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 8,
        activeTrackColor: Color.fromRGBO(82, 120, 241, 1),
        inactiveTrackColor: Colors.grey[300],
        rangeThumbShape: CustomRangeThumbShape(
            min: _updatedMinConcentration, max: _updatedMaxConcentration),
      ),
      child: RangeSlider(
        values: RangeValues(_updatedMinConcentration, _updatedMaxConcentration),
        min: 0,
        max: 3000,
        divisions: 100,
        onChanged: (values) {
          setStateModal(() {
            _updatedMaxConcentration = values.end;
            _updatedMinConcentration = values.start;
          });
        },
      ),
    );
  }

  Widget _buildValueContainer(String label, String value) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height * 0.13,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      color: Colors.grey[600],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'assets/images/refresh_icon.png',
                      width: MediaQuery.of(context).size.width * 0.07,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.0075),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.08,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(Function setStateModal) {
    return Padding(
      padding: const EdgeInsets.only(right: 14.0, left: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              minimumSize: Size(MediaQuery.of(context).size.width * 0.44, 50),
              textStyle: GoogleFonts.poppins(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child:
                Text('Cancel', style: GoogleFonts.poppins(color: Colors.black)),
          ),
          SizedBox(width: 5),
          ElevatedButton(
            onPressed: () {
              setStateModal(() {
                _isSliderActive = !_isSliderActive;
              });

              if (!_isSliderActive == true) {
                setState(() {
                  tds_min = _updatedMinConcentration.toInt();
                  tds_max = _updatedMaxConcentration.toInt();
                });

                deviceService.changeDeviceRange();
              }

              print('btn clicked');
              print(_isSliderActive);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: Size(MediaQuery.of(context).size.width * 0.44, 50),
              textStyle: GoogleFonts.poppins(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(_isSliderActive ? 'Save' : 'Reset',
                style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    // fetchAndStoreTDSSettings();
    return CustomContainer(
      onTap: _showBottomSheet,
      height: h * 0.2,
      width: w * 0.445,
      imagePath: 'assets/images/concerntration.png',
      title: 'Concentration',
      value: '827',
      unit: 'ppm',
    );
  }
}
