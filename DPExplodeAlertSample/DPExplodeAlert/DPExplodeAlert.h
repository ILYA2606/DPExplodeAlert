//
//  DPExplodeAlert.h
//
//  Created by ILYA2606 on 17.06.13.
//  Copyright (c) 2013 Darkness Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPSizeHelper.h"
#import "DPDelegateHelper.h"
#import "DPExplodeHelper.h"

#define TITLE_FONT [UIFont boldSystemFontOfSize:17]
#define MESSAGE_FONT [UIFont systemFontOfSize:13]

@protocol DPExplodeAlertDelegate <NSObject>

-(void)alertDidShow;
-(void)alertWillExplode;
-(void)alertDidExplode;

@end

@interface DPExplodeAlert : UIView{
    UILabel *l_title;
    UILabel *l_message;
    UIView *v_background;
    UIView *v_explode;
}

-(id)initWithWindowAndTitle:(NSString*)title andMessage:(NSString*)message andDelegate:(id<DPExplodeAlertDelegate>)delegate;
-(id)initWithWindowAndTitle:(NSString*)title andMessage:(NSString*)message andDelegate:(id<DPExplodeAlertDelegate>)delegate andDuration:(NSTimeInterval)duration andExplodeCounter:(int)explodeCounter;
-(void)show;

@property (nonatomic, assign) id<DPExplodeAlertDelegate> __unsafe_unretained delegate;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) int explodeCounter;

@end
