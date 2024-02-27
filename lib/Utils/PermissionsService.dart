import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  static requestPermission() async {
    await [Permission.location, Permission.camera].request();
  }

  static Future<bool> hasPermission() async {
    bool isAllCheckPermission = true;
    if (await Permission.location.request().isPermanentlyDenied) {
      await openAppSettings();
      isAllCheckPermission = false;
    } else if (await Permission.camera.request().isPermanentlyDenied) {
      await openAppSettings();
      isAllCheckPermission = false;
    }
    return isAllCheckPermission;
  }
}
