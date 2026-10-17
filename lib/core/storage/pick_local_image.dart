import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'local_image_provider.dart';

/// Lets the user choose an image from their photos and saves it into the
/// app's local storage for [folder] (see local_image_store.dart).
///
/// Returns a message to show the user, or null if they cancelled. Shared
/// by the UPI QR and business logo screens so both report failures the
/// same specific way.
Future<String?> pickAndSaveLocalImage(WidgetRef ref, String folder, {required String savedMessage}) async {
  final XFile? picked;
  try {
    picked = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1600, imageQuality: 92);
  } on MissingPluginException {
    // The picker's native code isn't in the installed build — happens after
    // hot reload/restart when the plugin was added later.
    return 'Photo picker is not installed in this build. Fully restart the app (stop and run it again).';
  } on PlatformException catch (e) {
    debugPrint('Image pick failed: ${e.code} ${e.message}');
    return e.code.contains('denied')
        ? 'Photo access is turned off. Allow Stock Yard to access photos in your phone settings.'
        : 'Could not open your photos (${e.code}).';
  }
  if (picked == null) return null; // cancelled

  final provider = localImageProvider(folder);
  await ref.read(provider.notifier).save(File(picked.path));
  final error = ref.read(provider).error;
  if (error != null) {
    debugPrint('Image save failed: $error');
    return 'Could not save the image. Please try again.';
  }
  return savedMessage;
}
