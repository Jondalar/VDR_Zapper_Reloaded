/*
 *  wol.h
 *  ZapperReloaded
 *
 *  Created by Alexander Damhuis on 07.01.11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

int Wake_on_LAN(char *ip_broadcast,char *wake_mac);
