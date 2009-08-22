//
//  XMPPPubSubSubscription.m
//  webgnosus
//
//  Created by Troy Stribling on 8/8/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "XMPPPubSubSubscription.h"
#import "XMPPPubSub.h"
#import "XMPPIQ.h"
#import "XMPPClient.h"
#import "XMPPJID.h"

//-----------------------------------------------------------------------------------------------------------------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation XMPPPubSubSubscription

//-----------------------------------------------------------------------------------------------------------------------------------

//===================================================================================================================================
#pragma mark XMPPPubSubSubscription

//-----------------------------------------------------------------------------------------------------------------------------------
+ (XMPPPubSubSubscription*)createFromElement:(NSXMLElement*)element {
	XMPPPubSubSubscription* result = (XMPPPubSubSubscription*)element;
	result->isa = [XMPPPubSubSubscription class];
	return result;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)node {
    return [[self attributeForName:@"node"] stringValue];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addNode:(NSString*)val {
    [self addAttributeWithName:@"node" stringValue:val];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)subscription {
    return [[self attributeForName:@"subscription"] stringValue];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addsubScription:(NSString*)val {
    [self addAttributeWithName:@"node" stringValue:val];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)subId {
    return [[[self attributeForName:@"subid"] stringValue] integerValue];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addSubId:(NSInteger)val {
    [self addAttributeWithName:@"subid" stringValue:[NSString stringWithFormat:@"%d'", val]];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (XMPPJID*)JID {
    return [XMPPJID jidWithString:[[self attributeForName:@"jid"] stringValue]];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addJID:(NSString*)val {
    [self addAttributeWithName:@"jid" stringValue:val];
}

//===================================================================================================================================
#pragma mark XMPPPubSubSubscriptions Messages

//-----------------------------------------------------------------------------------------------------------------------------------
+ (void)get:(XMPPClient*)client JID:(XMPPJID*)jid {
    XMPPIQ* iq = [[XMPPIQ alloc] initWithType:@"get" toJID:[jid full]];
    XMPPPubSub* pubsub = [[XMPPPubSub alloc] init];
    [pubsub addChild:[NSXMLElement elementWithName:@"subscriptions"]];	
    [iq addPubSub:pubsub];    
    [client sendElement:iq];
}

@end
