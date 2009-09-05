//
//  EditAccountViewController.h
//  webgnosus
//
//  Created by Troy Stribling on 2/6/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class AccountManagerViewController;
@class AccountsViewController;
@class SegmentedListPicker;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface EditAccountViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet UITextField* passwordTextField;
 	IBOutlet UITextField* reenterPasswordTextField;
    IBOutlet UILabel* statusLable;
    IBOutlet UIButton* doneButton;
    IBOutlet UIButton* deleteButton;
    IBOutlet UIButton* addButton;
    IBOutlet UIButton* sendPasswordButton;   
    SegmentedListPicker* activeAccounts;
    AccountManagerViewController* managerView;
    AccountsViewController* accountsViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UITextField* passwordTextField;
@property (nonatomic, retain) UITextField* reenterPasswordTextField;
@property (nonatomic, retain) UIButton* doneButton;
@property (nonatomic, retain) UIButton* deleteButton;
@property (nonatomic, retain) UIButton* addButton;
@property (nonatomic, retain) UIButton* sendPasswordButton;
@property (nonatomic, retain) UILabel* statusLable;
@property (nonatomic, retain) SegmentedListPicker* activeAccounts;
@property (nonatomic, retain) AccountManagerViewController* managerView;
@property (nonatomic, retain) AccountsViewController* accountsViewController;

//-----------------------------------------------------------------------------------------------------------------------------------
- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)addButtonPressed:(id)sender;
- (IBAction)deleteButtonPressed:(id)sender;
- (IBAction)sendPasswordButtonPressed:(id)sender;

//-----------------------------------------------------------------------------------------------------------------------------------
- (AccountModel*)account;
    
@end
