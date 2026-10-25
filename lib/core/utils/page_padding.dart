import 'package:flutter/widgets.dart';

/// Padding for a scrollable form/settings page whose last item is its
/// action button.
///
/// A ListView only adds the system bars' space by itself when it has no
/// explicit padding; with one (as every form here has), its last item can
/// end up under the Android navigation buttons on edge-to-edge devices.
/// This keeps the even [all] gutter and adds the bottom system inset on
/// top. `paddingOf` (not `viewPaddingOf`) so the extra space disappears
/// while the keyboard is open and already pushing content up.
EdgeInsets pagePadding(BuildContext context, {double all = 16}) =>
    EdgeInsets.fromLTRB(all, all, all, all + MediaQuery.paddingOf(context).bottom);
