import 'package:flutter/material.dart';

class TicketActionButtons extends StatelessWidget {
  final bool isSaving, isSharing;
  final VoidCallback onShare, onSave;

  const TicketActionButtons({
    super.key,
    required this.isSaving,
    required this.isSharing,
    required this.onShare,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: isSharing ? null : onShare,
          icon: isSharing 
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : const Icon(Icons.share),
          label: Text(isSharing ? "Sharing..." : "Share"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        ),
        ElevatedButton.icon(
          onPressed: isSaving ? null : onSave,
          icon: isSaving 
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : const Icon(Icons.download),
          label: Text(isSaving ? "Saving..." : "Download"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
      ],
    );
  }
}
