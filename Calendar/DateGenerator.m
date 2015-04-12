//
//  DateGenerator.m
//  Calendar
//
//  Created by lazy on 15-4-10.
//  Copyright (c) 2015年 lazy. All rights reserved.
//

#import "DateGenerator.h"

@interface DateGenerator (){
    NSInteger _year;
    NSInteger _month;
    NSInteger _day;
}

@property (nonatomic, assign) BOOL isDateLegal;

@end

@implementation DateGenerator

-(NSArray *)generateNextDayWithYear:(NSInteger)year month:(NSInteger)month andDay:(NSInteger)day{
    _isDateLegal = YES;
    _year = year;
    _month = month;
    _day = day;
    
    if ([self isDateLegalWithYear:year Month:month andDay:day]) {
        return nil;
    }
    
    if ([self isLastDayOfTheMonthWithMonth:month andDay:day]){
        if ([self isLastDayOfTheYearWithMonth:month andDay:day]) {
            NSInteger newYear = year + 1;
            if (newYear > 2100) {
                return nil;
            } else {
                return @[@(newYear),@(1),@(1)];
            }
        } else {
            return @[@(year),@(month + 1),@(1)];
        }
    } else {
        return _isDateLegal ? @[@(year),@(month),@(day + 1)] : nil;
    }
}

#pragma mark - Logic Method
- (BOOL)isDateLegalWithYear:(NSInteger)year Month:(NSInteger)month andDay:(NSInteger)day{
    return (year < 1800 || year > 2100 || month <= 0 || month > 12 || day <= 0 || day > 31);
}

- (BOOL)isLeapYear:(NSInteger)year{
    return ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0);
}

- (BOOL)isLastDayOfTheYearWithMonth:(NSInteger)month andDay:(NSInteger)day{
    return (month == 12 && day == 31);
}

- (BOOL)isLastDayOfTheMonthWithMonth:(NSInteger)month andDay:(NSInteger)day{
    NSArray *large = @[@(1),@(3),@(5),@(7),@(8),@(10),@(12)];
    NSArray *small = @[@(4),@(6),@(9),@(11)];
    NSArray *special = @[@(2)];
    if ([large containsObject:@(month)]) {
        if (day == 31) {
            return YES;
        } else if (day > 31){
            _isDateLegal = NO;
        }
    } else if ([small containsObject:@(month)]){
        if (day == 30) {
            return YES;
        } else if (day > 30){
            _isDateLegal = NO;
        }
    } else if ([special containsObject:@(month)]){
        BOOL isLeapYear = [self isLeapYear:_year];
        if (isLeapYear) {
            if (day == 29) {
                return YES;
            } else if (day > 29){
                _isDateLegal = NO;
            }
        } else {
            if (day == 28) {
                return YES;
            } else if (day > 28){
                _isDateLegal = NO;
            }
        }
    }
    return NO;
}

@end
