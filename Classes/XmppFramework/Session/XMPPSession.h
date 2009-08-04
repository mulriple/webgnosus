//
//  XMPPSession.m
//  webgnosus_client
//
//  Created by Troy Stribling on 3/29/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <Foundation/Foundation.h>
#import "DDXML.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface XMPPSession : NSXMLElement 

//-----------------------------------------------------------------------------------------------------------------------------------
+ (XMPPSession*)createFromElement:(NSXMLElement*)element;
- (XMPPSession*)init;

//-----------------------------------------------------------------------------------------------------------------------------------

@end
