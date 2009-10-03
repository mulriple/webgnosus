//
//  XMPPEntry.m
//  webgnosus
//
//  Created by Troy Stribling on 10/2/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "XMPPEntry.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation XMPPEntry

//===================================================================================================================================
#pragma mark XMPPEntry

//-----------------------------------------------------------------------------------------------------------------------------------

//===================================================================================================================================
#pragma mark XMPPEntry

//-----------------------------------------------------------------------------------------------------------------------------------
+ (XMPPEntry*)createFromElement:(NSXMLElement*)element {
    XMPPEntry* result = (XMPPEntry*)element;
    result->isa = [XMPPEntry class];
    return result;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (XMPPEntry*)init {
	if(self = [super initWithName:@"event"]) {
        [self addNamespace:[NSXMLNode namespaceWithName:@"" stringValue:@"http://www.w3.org/2005/Atom"]];
	}
	return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (XMPPEntry*)initWithSummary:(NSString*)msgSummary {
	if(self = [self init]) {
        [self addSummary:msgSummary];
	}
    return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)summary {
	return [[self elementForName:@"summary"] stringValue];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addSummary:(NSString*)val {
	[self addChild:[NSXMLElement elementWithName:@"summary" stringValue:val]];	
}

@end
