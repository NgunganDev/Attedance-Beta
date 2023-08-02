import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? resultSc;
  void onqrcreate(QRViewController controller) {
    controller.scannedDataStream.listen((event) { 
    setState(() {
      resultSc = event;
    });
    print(resultSc);
    });
  }
  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
     return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.25,
              child: QRView(
                key: qrKey,
                onQRViewCreated: onqrcreate,
              ),
            ),
            Text(resultSc!.code.toString()),
          ],
        ),
      ),
    );
  }
}