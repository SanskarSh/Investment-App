import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class QRScannerSheet extends StatefulWidget {
  const QRScannerSheet({super.key});

  @override
  State<QRScannerSheet> createState() => _QRScannerSheetState();
}

class _QRScannerSheetState extends State<QRScannerSheet> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;

  QRViewController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestCameraPermission();
  }

  void _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      print("Camera permission granted");
    } else {
      print("Camera permission denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: (result != null)
                ? Text(
                    'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                : const Text('Scan a code'),
          ),
        )
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });

      if (result != null && isUPICode(result!.code)) {
        launchUPI(result!.code);
      }
    });
  }

  bool isUPICode(String? code) {
    // Basic UPI code validation logic
    return code != null && code.startsWith('upi://');
  }

  void launchUPI(String? upiUrl) async {
    if (upiUrl == null) return;

    // Check for installed UPI apps
    List<String> upiApps = [
      'com.google.android.apps.nbu.paisa.user', // Google Pay
      'net.one97.paytm', // Paytm
      'com.phonepe.app', // PhonePe
    ];

    for (String app in upiApps) {
      bool isInstalled = await DeviceApps.isAppInstalled(app);
      if (isInstalled) {
        await launch(upiUrl,
            forceSafariVC: false,
            forceWebView: false,
            universalLinksOnly: true,
            headers: <String, String>{'intent://': 'package=$app'});
        return;
      }
    }

    // If no specific UPI app is found, open with any available app
    if (await canLaunch(upiUrl)) {
      await launch(upiUrl);
    } else {
      throw 'Could not launch $upiUrl';
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
