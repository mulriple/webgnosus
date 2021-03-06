//
//  PubSubViewController.m
//  webgnosus
//
//  Created by Troy Stribling on 9/7/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "PubSubViewController.h"
#import "EventsViewController.h"
#import "AccountModel.h"
#import "SubscriptionModel.h"
#import "ServiceItemModel.h"
#import "AccountPubCell.h"
#import "AccountSubCell.h"
#import "CellUtils.h"
#import "SectionViewController.h"
#import "AccountManagerViewController.h"
#import "AddSubscriptionViewController.h"
#import "AddPublicationViewController.h"

#import "AlertViewManager.h"
#import "SegmentedCycleList.h"

#import "XMPPJID.h"
#import "XMPPIQ.h"
#import "XMPPClientManager.h"
#import "XMPPPubSubOwner.h"
#import "XMPPPubSubSubscriptions.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface PubSubViewController (PrivateAPI)

- (void)failureAlert:(NSString*)message;
- (void)addPubSubItemWasPressed; 
- (void)editAccountButtonWasPressed; 
- (void)labelBackButton;
- (void)loadPubSubItems;
- (void)loadAccount;
- (void)reloadPubSubItems;
- (void)addXMPPClientDelgate;
- (void)removeXMPPClientDelgate;
- (void)addXMPPAccountUpdateDelgate;
- (void)removeXMPPAccountUpdateDelgate;
- (void)addMessageCountUpdateDelgate;
- (void)removeMessageCountUpdateDelgate;
- (EventsViewController*)getEventsViewControllerForRowAtIndexPath:(NSIndexPath*)indexPath;
- (UITableViewCell*)tableView:(UITableView *)tableView createCellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation PubSubViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize addPubSubItemButton;
@synthesize editAccountsButton;
@synthesize pubSubItems;
@synthesize account;
@synthesize sectionViewController;
@synthesize eventType;

//===================================================================================================================================
#pragma mark PubSubViewController

//===================================================================================================================================
#pragma mark PubSubViewController PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addPubSubItemWasPressed { 
    if (self.account) {
        UIViewController* addItemController;
        if (self.eventType == kSUB_MODE) {
            addItemController = [[AddSubscriptionViewController alloc] initWithNibName:@"AddSubscriptionViewController" bundle:nil]; 
        } else {
            addItemController = [[AddPublicationViewController alloc] initWithNibName:@"AddPublicationViewController" bundle:nil]; 
        }
        [self.navigationController pushViewController:addItemController animated:YES]; 
        [addItemController release];     
    }
}	

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)editAccountButtonWasPressed { 
    [AccountManagerViewController inView:self.view.window];
}	

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)createSegementedController {
    CGRect rect = CGRectMake(0.0f, 0.0f, 120.0f, 30.0f);
    self.eventType = kSUB_MODE;
    SegmentedCycleList* segmentControl = 
        [[SegmentedCycleList alloc] init:[NSMutableArray arrayWithObjects:@"Subscriptions", @"Publications", nil] withValueAtIndex:kSUB_MODE andRect:rect];
    segmentControl.delegate = self;
    self.navigationItem.titleView = segmentControl;
    [segmentControl release];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)labelBackButton {
    UIBarButtonItem* temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    if (self.eventType == kSUB_MODE) {
        temporaryBarButtonItem.title = @"Subscriptions";
    } else {
        temporaryBarButtonItem.title = @"Publications";
    }
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    [temporaryBarButtonItem release];  
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadPubSubItems {
    if (self.account) {
        if (self.eventType == kSUB_MODE) {
            self.pubSubItems = [SubscriptionModel findAllByAccount:self.account];
        } else {
            self.pubSubItems = [ServiceItemModel findAllByParentNode:[[self.account toJID] pubSubRoot]];
        }
    }
    [self.tableView reloadData];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addXMPPClientDelgate {
    if (self.account) {
        [[XMPPClientManager instance] delegateTo:self forAccount:self.account];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeXMPPClientDelgate {
    if (self.account) {
        [[XMPPClientManager instance] removeXMPPClientDelegate:self forAccount:self.account];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addXMPPAccountUpdateDelgate {
    [[XMPPClientManager instance] addAccountUpdateDelegate:self];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeXMPPAccountUpdateDelgate {
    [[XMPPClientManager instance] removeAccountUpdateDelegate:self];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addMessageCountUpdateDelgate {
    [[XMPPClientManager instance] addMessageCountUpdateDelegate:self];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeMessageCountUpdateDelgate {
    [[XMPPClientManager instance] removeMessageCountUpdateDelegate:self];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)reloadPubSubItems {
    [self loadAccount];
    [self removeXMPPClientDelgate];
    [self addXMPPClientDelgate];
    [self loadPubSubItems];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadAccount {
    self.account = [AccountModel findFirstDisplayed];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)failureAlert:(NSString*)message { 
    [AlertViewManager dismissActivityIndicator];
    [AlertViewManager showAlert:@"Error" withMessage:message];
}

//===================================================================================================================================
#pragma mark XMPPClientManagerAccountUpdateDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didAddAccount {
    [self reloadPubSubItems];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didRemoveAccount {
    [self reloadPubSubItems];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didUpdateAccount {
    [self reloadPubSubItems];
}

//===================================================================================================================================
#pragma mark XMPPClientDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)client didReceivePubSubDeleteError:(XMPPIQ*)iq {
    [self loadPubSubItems];
    [self failureAlert:@"Node Delete Failed"];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)client didReceivePubSubDeleteResult:(XMPPIQ*)iq {
    [self loadPubSubItems];
    [AlertViewManager dismissActivityIndicator];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)client didReceivePubSubUnsubscribeError:(XMPPIQ*)iq {
    [self loadPubSubItems];
    [self failureAlert:@"Unsubscribe Failed"];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)xmppClient:(XMPPClient*)client didReceivePubSubUnsubscribeResult:(XMPPIQ*)iq {
    [self loadPubSubItems];
    [AlertViewManager dismissActivityIndicator];
}

//===================================================================================================================================
#pragma mark XMPPClientManagerMessageCountUpdateDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)messageCountDidChange {
    [self.tableView reloadData];
}

//===================================================================================================================================
#pragma mark SegmentedCycleList Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)selectedItemChanged:(SegmentedCycleList*)sender {
    self.eventType = sender.selectedItemIndex;
    [self loadPubSubItems];
    [self labelBackButton];
}

//===================================================================================================================================
#pragma mark UIViewController

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithCoder:(NSCoder *)coder { 
	if (self = [super initWithCoder:coder]) { 
        self.addPubSubItemButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPubSubItemWasPressed)] autorelease];
        self.editAccountsButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(editAccountButtonWasPressed)] autorelease];
        self.pubSubItems = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [self createSegementedController];
    self.navigationItem.rightBarButtonItem = self.addPubSubItemButton;
    self.navigationItem.leftBarButtonItem = self.editAccountsButton;
    [self labelBackButton];
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [self loadAccount];
    [self addXMPPClientDelgate];
    [self addXMPPAccountUpdateDelgate];
    [self addMessageCountUpdateDelgate];
    [self loadPubSubItems];
	[super viewWillAppear:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated {
    [self removeXMPPClientDelgate];
    [self removeXMPPAccountUpdateDelgate];
    [self removeMessageCountUpdateDelgate];
	[super viewWillDisappear:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//===================================================================================================================================
#pragma mark UITableViewController

//===================================================================================================================================
#pragma mark UITableViewDeligate

//-----------------------------------------------------------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    if (self.eventType == kSUB_MODE) {
        return kSUB_CELL_HEIGHT;
    } else {
        return kPUB_CELL_HEIGHT;
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* sectionView = nil;
    if (self.account) {
        self.sectionViewController = [SectionViewController viewControllerWithLabel:[self.account bareJID]];
        sectionView = self.sectionViewController.view;
    }
	return sectionView; 
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return kCELL_SECTION_TITLE_HEIGHT;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}

//===================================================================================================================================
#pragma mark UITableViewDataSource

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.account) {
        return 1;
    } else {
        return 0;
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.pubSubItems count];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    if (self.eventType == kSUB_MODE) {
        AccountSubCell* cell = (AccountSubCell*)[CellUtils createCell:[AccountSubCell class] forTableView:tableView];
        SubscriptionModel* item = [self.pubSubItems objectAtIndex:indexPath.row];
        cell.itemLabel.text = [[item.node componentsSeparatedByString:@"/"] lastObject];
        cell.jidLabel.text = [[UserModel nodeToJID:item.node] full];
        cell.account = self.account;
        cell.subscription = item;
        [cell setUnreadMessageCount];
        return cell;
    } else {
        AccountPubCell* cell = (AccountPubCell*)[CellUtils createCell:[AccountPubCell class] forTableView:tableView];
        ServiceItemModel* item = [self.pubSubItems objectAtIndex:indexPath.row];
        cell.itemLabel.text = item.itemName;
        cell.account = self.account;
        cell.serviceItem = item;
        return cell;
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EventsViewController* viewController = [[EventsViewController alloc] initWithNibName:@"EventsViewController" bundle:nil];
    if (self.eventType == kSUB_MODE) {
        SubscriptionModel* item = [self.pubSubItems objectAtIndex:indexPath.row];
        viewController.node = item.node;
        viewController.name = [[item.node componentsSeparatedByString:@"/"] lastObject];
    } else {
        ServiceItemModel* item = [self.pubSubItems objectAtIndex:indexPath.row];
        viewController.service = item.service;
        viewController.node = item.node;
        viewController.name = item.itemName;
    }
    viewController.eventType = self.eventType;
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [addPubSubItemButton release];
    [editAccountsButton release];
    [pubSubItems release];
    [account release];
    [sectionViewController release];
    [super dealloc];
}

@end

