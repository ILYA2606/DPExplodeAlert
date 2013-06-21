//
//  DPDelegateHelper.m
//
//  Created by ILYA2606 on 20.06.13.
//  Copyright (c) 2013 Darkness Production. All rights reserved.
//

#import "DPDelegateHelper.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation DPDelegateHelper

+(BOOL)safeCallMethod:(NSString*)methodString withTarget:(id)target{
    return [DPDelegateHelper safeCallMethod:methodString withTarget:target andObject:nil andObject:nil];
}

+(BOOL)safeCallMethod:(NSString*)methodString withTarget:(id)target andObject:(id)object{
    return [DPDelegateHelper safeCallMethod:methodString withTarget:target andObject:object andObject:nil];
}

+(BOOL)safeCallMethod:(NSString*)methodString withTarget:(id)target andObject:(id)object1 andObject:(id)object2{
    SEL selector = NSSelectorFromString(methodString);
    if([target respondsToSelector:selector]){
        [target performSelector:selector withObject:object1 withObject:object2];
        return YES;
    }
    else{
        NSLog(@"%@ not responded Delegate method '%@'",[target class], NSStringFromSelector(selector));
        return NO;
    }
}

@end
