import 'package:flutter/material.dart';
import 'package:gliders/src/features/cages/presentation/cages_detail_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodescanScreen extends StatefulWidget {
  const BarcodescanScreen({Key? key}) : super(key: key);

  @override
  createState() => _BarcodescanScreenState();
}

class _BarcodescanScreenState extends State<BarcodescanScreen> with SingleTickerProviderStateMixin {
  String? barcode;

  MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
    formats: [BarcodeFormat.qrCode],
  );

  bool isStarted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              MobileScanner(
                controller: controller,
                fit: BoxFit.contain,
                onDetect: (barcode, args) async {
                  if (barcode.rawValue != null && barcode.rawValue!.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CagesDetailScreen(id: barcode.rawValue.toString()),
                        ));
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
