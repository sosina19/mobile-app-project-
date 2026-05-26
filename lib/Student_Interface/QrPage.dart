import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPage extends StatelessWidget {
  final String id;
  final String name;

  const QrPage({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    final String qrData = '{"id":"$id","name":"$name"}';
    // 1. Check if global Dark Mode is enabled
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // 2. Dynamic canvas layout matching colors
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth > 600
              ? 600
              : constraints.maxWidth;

          return Center(
            child: SingleChildScrollView(
              child: Container(
                width: maxWidth,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Student Portal Top Header Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        // Slightly adapts blue shade for dark mode
                        color: isDark
                            ? const Color(0xFF143252)
                            : const Color(0xFF1E4B7A),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 5),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Student Portal",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 253, 253, 253),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Dire Dawa University",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark
                                      ? Colors.grey[400]
                                      : Colors.grey[300],
                                ),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.school,
                                size: 16,
                                color: isDark
                                    ? Colors.grey[400]
                                    : Colors.grey[300],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Middle Student Info Info Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        // Dark grey card base background or crisp off-white structure
                        color: isDark
                            ? Colors.grey[900]
                            : const Color.fromARGB(255, 250, 251, 252),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "MY QR CODE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? const Color(0xFF5B92E5)
                                  : const Color(0xFF1E4B7A),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF143252)
                                      : const Color(0xFF1E4B7A),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Color.fromARGB(255, 253, 253, 253),
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: isDark
                                            ? Colors.white
                                            : const Color.fromARGB(
                                                255,
                                                15,
                                                15,
                                                15,
                                              ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // QR Code Container Box
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        // Keep this background block white so physical scanners can see it cleanly!
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 5),
                        ],
                      ),
                      child: QrImageView(
                        data: qrData,
                        size: 200,
                        backgroundColor: Colors.white,
                        // Force the actual lines/modules of the QR code to stay dark black
                        eyeStyle: const QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: Colors.black,
                        ),
                        dataModuleStyle: const QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.square,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Ready Badge UI Indicator component
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified, color: Colors.white, size: 16),
                          SizedBox(width: 5),
                          Text(
                            "READY TO SCAN",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Dynamic Bottom Guide Text
                    Text(
                      "Hold your device steady in front of the scanner for instant attendance verification",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.grey[400] : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
