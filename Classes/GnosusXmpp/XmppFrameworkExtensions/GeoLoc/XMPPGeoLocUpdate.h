//
//  XMPPGeoLocUpdate.h
//  webgnosus
//
//  Created by Troy Stribling on 7/30/10.
//  Copyright 2010 Plan-B Reserach. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <Foundation/Foundation.h>
#import "GeoLocManager.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface XMPPGeoLocUpdate : NSObject <GeoLocUpdateDelegate> {
    AccountModel* account;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) AccountModel* account;

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)init:(AccountModel*)initAcct;

@end
