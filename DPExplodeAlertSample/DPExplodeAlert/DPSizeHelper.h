//
//  SizeHelper.h
//
//  Created by ILYA2606 on 14.03.13.
//  Copyright (c) 2013 Darkness Production. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __IPHONE_6_0
    # define LINE_BREAK_WORD_WRAP NSLineBreakByWordWrapping
#else
    # define LINE_BREAK_WORD_WRAP UILineBreakModeWordWrap
#endif

@interface DPSizeHelper : NSObject

+(CGSize)sizeFromString:(NSString*)string andFont:(UIFont*)font andSizeLimit:(CGSize)limitSize;
+(CGSize)sizeFromString:(NSString*)string andFont:(UIFont*)font andLimitWidth:(float)limitWidth andLimitHeight:(float)limitHeight;

@end
