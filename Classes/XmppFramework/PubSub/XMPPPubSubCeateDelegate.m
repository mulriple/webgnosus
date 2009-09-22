//
//  XMPPPubSubCeateDelegate.m
//  webgnosus
//
//  Created by Troy Stribling on 9/19/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "XMPPPubSubCeateDelegate.h"
#import "XMPPDiscoItemsQuery.h"
#import "XMPPResponse.h"
#import "XMPPJID.h"
#import "XMPPClient.h"
#import "XMPPStanza.h"
#import "XMPPIQ.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface XMPPPubSubCeateDelegate (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation XMPPPubSubCeateDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize targetJID;

//===================================================================================================================================
#pragma mark XMPPPubSubCeateDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)init:(XMPPJID*)initJID {
	if(self = [super init])  {
        self.targetJID = initJID;
	}
	return self;
}

//===================================================================================================================================
#pragma mark XMPPPubSubCeateDelegate PrivateAPI

//===================================================================================================================================
#pragma mark XMPPResponse Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)handleError:(XMPPClient*)client forStanza:(XMPPStanza*)stanza {
    [[client multicastDelegate] xmppClient:client didReceiveSubscriptionsError:(XMPPIQ*)stanza];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)handleResult:(XMPPClient*)client forStanza:(XMPPStanza*)stanza {
    [[client multicastDelegate] xmppClient:client didReceiveSubscriptionsResult:(XMPPIQ*)stanza];
    [XMPPDiscoItemsQuery get:client JID:[stanza fromJID] node:[self.targetJID pubSubRoot] forTarget:self.targetJID];
}

//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [super dealloc];
}

@end
