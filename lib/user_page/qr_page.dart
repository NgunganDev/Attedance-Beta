import 'dart:io';

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
    });
  }

   @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
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
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                ),
              ),
            ),
            Text(resultSc != null ? resultSc!.code.toString() : 'wait scanning'),
          ],
        ),
      ),
    );
  }
}
