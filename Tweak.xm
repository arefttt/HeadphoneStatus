#import <LSStatusBarItem.h>

LSStatusBarItem* sbItem = nil;

static void AVHeadphonesConnectedNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    BOOL isPluggedIn = [[[%c(AVSystemController) sharedAVSystemController] attributeForKey:@"AVSystemController_HeadphoneJackIsConnectedAttribute"] boolValue];
    
%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)arg1 {
	%orig;
	sbItem = [[NSClassFromString(@"LSStatusBarItem") alloc] initWithIdentifier:@"com.arefttt.headphonestatus" alignment:StatusBarAlignmentRight];
	sbItem.imageName = @"Bulb";
	sbItem.visible = NO;
}

%end

%hook AVFlashlight

- (BOOL)setFlashlightLevel:(float)state withError:(id *)arg2 {
	if(state > 0.0) {
		sbItem.visible = YES;
	} else {
		sbItem.visible = NO;
	}
	return %orig;
}

- (void)turnPowerOff {
	%orig;
	sbItem.visible = NO;
}

%end

%hook SBCCQuickLaunchSectionController

- (void)_enableTorch:(BOOL)state {
	%orig;
	if(state) {
		sbItem.visible = YES;
	} else {
		sbItem.visible = NO;
	}
}

%end

%hook AVCaptureDevice

- (void)setTorchMode:(BOOL)state {
	%orig;
	if(state) {
		sbItem.visible = YES;
	} else {
		sbItem.visible = NO;
	}
}

- (void)setFlashMode:(BOOL)state {
	%orig;
	if(state) {
		sbItem.visible = YES;
	} else {
		sbItem.visible = NO;
	}
}

- (BOOL)setTorchModeOnWithLevel:(float)torchLevel error:(NSError **)outError {
	sbItem.visible = YES;
	return %orig;
}

%end

%hook AXVisualAlertSBCCQuickLaunchSectionController

- (void)setFlashlightOn:(BOOL)state {
	%orig;
	if(state) {
		sbItem.visible = YES;
	} else {
		sbItem.visible = NO;
	}
}

%end
