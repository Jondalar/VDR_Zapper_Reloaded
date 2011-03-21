//
//  ZapperReloadedAppDelegate.h
//  ZapperReloaded
//
//  Created by Alexander Damhuis on 02.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZapperReloadedViewController;

@interface ZapperReloadedAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ZapperReloadedViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ZapperReloadedViewController *viewController;

@end

