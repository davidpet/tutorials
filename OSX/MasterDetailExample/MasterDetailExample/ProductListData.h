//
//  ProductListData.h
//  MasterDetailExample
//
//  Created by David Petrofsky on 12/20/15.
//  Copyright © 2015 David Petrofsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductData.h"

@interface ProductListData : NSObject

// KVO-enabling methods
- (NSUInteger)countOfProducts;
- (id)objectInProductsAtIndex:(NSUInteger)index;
- (void)insertObject:(id)object inProductsAtIndex:(NSUInteger)index;
- (void)removeObjectFromProductsAtIndex:(NSUInteger)index;

// Other useful methods
- (NSInteger)indexOfObjectInProducts:(id)product;

@end