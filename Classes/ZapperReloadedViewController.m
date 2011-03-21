//
//  ZapperReloadedViewController.m
//  ZapperReloaded
//
//  Created by Alexander Damhuis on 02.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ZapperReloadedViewController.h"
#import "VdrHelperClass.h"


@implementation ZapperReloadedViewController

@synthesize myVDR, startUpTimer, refreshTimer; 



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// get Properties
	
	NSString* key=[[NSString alloc] initWithString:@"hostname"];
	CFStringRef* prop = (CFStringRef*)CFPreferencesCopyAppValue((CFStringRef)key, kCFPreferencesCurrentApplication);
	
	
	// Property not set
	if (!prop) {
		
		prop=(CFStringRef*)[[NSString alloc] initWithString:@"video.local"];
		CFPreferencesSetAppValue((CFStringRef)key, prop, kCFPreferencesCurrentApplication);
	}
	
	
	
	
	
	myVDR = [VDRObject alloc];
	
	startUpTimer = [NSTimer scheduledTimerWithTimeInterval: 0.3 target:self selector:@selector(myVDRInitTimer:) userInfo:nil repeats: NO];
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(connectionFailureHandling:)
												 name:@"VDRConnectionError"
											   object:nil ] ;
	
	
}


// Init im Hintergrund ausführen während View geladen und aufgebaut wird
-(void) myVDRInitTimer: (NSTimer *) initTimer {
	
	
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *hostname= [defaults stringForKey:@"hostname"];
	
	if (!hostname) {
		hostname = @"video.local";
	}
	
	NSString *vdrPort= [defaults stringForKey:@"Port"];
	
	if (!vdrPort) {		
		vdrPort = @"6419";
	}
	
	BOOL keepAlive = [defaults boolForKey:@"VDRKeepAlive"];
					  
					  
	[myVDR initVDR:hostname Port:[vdrPort intValue] KeepAlive:keepAlive];
	
}

-(void)connectionFailureHandling:(NSNotification *)notification
{
	[self showActionSheet:self];
}

-(IBAction)showActionSheet:(id)sender
{
//	NSLog(@"Notification VDRConnectionError angekommen!");
	
	UIActionSheet* actionSheet = [[UIActionSheet alloc]
								  initWithTitle:@"Warning - Connect failed !!!"
								  delegate:self
								  cancelButtonTitle:@"Cancel"
								  destructiveButtonTitle:@"Use wake on Lan" 
								  otherButtonTitles:nil];
	
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	[actionSheet showInView:self.view];
	[actionSheet release];
	
	
//	[myVDR wolVDR:@"192.168.0.255" Mac:@"00:17:f2:2e:45:0b"];
	
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0) {
		NSLog(@"WOL Button gedrückt");
		
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		NSString *wolMAC= [defaults stringForKey:@"wolMAC"];
		
		if (!wolMAC) {
			wolMAC = @"01:02:03:04:05:06:07:08";
		}
		
		NSString *wolBcast= [defaults stringForKey:@"wolBcast"];
		
		if (!wolBcast) {		
			wolBcast = @"192.168.0.255";
		}
			
		[myVDR wolVDR:wolBcast Mac:wolMAC];
		
		
		
//		[NSThread sleepForTimeInterval:3];
		
//		startUpTimer = [NSTimer scheduledTimerWithTimeInterval: 0.3 target:self selector:@selector(myVDRInitTimer:) userInfo:nil repeats: NO];
	
	
	
	} else {
	//	NSLog(@"NO gedrück!");
	//	[myVDR disconnectVDR];
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:@"Warning!"
							  message:@"Close Zapper and check your settings!" 
							  delegate:self
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		
	}
}




/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark Button actions

-(IBAction)buttonPowerPressed:(id)sender
{
	[myVDR sendKey:@"Power"];
}

-(IBAction)buttonRedPressed:(id)sender
{
	[myVDR sendKey:@"Red"];
}

-(IBAction)buttonGreenPressed:(id)sender
{
	[myVDR sendKey:@"Green"];
}

-(IBAction)buttonYellowPressed:(id)sender
{
	[myVDR sendKey:@"Yellow"];
}

-(IBAction)buttonBluePressed:(id)sender
{
	[myVDR sendKey:@"Blue"];
}


-(IBAction)buttonOnePressed:(id)sender
{
//	NSLog(@"1 Gedrückt");
	[myVDR sendKey:@"1"];
}

-(IBAction)buttonTwoPressed:(id)sender
{
	[myVDR sendKey:@"2"];
}

-(IBAction)buttonThreePressed:(id)sender
{
	[myVDR sendKey:@"3"];
}

-(IBAction)buttonFourPressed:(id)sender
{
	[myVDR sendKey:@"4"];
}

-(IBAction)buttonFivePressed:(id)sender
{
	[myVDR sendKey:@"5"];
}

-(IBAction)buttonSixPressed:(id)sender
{
	[myVDR sendKey:@"6"];
}

-(IBAction)buttonSevenPressed:(id)sender
{
	[myVDR sendKey:@"7"];
}

-(IBAction)buttonEightPressed:(id)sender
{
	[myVDR sendKey:@"8"];
}

-(IBAction)buttonNinePressed:(id)sender
{
	[myVDR sendKey:@"9"];
}

-(IBAction)buttonZeroPressed:(id)sender
{
	[myVDR sendKey:@"0"];
}


-(IBAction)buttonInfoPressed:(id)sender
{
	[myVDR sendKey:@"Info"];
}

-(IBAction)buttonBackPressed:(id)sender
{
	[myVDR sendKey:@"Back"];
}

-(IBAction)buttonMenuPressed:(id)sender
{
	[myVDR sendKey:@"Menu"];
}

-(IBAction)buttonMutePressed:(id)sender
{
	[myVDR sendKey:@"Mute"];
}

-(IBAction)buttonAudioPressed:(id)sender
{
	[myVDR sendKey:@"Audio"];
}


-(IBAction)buttonUpPressed:(id)sender
{
	[myVDR sendKey:@"Up"];
}

-(IBAction)buttonDownPressed:(id)sender
{
	[myVDR sendKey:@"Down"];
}

-(IBAction)buttonRightPressed:(id)sender
{
	[myVDR sendKey:@"Right"];}

-(IBAction)buttonLeftPressed:(id)sender
{
	[myVDR sendKey:@"Left"];
}

-(IBAction)buttonOkPressed:(id)sender
{
	[myVDR sendKey:@"Ok"];
}

-(IBAction)buttonRecordingsPressed:(id)sender
{
	[myVDR sendKey:@"Recordings"];
}

-(IBAction)buttonPlayPressed:(id)sender
{
	[myVDR sendKey:@"Play"];
}

-(IBAction)buttonUserPressed:(id)sender
{
	[myVDR sendKey:@"User0"];
}



-(IBAction)sliderMoved:(id)sender
{
	NSLog(@"VOLU %.0f", [(UISlider*) sender value]);
	[myVDR sendCommand:[NSString stringWithFormat:@"VOLU %.0f\n", [(UISlider*) sender value]]];
	
}






@end
