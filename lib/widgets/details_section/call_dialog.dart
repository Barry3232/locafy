import 'package:flutter/material.dart';

class CallDialog extends StatelessWidget {
  final String businessName;
  final String phoneNumber;
  final VoidCallback onCall;

  const CallDialog({
    super.key,
    required this.businessName,
    required this.phoneNumber,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.green.shade50,
              child: const Icon(Icons.call, size: 35, color: Colors.green),
            ),

            const SizedBox(height: 20),

            Text(
              businessName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),

            const SizedBox(height: 10),

            Text(
              phoneNumber,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
            ),

            const SizedBox(height: 25),

            const Text(
              "Would you like to call this business?",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      onCall();
                    },
                    icon: const Icon(Icons.call),
                    label: const Text("Call"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
