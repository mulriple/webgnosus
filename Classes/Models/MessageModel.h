//
//  Message.h
//  webgnosus
//
//  Created by Troy Stribling on 2/24/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <Foundation/Foundation.h>
#import <sqlite3.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class UserModel;
@class XMPPxData;
@class XMPPEntry;
@class XMPPClient;
@class XMPPMessage;
@class XMPPIQ;

//-----------------------------------------------------------------------------------------------------------------------------------
typedef enum tagMessageTextType {
    MessageTextTypeBody,
    MessageTextTypeCommandText,
    MessageTextTypeCommandXData,
    MessageTextTypeEventText,
    MessageTextTypeEventEntry,
    MessageTextTypeEventxData
} MessageTextType;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MessageModel : NSObject {
	NSInteger pk;
    NSString* messageText;
    NSDate* createdAt;
	NSInteger accountPk;
	NSString* toJid;
	NSString* fromJid;
    MessageTextType textType;
    NSString* node;
    NSString* itemId;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, assign) NSInteger pk;
@property (nonatomic, retain) NSString* messageText;
@property (nonatomic, retain) NSDate* createdAt;
@property (nonatomic, assign) NSInteger accountPk;
@property (nonatomic, assign) NSString* toJid;
@property (nonatomic, assign) NSString* fromJid;
@property (nonatomic, assign) MessageTextType textType;
@property (nonatomic, assign) NSString* node;
@property (nonatomic, assign) NSString* itemId;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (NSInteger)count;
+ (NSInteger)countWithLimit:(NSInteger)requestLimit;
+ (NSInteger)countByJid:(NSString*)requestJID andAccount:(AccountModel*)requestAccount;
+ (NSInteger)countByJid:(NSString*)requestJID account:(AccountModel*)requestAccount andTextType:(MessageTextType)requestType withLimit:(NSInteger)requestLimit;
+ (NSInteger)countByJid:(NSString*)requestJID andAccount:(AccountModel*)requestAccount withLimit:(NSInteger)requestLimit;
+ (void)drop;
+ (void)create;
+ (NSMutableArray*)findAll;
+ (NSMutableArray*)findAllWithLimit:(NSInteger)requestLimit;
+ (NSMutableArray*)findAllByAccount:(AccountModel*)requestAccount;
+ (NSMutableArray*)findAllByAccount:(AccountModel*)requestAccount withLimit:(NSInteger)requestLimit;
+ (NSMutableArray*)findAllByJid:(NSString*)requestJID andAccount:(AccountModel*)requestAccount;
+ (NSMutableArray*)findAllCommandsByJid:(NSString*)requestJID andAccount:(AccountModel*)requestAccount withLimit:(NSInteger)requestLimit;
+ (NSMutableArray*)findAllSubscribedEventsByNode:(NSString*)requestNode withLimit:(NSInteger)requestLimit;
+ (NSMutableArray*)findAllPublishedEventsByNode:(NSString*)requestNode withLimit:(NSInteger)requestLimit;
+ (NSMutableArray*)findAllByJid:(NSString*)requestJID account:(AccountModel*)requestAccount andTextType:(MessageTextType)requestType withLimit:(NSInteger)requestLimit;
+ (NSMutableArray*)findAllByJid:(NSString*)requestJID andAccount:(AccountModel*)requestAccount withLimit:(NSInteger)requestLimit;
+ (MessageModel*)findEventByNode:(NSString*)requestNode andItemId:(NSString*)requestItemId;
+ (MessageModel*)findByPk:(NSInteger)requestPk;
+ (void)destroyAllByAccount:(AccountModel*)requestAccount;
+ (void)insert:(XMPPClient*)client message:(XMPPMessage*)message;
+ (void)insertEvent:(XMPPClient*)client forMessage:(XMPPMessage*)message;
+ (void)insertPubSubItems:(XMPPClient*)client forIq:(XMPPIQ*)iq;
+ (void)insert:(XMPPClient*)client commandResult:(XMPPIQ*)iq;

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)insert;
- (void)destroy;
- (void)update;
- (NSString*)createdAtAsString;
- (XMPPxData*)parseXDataMessage;
- (XMPPEntry*)parseEntryMessage;

@end
