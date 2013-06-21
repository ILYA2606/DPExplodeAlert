//
//  DPExplodeHelper.h
//
//  Created by ILYA2606 on 20.06.13.
//  Copyright (c) 2013 Darkness Production. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "DPParticleLayer.h"
#import "DPDelegateHelper.h"
#import "DPRandomHelper.h"
#import "DPLayerHelper.h"

@protocol DPExplodeDelegate <NSObject>

-(void)explode:(id)explodeHelper didFinish:(BOOL)success;

@end

@interface DPExplodeHelper : NSObject

+ (void)explodeView:(UIView*)view withDelegate:(id <DPExplodeDelegate>)delegate andCenterX:(float)centerX;
+ (void)explodeView:(UIView*)view withDelegate:(id <DPExplodeDelegate>)delegate andDuration:(NSTimeInterval)duration andExplodeCounter:(int)explodeCounter andCenterX:(float)centerX;

@property (nonatomic, assign) id <DPExplodeDelegate> __unsafe_unretained delegate;
@property (nonatomic, strong) UIView *viewForExplode;
@property (nonatomic) float centerX;

@end
