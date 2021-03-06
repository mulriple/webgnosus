//
//  XMPPDiscoFeature.h
//  webgnosus
//
//  Created by Troy Stribling on 8/4/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <Foundation/Foundation.h>
#import "NSXMLElementAdditions.h"

//-----------------------------------------------------------------------------------------------------------------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface XMPPDiscoFeature : NSXMLElement

//-----------------------------------------------------------------------------------------------------------------------------------
+ (XMPPDiscoFeature*)createFromElement:(NSXMLElement*)element;
+ (XMPPDiscoFeature*)messageWithVar:(NSString*)featVar;
- (XMPPDiscoFeature*)initWithVar:(NSString*)featVar;

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)var;
- (void)addVar:(NSString*)val;

@end
