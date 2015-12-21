//
//  ProductData.h
//  MasterDetailExample
//
//  Created by David Petrofsky on 12/20/15.
//  Copyright © 2015 David Petrofsky. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface ProductData : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSDecimalNumber *price;
@property (nonatomic) NSImage *image;
@property (nonatomic) NSInteger numberOfSales;

- (id)initWithName:(NSString *)name price:(NSDecimalNumber *)price;

@end