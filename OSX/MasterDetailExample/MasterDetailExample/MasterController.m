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

@end
