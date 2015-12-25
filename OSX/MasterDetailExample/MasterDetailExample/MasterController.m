//
//  MasterController.m
//  MasterDetailExample
//
//  Created by David Petrofsky on 12/20/15.
//  Copyright © 2015 David Petrofsky. All rights reserved.
//

#import "MasterController.h"
#import "ProductData.h"

@implementation MasterController

- (id)init {
    self = [super init];
    if (self) {
        // Create a new product list
        _productList = [[ProductListData alloc] init];
        
        // Add some dummy data
        [_productList insertObject:[[ProductData alloc] initWithName:@"Coffee"
                                                               price:[NSDecimalNumber decimalNumberWithString:@"1.99"]] inProductsAtIndex:0];
        [_productList insertObject:[[ProductData alloc] initWithName:@"Latte"
                                                               price:[NSDecimalNumber decimalNumberWithString:@"3.49"]] inProductsAtIndex:1];
        [_productList insertObject:[[ProductData alloc] initWithName:@"Flat White"
                                                               price:[NSDecimalNumber decimalNumberWithString:@"3.99"]] inProductsAtIndex:2];
    }
    return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.productList countOfProducts];
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    // Request a view for the cell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"ProductNameCell"
                                                            owner:nil];
    // Configure the view for the specified row
    ProductData *product = [self.productList objectInProductsAtIndex:row];
    cellView.textField.stringValue = product.name;
    
    // Return the cell
    return cellView;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSInteger selectedRow = [self.tableView selectedRow];
    if (selectedRow > -1) {
        ProductData *product = [self.productList objectInProductsAtIndex:selectedRow];
        NSLog(@"Selected product: %@", product.name);
    } else {
        NSLog(@"No selection");
    }
}

- (void)awakeFromNib {
    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
}

- (IBAction) insertNewProduct:(id)sender {
    // Create the new product data
    ProductData *product = [[ProductData alloc] initWithName:@"New Product"
                                                       price:[NSDecimalNumber decimalNumberWithString:@"1.99"]];
    
    // Figure out the index to insert into (TODO)
    NSInteger index = self.tableView.selectedRow;
    if (index == -1) {
        // No selection, so insert at top of list
        index = 0;
    }
    
    // Insert it into the model layer
    [self.productList insertObject:product inProductsAtIndex:index];
    
    // Tell the table view it needs updating
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:index]
                          withAnimation:NSTableViewAnimationSlideDown];
    [self.tableView scrollRowToVisible:index];
    [self.tableView endUpdates];
    
    // Select the new row
    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:index]
                byExtendingSelection:NO];
}

- (IBAction) removeSelectedProduct:(id)sender {
    NSInteger index = self.tableView.selectedRow;
    if (index == -1) {
        // No selection, so don't do anything
        return;
    }
    [self.productList removeObjectFromProductsAtIndex:index];
    
    // Update the table view to match
    [self.tableView beginUpdates];
    [self.tableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:index]
                          withAnimation:NSTableViewAnimationEffectFade];
    [self.tableView scrollRowToVisible:index];
    [self.tableView endUpdates];
    
    // Select a new row, if there are any left
    if ([self.productList countOfProducts] > 0) {
        NSInteger newIndex = index-1;
        if (newIndex < 0) {
            newIndex = 0;
        }
        [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:newIndex] byExtendingSelection:NO];
    }
}

@end
