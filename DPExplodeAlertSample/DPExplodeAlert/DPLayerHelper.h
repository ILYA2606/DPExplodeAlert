//
//  DPLayerHelper.h
//
//  Created by ILYA2606 on 21.06.13.
//  Copyright (c) 2013 Darkness Production. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPRandomHelper.h"

@interface DPLayerHelper : NSObject

+(UIImage *)imageFromLayer:(CALayer *)layer;
+(UIBezierPath *)pathForLayer:(CALayer *)layer parentRect:(CGRect)rect andView:(UIView*)view;

@end
