//
//  XMPPQuery.m
//  webgnosus
//
//  Created by Troy Stribling on 3/29/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <Foundation/Foundation.h>
#import "DDXML.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface XMPPQuery : NSXMLElement 

//-----------------------------------------------------------------------------------------------------------------------------------
+ (XMPPQuery*)createFromElement:(NSXMLElement*)element;
- (XMPPQuery*)initWithXMLNS:(NSString*)xmlnsVal;

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)node;
- (void)addNode:(NSString*)val;

@end
