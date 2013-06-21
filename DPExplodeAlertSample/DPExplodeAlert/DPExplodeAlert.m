//
//  DPExplodeAlert.m
//
//  Created by ILYA2606 on 17.06.13.
//  Copyright (c) 2013 Darkness Production. All rights reserved.
//

#import "DPExplodeAlert.h"


@implementation DPExplodeAlert

-(id)initWithWindowAndTitle:(NSString*)title andMessage:(NSString*)message andDelegate:(id<DPExplodeAlertDelegate>)delegate{
    return [self initWithWindowAndTitle:title andMessage:message andDelegate:delegate andDuration:2.0 andExplodeCounter:15];
}

-(id)initWithWindowAndTitle:(NSString*)title andMessage:(NSString*)message andDelegate:(id<DPExplodeAlertDelegate>)delegate andDuration:(NSTimeInterval)duration andExplodeCounter:(int)explodeCounter{
    _delegate = delegate;
    _duration = duration;
    _explodeCounter = explodeCounter;
    UIView *view = [[UIApplication sharedApplication] keyWindow];
    self = [super initWithFrame:view.bounds];
    if (self) {
        [self setupInterfaceWithTitle:title andMessage:message andView:view];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

#pragma mark - Interface

-(void)setupInterfaceWithTitle:(NSString*)title andMessage:(NSString*)message andView:(UIView*)view{
    self.alpha = 0.0;
    
    CGSize sizeTitle = [DPSizeHelper sizeFromString:title andFont:TITLE_FONT andLimitWidth:280 andLimitHeight:0];
    CGSize sizeMessage = [DPSizeHelper sizeFromString:message andFont:MESSAGE_FONT andLimitWidth:280 andLimitHeight:0];
    
    if(sizeTitle.width == 0) sizeTitle.height = 0;
    if(sizeMessage.width == 0) sizeMessage.height = 0;
    
    float maxWidth = (sizeTitle.width > sizeMessage.width) ? sizeTitle.width : sizeMessage.width;
    float maxHeight = sizeTitle.height + sizeMessage.height;
    CGSize sizeBackground = CGSizeMake(maxWidth + 20, maxHeight+20);
    
    v_explode = [[UIView alloc] initWithFrame:self.frame];
    v_explode.backgroundColor = [UIColor clearColor];
    
    v_background = [[UIView alloc] initWithFrame:CGRectMake(view.bounds.size.width/2-sizeBackground.width/2, view.bounds.size.height/2-sizeBackground.height/2, sizeBackground.width, sizeBackground.height)];
    v_background.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    [self roundCornersForView:v_background];
    
    l_title = [[UILabel alloc] initWithFrame:CGRectMake(v_background.bounds.size.width/2-sizeTitle.width/2, 10, sizeTitle.width, sizeTitle.height)];
    l_title.text = title;
    l_title.textColor = [UIColor whiteColor];
    l_title.backgroundColor = [UIColor clearColor];
    l_title.textAlignment = NSTextAlignmentCenter;
    l_title.numberOfLines = 0;
    l_title.font = TITLE_FONT;
    
    l_message = [[UILabel alloc] initWithFrame:CGRectMake(v_background.bounds.size.width/2-sizeMessage.width/2, l_title.frame.origin.y + sizeTitle.height, sizeMessage.width, sizeMessage.height)];
    l_message.text = message;
    l_message.textColor = [UIColor whiteColor];
    l_message.backgroundColor = [UIColor clearColor];
    l_message.textAlignment = NSTextAlignmentCenter;
    l_message.numberOfLines = 0;
    l_message.font = MESSAGE_FONT;
    
    
    v_background.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin&UIViewAutoresizingFlexibleRightMargin&UIViewAutoresizingFlexibleWidth&UIViewAutoresizingFlexibleHeight;
    
    self.backgroundColor = [UIColor clearColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin&UIViewAutoresizingFlexibleRightMargin&UIViewAutoresizingFlexibleWidth&UIViewAutoresizingFlexibleHeight;
    
    UITapGestureRecognizer *tapToBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide:)];
    [v_background addGestureRecognizer:tapToBackground];
    
    [v_background addSubview:l_title];
    [v_background addSubview:l_message];
    [v_explode addSubview:v_background];
    [self addSubview:v_explode];
}

-(void)show{
    UIView *view = [[UIApplication sharedApplication] keyWindow];
    self.alpha = 0.0;
    [view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [DPDelegateHelper safeCallMethod:@"alertDidShow" withTarget:_delegate];
    }];
}

-(void)hide:(UITapGestureRecognizer*)sender{
    CGPoint pointTap = [sender locationInView:v_explode];
    v_explode.userInteractionEnabled = NO;
    [DPDelegateHelper safeCallMethod:@"alertWillExplode" withTarget:_delegate];
    [DPExplodeHelper explodeView:v_explode withDelegate:(id<DPExplodeDelegate>)self andDuration:_duration andExplodeCounter:_explodeCounter andCenterX:pointTap.x];
}

-(void)roundCornersForView:(UIView*)view{
    CALayer * ourLayer = [view layer];
    ourLayer.cornerRadius = 8.0f;
    ourLayer.masksToBounds = YES;
    ourLayer.borderWidth = 0.0f;
}


#pragma mark - DPExplodeHelper Delegate

-(void)explode:(DPExplodeHelper*)explodeHelper didFinish:(BOOL)success{
    [self removeFromSuperview];
    [DPDelegateHelper safeCallMethod:@"alertDidExplode" withTarget:_delegate];
}

-(void)dealloc{
    
}


@end
