//
//  DPRandomHelper.m
//
//  Created by ILYA2606 on 21.06.13.
//  Copyright (c) 2013 Darkness Production. All rights reserved.
//

#import "DPRandomHelper.h"

@implementation DPRandomHelper

+(float)randomFloat
{
    float random = (float)rand()/(float)RAND_MAX;
    return random;
}

@end
