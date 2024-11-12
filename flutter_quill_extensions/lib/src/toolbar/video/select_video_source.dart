import 'package:flutter/material.dart';
import 'package:flutter_quill/internal.dart';

import 'config/video.dart';

class SelectVideoSourceDialog extends StatelessWidget {
  final QuillToolbarVideoConfig? config;
  const SelectVideoSourceDialog({super.key, this.config});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 200),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (config?.enableGallery ?? true)
              ListTile(
                title: Text(context.loc.gallery),
                subtitle: Text(
                  context.loc.pickAVideoFromYourGallery,
                ),
                leading: const Icon(Icons.photo_sharp),
                onTap: () => Navigator.of(context).pop(InsertVideoSource.gallery),
              ),
            if (config?.enableCamera ?? true)
              ListTile(
                title: Text(context.loc.camera),
                subtitle: Text(context.loc.recordAVideoUsingYourCamera),
                leading: const Icon(Icons.camera),
                enabled: !isDesktopApp,
                onTap: () => Navigator.of(context).pop(InsertVideoSource.camera),
              ),
            ListTile(
              title: Text(context.loc.link),
              subtitle: Text(
                context.loc.pasteAVideoUsingALink,
              ),
              leading: const Icon(Icons.link),
              onTap: () => Navigator.of(context).pop(InsertVideoSource.link),
            ),
          ],
        ),
      ),
    );
  }
}

Future<InsertVideoSource?> showSelectVideoSourceDialog({
  required BuildContext context, QuillToolbarVideoConfig? config,
}) async {
  final imageSource = await showModalBottomSheet<InsertVideoSource>(
    showDragHandle: true,
    context: context,
    constraints: const BoxConstraints(maxWidth: 640),
    builder: (context) => SelectVideoSourceDialog(config: config),
  );
  return imageSource;
}
