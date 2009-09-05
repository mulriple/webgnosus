//
//  SegmentedListPicker.m
//  webgnosus
//
//  Created by Troy Stribling on 8/29/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "SegmentedListPicker.h"
#import "AccountModel.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SegmentedListPicker (PrivateAPI)

- (void)segmentControlSelectionChanged:(id)sender;
- (UIImage*)renderTextAsImage:(CGRect)rect;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SegmentedListPicker

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize items;
@synthesize selectedItemIndex;
@synthesize font;

//===================================================================================================================================
#pragma mark SegmentedListPicker

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)init:(NSArray*)list withValueAtIndex:(NSInteger)index andRect:(CGRect)rect {
    self.items = list;
    self.selectedItemIndex = index;
    self.font = [UIFont boldSystemFontOfSize:16];
    if (self = [super initWithItems:[[NSArray alloc] initWithObjects:[UIImage imageNamed:@"left-arrow.png"], [self renderTextAsImage:rect], 
                                     [UIImage imageNamed:@"right-arrow.png"], nil]]) {
        [self addTarget:self action:@selector(segmentControlSelectionChanged:) forControlEvents:UIControlEventValueChanged];
        self.frame = rect;
        self.momentary = YES;
        self.segmentedControlStyle = UISegmentedControlStyleBar;
        self.tintColor = [UIColor colorWithWhite:0.85f alpha:1.0f];
        [self setWidth:30.f forSegmentAtIndex:0];
        [self setWidth:30.f forSegmentAtIndex:2];
    }
    return self;
}


//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)selectedItem {
    return (NSString*)[self.items objectAtIndex:self.selectedItemIndex];
}

//===================================================================================================================================
#pragma mark SegmentedListPicker PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)segmentControlSelectionChanged:(id)sender {
    NSInteger selectedSegment = [(UISegmentedControl*)sender selectedSegmentIndex];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (UIImage*)renderTextAsImage:(CGRect)rect {
    CGFloat width = rect.size.width-60.0f-4.0f;
    CGFloat height = rect.size.height;
    CGSize textSize = [[self selectedItem] sizeWithFont:self.font constrainedToSize:CGSizeMake(width, height) lineBreakMode:UILineBreakModeTailTruncation];
    CGFloat yoffset = (height-textSize.height)/2.0f;
	UIGraphicsBeginImageContext(CGSizeMake(width, height));
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
	CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
	[[self selectedItem]  drawInRect:CGRectMake(2.0f, yoffset, width, height) withFont:self.font lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];
	UIImage* textImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    return textImage;
}
    
//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [super dealloc];
}

@end
