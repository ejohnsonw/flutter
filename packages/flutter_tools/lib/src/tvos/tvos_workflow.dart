// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart = 2.8

import 'package:meta/meta.dart';

import '../base/platform.dart';
import '../doctor.dart';
import '../features.dart';
import '../macos/xcode.dart';

class TVOSWorkflow implements Workflow {
  const TVOSWorkflow({
    @required Platform platform,
    @required FeatureFlags featureFlags,
    @required Xcode xcode,
  }) : _platform = platform,
       _featureFlags = featureFlags,
       _xcode = xcode;

  final Platform _platform;
  final FeatureFlags _featureFlags;
  final Xcode _xcode;

  @override
  bool get appliesToHostPlatform => _featureFlags.isTVOSEnabled && _platform.isMacOS;

  // We need xcode (+simctl) to list simulator devices, and libimobiledevice to list real devices.
  @override
  bool get canListDevices => _xcode.isInstalledAndMeetsVersionCheck && _xcode.isSimctlInstalled;

  // We need xcode to launch simulator devices, and ios-deploy
  // for real devices.
  @override
  bool get canLaunchDevices => _xcode.isInstalledAndMeetsVersionCheck;

  @override
  bool get canListEmulators => false;
}
