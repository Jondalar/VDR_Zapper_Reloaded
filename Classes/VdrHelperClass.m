//
//  vdr.m
//  ZapperReloaded
//
//  Created by Alexander Damhuis on 02.01.11.
//  Copyright 2011 i.phonedation.de. All rights reserved.
//

#import "VdrHelperClass.h"
#import <CoreFoundation/CFSocket.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#import "wol.h"

@implementation VDRObject

@synthesize _SocketBuffer, VDRHost, channelName;

// C Funktion inkl. RunLoop setup

void receiveData(CFSocketRef s, 
				 CFSocketCallBackType type, 
				 CFDataRef address, 
				 const void *data, 
				 void *info)
{
    CFDataRef df = (CFDataRef) data;
    int len = CFDataGetLength(df);
    if(len <= 0) return;
    
    CFRange range = CFRangeMake(0,len);
    UInt8 buffer[len];
 //   NSLog(@"Received %d bytes from socket %d\n", len, CFSocketGetNative(s));
    CFDataGetBytes(df, range, buffer);
//    NSLog(@"Client received: %s\n", buffer); 
	//    NSLog(@"As UInt8 coding: %@", df);

}


// Send Key, Kapsel um SenCommand so dass einfach nur der String der Taste übergeben werden muss
-(void) sendKey:(NSString*)Key
{
	NSString* Command = [NSString stringWithFormat:@"HITK %@\n", Key];
	[self sendCommand:Command];

	/*
	// Auto Quit
	if (VDRKeepAlive == NO)
	{
		NSLog(@"KeepAlive ist NICHT aktiv!");
		[self sendCommand:@"QUIT\n"];
	} 
	 
	 */
}



// SendCommand übergibt einen SVDRP-UTF8-String an VDR, \n muss am Ende stehen um <RETURN> zu simluieren!

-(void) sendCommand:(NSString*)Command
{
	// KeepAlive einbauen, also ohne quit\n am Ende mitschicken automatisch!
	
	if ((!s) || (VDRConnectionStatus != 0)) {
		NSLog(@"Socket weg!");
		[self connectVDR];
		
	}
	
	// CF C-basiertes Schreiben in den Socket
	CFDataRef data = CFDataCreate(NULL, (const UInt8 *)[Command UTF8String], [Command lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
	VDRConnectionStatus = CFSocketSendData(s, NULL, data, 1);
	if (VDRConnectionStatus != 0) {
		[self connectVDR];
	}
	CFRelease(data);
}

// Socket aufbauen und Kommunikation auf den Runloop schieben
-(void)initVDR:(NSString*)mHost Port:(int)mPort KeepAlive:(BOOL)mBool
{
	VDRHost = [NSString stringWithString:mHost];
	VDRPort = mPort;
	VDRKeepAlive = mBool;

	[self connectVDR];
	
/*	
	// Ab hier das Update der Instanzvariablen mit den relevanten Inhalten
 
	NSLog(@"TEST");
	
	[self updateStats];*/

}



- (void)disconnectVDR
{
	[self sendCommand:@"QUIT\n"];
	//CFRelease(s);
}
// Private Methods!

-(void)updateStats
{
	NSLog(@"Stati holen!");
	
	// VOLU absetzen und Parsen
	Volume = 255;
				   
	
	// CHAN absetzen und Parsen
	channelName = [NSString stringWithString:@"Das Erste HD"];
	channelNumber = 1;
	
	NSLog(@"Volume = %i Kanal = %i %@", Volume, channelNumber, channelName);
	
}

-(void)connectVDR
{
	
	NSLog(@"Aus VDRHost // VDR Port: Instanzvariablen - Host: %@ Port: %i", VDRHost, VDRPort);
		
		NSLog(@"no socket exists!");
		
		s = CFSocketCreate(NULL, PF_INET, 
						   SOCK_STREAM, IPPROTO_TCP, 
						   kCFSocketDataCallBack, 
						   receiveData, 
						   NULL);
		struct sockaddr_in      sin; 
		struct hostent          *host;
		
		memset(&sin, 0, sizeof(sin));
		/*
		host = gethostbyname([VDRHost UTF8String]); 
		*/
		
		if (host = gethostbyname([VDRHost UTF8String]))
		{
//			NSLog(@"Conection is good! 1");
		} else {
			NSLog(@"Error! jump into WOL");
			[[NSNotificationCenter defaultCenter] postNotificationName:@"VDRConnectionError" 
																object:nil ];
			return;
		}

		
		memcpy(&(sin.sin_addr), host->h_addr,host->h_length); 
		
		sin.sin_family = AF_INET;
		sin.sin_port = htons(VDRPort);
		
//		NSLog(@"Conection is good! 2");
		
		CFDataRef address;
		CFRunLoopSourceRef source;
		
//		NSLog(@"Conection is good! 3");
		address = CFDataCreate(NULL, (UInt8 *)&sin, sizeof(sin));
		
//		NSLog(@"Conection is good! 4");
		
		VDRConnectionStatus = CFSocketConnectToAddress(s, address, 2);
		if (VDRConnectionStatus != 0)
		{
			[[NSNotificationCenter defaultCenter] postNotificationName:@"VDRConnectionError" 
																object:nil ];
			return;
		}
			
		
		
		CFRelease(address);
		
		source = CFSocketCreateRunLoopSource(NULL, s, 0);
		CFRunLoopAddSource(CFRunLoopGetCurrent(), 
						   source, 
						   kCFRunLoopDefaultMode);
		CFRelease(source);
		CFRunLoopRun();	

	
	
}


-(void)wolVDR:(NSString*)_wolBroadcast Mac:(NSString*)_wolMac
{
	NSLog(@"VDR Wake on Lan für MAC: %s auf BroadCast %@", [_wolMac UTF8String], _wolBroadcast);
	
	
	Wake_on_LAN([_wolBroadcast UTF8String], [_wolMac UTF8String]);
	NSLog(@"WOL done!");
	
	
}



// Dealloc usw

- (void)dealloc {
	[VDRHost release];
	[channelName release];
	[_SocketBuffer release];
    [super dealloc];
}



@end
