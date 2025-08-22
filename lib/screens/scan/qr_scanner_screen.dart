// lib/screens/scan/qr_scanner_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for HapticFeedback
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  String? _lastCode;
  bool _handling = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_handling) return;

    final code = capture.barcodes.firstOrNull?.rawValue;
    if (code == null || code == _lastCode) return;

    _lastCode = code;
    _handling = true;
    HapticFeedback.mediumImpact();

    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('QR/Barcode detected'),
        content: Text(code),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );

    _handling = false;
  }

  Future<void> _scanFromImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    // mobile_scanner 7.x may return Barcode or BarcodeCapture
    final dynamic result = await _controller.analyzeImage(picked.path);

    String? value;
    if (result is Barcode) {
      value = result.rawValue;
    } else if (result is BarcodeCapture) {
      value = result.barcodes.firstOrNull?.rawValue;
    }

    if (value != null && mounted) {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('From image'),
          content: Text(value!),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan item'),
        actions: [
          IconButton(
            tooltip: 'Pick from gallery',
            icon: const Icon(Icons.photo),
            onPressed: _scanFromImage,
          ),
          IconButton(
            tooltip: 'Flashlight',
            icon: const Icon(Icons.flashlight_on),
            onPressed: () => _controller.toggleTorch(),
          ),
          IconButton(
            tooltip: 'Switch camera',
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => _controller.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            fit: BoxFit.cover,
            onDetect: _onDetect,
          ),
          // Center overlay to guide alignment
          IgnorePointer(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.70,
                height: MediaQuery.of(context).size.width * 0.70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: primary, width: 4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper: safely get first element or null.
extension FirstOrNull<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
