//
//  DateGenerator.h
//  Calendar
//
//  Created by lazy on 15-4-10.
//  Copyright (c) 2015年 lazy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateGenerator : NSObject

- (NSArray *)generateNextDayWithYear:(NSInteger)year month:(NSInteger)month andDay:(NSInteger)day;

@end
