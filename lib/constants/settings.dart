import 'package:flutter/foundation.dart';

bool kManualEnableEmbedsOverride = false;
bool kEnableEmbeds = kReleaseMode || kManualEnableEmbedsOverride;
