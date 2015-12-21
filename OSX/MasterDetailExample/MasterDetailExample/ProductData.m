//
//  ProductData.m
//  MasterDetailExample
//
//  Created by David Petrofsky on 12/20/15.
//  Copyright © 2015 David Petrofsky. All rights reserved.
//

#import "ProductData.h"

@implementation ProductData
- (id)initWithName:(NSString *)name price:(NSDecimalNumber *)price {
    self = [super init];
    if (self) {
        _name = name;
        _price = price;
    }
    return self;
}
@end
