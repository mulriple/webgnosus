//
//  XMPPEntry.h
//  webgnosus
//
//  Created by Troy Stribling on 10/2/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <Foundation/Foundation.h>
#import "NSXMLElementAdditions.h"

//-----------------------------------------------------------------------------------------------------------------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface XMPPEntry : NSXMLElement 

//-----------------------------------------------------------------------------------------------------------------------------------
+ (XMPPEntry*)createFromElement:(NSXMLElement*)element;
- (XMPPEntry*)init;
- (XMPPEntry*)initWithSummary:(NSString*)msgBody;

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)summary;
- (void)addSummary:(NSString*)val;

@end
