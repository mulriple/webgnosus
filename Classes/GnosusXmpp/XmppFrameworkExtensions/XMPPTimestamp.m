//
//  XMPPTimestamp.m
//  webgnosus
//
//  Created by Troy Stribling on 7/31/10.
//  Copyright 2010 Plan-B Reserach. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "XMPPTimestamp.h"


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface XMPPTimestamp (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation XMPPTimestamp

//-----------------------------------------------------------------------------------------------------------------------------------

//===================================================================================================================================
#pragma mark XMPPTimestamp

//-----------------------------------------------------------------------------------------------------------------------------------
+ (NSDateFormatter*)dateFormatter {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-ddTHH:mm:ssZ"];
    return dateFormatter;
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (NSString*)stringFromDate:(NSDate*)val {
    return [[self dateFormatter] stringFromDate:val];
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (NSDate*)dateFromString:(NSString*)val {
    return [[self dateFormatter] dateFromString:val];
}

@end
