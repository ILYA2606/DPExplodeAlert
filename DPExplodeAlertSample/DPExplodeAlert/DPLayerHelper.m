//
//  DPLayerHelper.m
//
//  Created by ILYA2606 on 21.06.13.
//  Copyright (c) 2013 Darkness Production. All rights reserved.
//

#import "DPLayerHelper.h"
#import <QuartzCore/QuartzCore.h>

@implementation DPLayerHelper

+(UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

+(UIBezierPath *)pathForLayer:(CALayer *)layer parentRect:(CGRect)rect andView:(UIView*)view andCenterX:(float)centerX
{
    UIBezierPath *particlePath = [UIBezierPath bezierPath];
    [particlePath moveToPoint:layer.position];
    
    float r = ((float)rand()/(float)RAND_MAX) + 0.3f;
    float r2 = ((float)rand()/(float)RAND_MAX)+ 0.4f;
    float r3 = r*r2;
    
    int upOrDown = (r <= 0.5) ? 1 : -1;
    
    CGPoint curvePoint = CGPointZero;
    CGPoint endPoint = CGPointZero;
    
    CGFloat layerYPosAndHeight = (view.superview.frame.size.height-(layer.position.y+layer.frame.size.height))*[DPRandomHelper randomFloat];
    CGFloat layerXPosAndHeight = view.superview.frame.size.width * [DPRandomHelper randomFloat];
    
    float endY = view.superview.frame.size.height-view.frame.origin.y+50;
    
    //float centerX = rect.size.width*0.5;
    float maxLeftRightShift = fabsf(layer.position.x-centerX)/30 * [DPRandomHelper randomFloat];
    
    if (layer.position.x < centerX)//go to left
    {
        endPoint = CGPointMake(view.superview.frame.size.width / 2 - layerXPosAndHeight, endY);
        curvePoint= CGPointMake((((layer.position.x*0.5)*r3)*upOrDown)*maxLeftRightShift,-layerYPosAndHeight);
    }
    else if(layer.position.x > centerX)//go to right
    {
        endPoint = CGPointMake(view.superview.frame.size.width / 2 + layerXPosAndHeight, endY);
        curvePoint= CGPointMake((((layer.position.x*0.5)*r3)*upOrDown+rect.size.width)*maxLeftRightShift, -layerYPosAndHeight);
    }
    else//go to center
    {
        endPoint = CGPointMake(view.superview.frame.size.width / 4 + layerXPosAndHeight, endY);
        curvePoint= CGPointMake((((layer.position.x*0.5)*r3)*upOrDown+rect.size.width)*maxLeftRightShift, -layerYPosAndHeight);
    }
    
    [particlePath addQuadCurveToPoint:endPoint
                         controlPoint:curvePoint];
    
    return particlePath;
}

@end
