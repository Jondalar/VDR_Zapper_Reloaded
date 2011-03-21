//
//  ZapperReloadedViewController.h
//  ZapperReloaded
//
//  Created by Alexander Damhuis on 02.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
// com.yourcompany.${PRODUCT_NAME:rfc1034identifier} sollte er sein!
//

#import <UIKit/UIKit.h>
#import "VdrHelperClass.h"

@interface ZapperReloadedViewController : UIViewController <UIActionSheetDelegate> {
	
	VDRObject* myVDR;
	NSTimer* startUpTimer;
	NSTimer* refreshTimer;
	
}

@property (nonatomic, retain) VDRObject* myVDR;
@property (nonatomic, retain) NSTimer* startUpTimer;
@property (nonatomic, retain) NSTimer* refreshTimer;

// Button Actions
-(IBAction)buttonPowerPressed:(id)sender;
-(IBAction)buttonRedPressed:(id)sender;
-(IBAction)buttonGreenPressed:(id)sender;
-(IBAction)buttonYellowPressed:(id)sender;
-(IBAction)buttonBluePressed:(id)sender;

-(IBAction)buttonOnePressed:(id)sender;
-(IBAction)buttonTwoPressed:(id)sender;
-(IBAction)buttonThreePressed:(id)sender;
-(IBAction)buttonFourPressed:(id)sender;
-(IBAction)buttonFivePressed:(id)sender;
-(IBAction)buttonSixPressed:(id)sender;
-(IBAction)buttonSevenPressed:(id)sender;
-(IBAction)buttonEightPressed:(id)sender;
-(IBAction)buttonNinePressed:(id)sender;
-(IBAction)buttonZeroPressed:(id)sender;

-(IBAction)buttonInfoPressed:(id)sender;
-(IBAction)buttonBackPressed:(id)sender;
-(IBAction)buttonMenuPressed:(id)sender;
-(IBAction)buttonMutePressed:(id)sender;
-(IBAction)buttonAudioPressed:(id)sender;

-(IBAction)buttonUpPressed:(id)sender;
-(IBAction)buttonDownPressed:(id)sender;
-(IBAction)buttonRightPressed:(id)sender;
-(IBAction)buttonLeftPressed:(id)sender;
-(IBAction)buttonOkPressed:(id)sender;

-(IBAction)buttonRecordingsPressed:(id)sender;
-(IBAction)buttonPlayPressed:(id)sender;
-(IBAction)buttonUserPressed:(id)sender;


-(IBAction)sliderMoved:(id)sender;
-(IBAction)showActionSheet:(id)sender;


@end

