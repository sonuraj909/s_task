import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/home_screen_model.dart';

class HomeController extends GetxController {
  var homeData = HomeResponse(
    status: false,
    data: HomeData(
      stores: [],
      nearestStore:
          Store(id: 0, name: '', latitude: '0', longitude: '0', distance: 0.0),
      trendingProducts: [],
      mainSlider: [],
      bottomSlider: [],
      listings: [],
      categories: [],
    ),
    message: '',
  ).obs;

  var isLoading = true.obs;
  final String token = "208|PSdgfNi58S1qupatJAGm8xzZYcY5zqjvVypQ6BKx";

  @override
  void onInit() {
    checkLocationPermission();
    super.onInit();
  }

  Future<void> checkLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isGranted) {
      getCurrentLocation();
    } else if (status.isDenied) {
      if (await Permission.location.request().isGranted) {
        getCurrentLocation();
      } else {
        Get.snackbar(
            'Permission Denied', 'Location permission is required to proceed.');
      }
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> fetchHomePageData(double latitude, double longitude) async {
    isLoading(true);
    String url =
        "https://ourworks.co.in/sigofish-backend/public/customer/home?latitude=$latitude&longitude=$longitude&limit=10";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        homeData.value = HomeResponse.fromJson(jsonData);
      } else {
        Get.snackbar(
            'Error', 'Failed to load home page data: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      fetchHomePageData(position.latitude, position.longitude);
    } catch (e) {
      Get.snackbar('Error', 'Failed to get location: $e');
    }
  }
}
