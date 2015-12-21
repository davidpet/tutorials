//
//  ProductListData.m
//  MasterDetailExample
//
//  Created by David Petrofsky on 12/20/15.
//  Copyright © 2015 David Petrofsky. All rights reserved.
//

#import "ProductListData.h"

@implementation ProductListData {
    NSMutableArray *_products;
}

- (id)init {
    self = [super init];
    if (self) {
        _products = [NSMutableArray array];
    }
    return self;
}

- (NSUInteger)countOfProducts {
    return [_products count];
}

- (id)objectInProductsAtIndex:(NSUInteger)index {
    return _products[index];
}

- (void)insertObject:(id)object inProductsAtIndex:(NSUInteger)index {
    [_products insertObject:object atIndex:index];
}

- (void)removeObjectFromProductsAtIndex:(NSUInteger)index {
    [_products removeObjectAtIndex:index];
}

- (NSInteger)indexOfObjectInProducts:(id)product {
    return [_products indexOfObject:product];
}

@end
