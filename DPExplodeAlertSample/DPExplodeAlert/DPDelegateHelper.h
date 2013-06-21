//
//  DPDelegateHelper.h
//
//  Created by ILYA2606 on 20.06.13.
//  Copyright (c) 2013 Darkness Production. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPDelegateHelper : NSObject

+(BOOL)safeCallMethod:(NSString*)methodString withTarget:(id)target;
+(BOOL)safeCallMethod:(NSString*)methodString withTarget:(id)target andObject:(id)object;
+(BOOL)safeCallMethod:(NSString*)methodString withTarget:(id)target andObject:(id)object1 andObject:(id)object2;

@end
