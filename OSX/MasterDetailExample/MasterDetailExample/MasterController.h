//
//  MasterController.h
//  MasterDetailExample
//
//  Created by David Petrofsky on 12/20/15.
//  Copyright © 2015 David Petrofsky. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ProductListData.h"

@interface MasterController : NSObject <NSTableViewDataSource, NSTableViewDelegate>

- (IBAction) insertNewProduct:(id)sender;
- (IBAction) removeSelectedProduct:(id)sender;

@property (nonatomic) ProductListData *productList;

@property (weak) IBOutlet NSTableView *tableView;

@end
