//
//  DPExplodeHelper.m
//
//  Created by ILYA2606 on 20.06.13.
//  Copyright (c) 2013 Darkness Production. All rights reserved.
//

#import "DPExplodeHelper.h"


@implementation DPExplodeHelper

- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

+ (void)explodeView:(UIView*)view withDelegate:(id <DPExplodeDelegate>)delegate{
    [DPExplodeHelper explodeView:view withDelegate:delegate andDuration:2.0 andExplodeCounter:20];
}

+ (void)explodeView:(UIView*)view withDelegate:(id <DPExplodeDelegate>)delegate andDuration:(NSTimeInterval)duration andExplodeCounter:(int)explodeCounter{
    DPExplodeHelper *explodeHelper = [[DPExplodeHelper alloc] init];
    explodeHelper.delegate = delegate;
    explodeHelper.viewForExplode = view;
    [explodeHelper explodeWithDuration:duration andExplodeCounter:explodeCounter];
}

- (void)explodeWithDuration:(NSTimeInterval)duration andExplodeCounter:(int)explodeCounter
{
    float size = _viewForExplode.frame.size.width/explodeCounter;
    CGSize imageSize = CGSizeMake(size, size);
    
    CGFloat cols = _viewForExplode.frame.size.width / imageSize.width;
    CGFloat rows = _viewForExplode.frame.size.height /imageSize.height;
    
    //count full columns & rows
    int fullColumns = floorf(cols);
    int fullRows = floorf(rows);
    
    //remainders
    CGFloat remainderWidth = _viewForExplode.frame.size.width  - (fullColumns * imageSize.width);
    CGFloat remainderHeight = _viewForExplode.frame.size.height - (fullRows * imageSize.height );
    
    //true count columns & rows
    if (cols > fullColumns) fullColumns++;
    if (rows > fullRows) fullRows++;
    
    CGRect originalFrame = _viewForExplode.layer.frame;
    CGRect originalBounds = _viewForExplode.layer.bounds;
    
    
    CGImageRef fullImage = [DPLayerHelper imageFromLayer:_viewForExplode.layer].CGImage;
    
    //if its an image, set it to nil
    if ([_viewForExplode isKindOfClass:[UIImageView class]])
    {
        [(UIImageView*)_viewForExplode setImage:nil];
    }
    
    //remove all sublayers
    [[_viewForExplode.layer sublayers] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    //add new tiled sublayers
    for (int y = 0; y < fullRows; ++y)
    {
        for (int x = 0; x < fullColumns; ++x)
        {
            CGSize tileSize = imageSize;
            
            if (x + 1 == fullColumns && remainderWidth > 0)
            {
                //last column
                tileSize.width = remainderWidth;
            }
            if (y + 1 == fullRows && remainderHeight > 0)
            {
                //last row
                tileSize.height = remainderHeight;
            }
            
            CGRect layerRect = (CGRect){{x*imageSize.width, y*imageSize.height}, tileSize};
            
            CGImageRef tileImage = CGImageCreateWithImageInRect(fullImage,layerRect);
            
            DPParticleLayer *layer = [DPParticleLayer layer];
            layer.frame = layerRect;
            layer.contents = (__bridge id)(tileImage);
            layer.borderWidth = 0.0f;
            layer.borderColor = [UIColor blackColor].CGColor;
            layer.particlePath = [DPLayerHelper pathForLayer:layer parentRect:originalFrame andView:_viewForExplode];
            [_viewForExplode.layer addSublayer:layer];
            
            CGImageRelease(tileImage);
        }
    }
    
    [_viewForExplode.layer setFrame:originalFrame];
    [_viewForExplode.layer setBounds:originalBounds];
    
    
    _viewForExplode.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    //animate every layer
    [[_viewForExplode.layer sublayers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        DPParticleLayer *layer = (DPParticleLayer *)obj;
        
        //path
        CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        moveAnim.path = layer.particlePath.CGPath;
        moveAnim.removedOnCompletion = YES;
        moveAnim.fillMode=kCAFillModeForwards;
        NSArray *timingFunctions = [NSArray arrayWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],nil];
        [moveAnim setTimingFunctions:timingFunctions];
        
        NSTimeInterval speed = duration;
        
        //transform
        CAKeyframeAnimation *transformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        
        CATransform3D startingScale = layer.transform;
        CATransform3D rotation3D = CATransform3DMakeRotation(M_PI*2*[DPRandomHelper randomFloat], [DPRandomHelper randomFloat], [DPRandomHelper randomFloat], [DPRandomHelper randomFloat]);//0-360 degrees
        CATransform3D scale3D = CATransform3DMakeScale([DPRandomHelper randomFloat]/3, [DPRandomHelper randomFloat]/3, 1.0);//0-0.33 scale
        CATransform3D endingScale = CATransform3DConcat(scale3D, rotation3D);
        
        NSArray *boundsValues = [NSArray arrayWithObjects:[NSValue valueWithCATransform3D:startingScale],
                                 
                                 [NSValue valueWithCATransform3D:endingScale], nil];
        [transformAnim setValues:boundsValues];
        
        NSArray *times = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
                          [NSNumber numberWithFloat:speed*.75], nil];//75% time
        [transformAnim setKeyTimes:times];
        
        
        timingFunctions = [NSArray arrayWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                           [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                           [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                           nil];
        [transformAnim setTimingFunctions:timingFunctions];
        transformAnim.fillMode = kCAFillModeForwards;
        transformAnim.removedOnCompletion = NO;
        
        //alpha. 1.0 -> 0.0
        CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnim.fromValue = [NSNumber numberWithFloat:1.0f];
        opacityAnim.toValue = [NSNumber numberWithFloat:0.0f];
        opacityAnim.removedOnCompletion = NO;
        opacityAnim.fillMode =kCAFillModeForwards;
        
        //group animations
        CAAnimationGroup *animGroup = [CAAnimationGroup animation];
        animGroup.animations = [NSArray arrayWithObjects:moveAnim,transformAnim,opacityAnim, nil];
        animGroup.duration = speed;
        animGroup.fillMode =kCAFillModeForwards;
        animGroup.delegate = self;
        [animGroup setValue:layer forKey:@"animationLayer"];
        [layer addAnimation:animGroup forKey:nil];
        
        //take it off screen
        [layer setPosition:CGPointMake(0, -600)];
        
    }];
}

#pragma mark - CAAnimation Delegate

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    DPParticleLayer *layer = [theAnimation valueForKey:@"animationLayer"];
    if (layer)
    {
        //make sure we dont have any more
        if ([[_viewForExplode.layer sublayers] count]==1)
        {
            [_viewForExplode removeFromSuperview];
            [DPDelegateHelper safeCallMethod:@"explode:didFinish:" withTarget:_delegate andObject:self andObject:[NSNumber numberWithBool:flag]];
            
        }
        else
        {
            [layer removeFromSuperlayer];
        }
    }
}



@end
