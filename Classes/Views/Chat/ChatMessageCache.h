//
//  ChatMessageCache.h
//  webgnosus
//
//  Created by Troy Stribling on 10/29/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "MessageCache.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ChatMessageCache : MessageCache {
    NSString* jid;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) NSString* jid;

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithJid:(NSString*)initJid andAccount:(AccountModel*)initAccount;

@end
