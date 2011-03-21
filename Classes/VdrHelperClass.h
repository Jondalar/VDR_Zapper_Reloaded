//
//  vdr.h
//  ZapperReloaded
//
//  Created by Alexander Damhuis on 02.01.11.
//  Copyright 2011 i.phonedation.de. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VDRObject : NSObject {

	CFSocketRef s;
	
	// VDR Status Variablen
	
	int			channelNumber;
	int			Volume;
	int			VDRPort;
	int			VDRConnectionStatus;
	BOOL		VDRKeepAlive;
	NSString*	VDRHost;
	NSString*	channelName;
		
	NSMutableString* _SocketBuffer;
	
}

@property (nonatomic, retain) NSString* VDRHost;
@property (nonatomic, retain) NSString* channelName;
@property (nonatomic, retain) NSMutableString* _SocketBuffer;



-(void)initVDR:(NSString*)mHost Port:(int)mPort KeepAlive:(BOOL)mBool;
-(void)disconnectVDR;
-(void)sendCommand:(NSString*)Command;
-(void)sendKey:(NSString*)Key;
-(void)wolVDR:(NSString*)_wolBroadcast Mac:(NSString*)_wolMac;


@end


@interface VDRObject (PrivateMethods)
-(void)connectVDR;
-(void)updateStats;
@end
