//
//  SizeHelper.m
//
//  Created by ILYA2606 on 14.03.13.
//  Copyright (c) 2013 Darkness Production. All rights reserved.
//

#import "DPSizeHelper.h"

@implementation DPSizeHelper

+(CGSize)sizeFromString:(NSString*)string andFont:(UIFont*)font andSizeLimit:(CGSize)limitSize{
    return [DPSizeHelper sizeFromString:string
                                andFont:font
                          andLimitWidth:limitSize.width
                         andLimitHeight:limitSize.height];
}

+(CGSize)sizeFromString:(NSString*)string andFont:(UIFont*)font andLimitWidth:(float)limitWidth andLimitHeight:(float)limitHeight{
    return [string sizeWithFont: font
              constrainedToSize: CGSizeMake((limitWidth > 0) ? limitWidth : MAXFLOAT, (limitHeight > 0) ? limitHeight : MAXFLOAT)
                  lineBreakMode: LINE_BREAK_WORD_WRAP];
}

@end
