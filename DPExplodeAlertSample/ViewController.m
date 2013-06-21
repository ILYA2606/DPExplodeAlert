//
//  ViewController.m
//
//  Created by ILYA2606 on 17.06.13.
//  Copyright (c) 2013 Darkness Production. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)click:(id)sender {
    UILabel *l_duration = (UILabel*)[self.view viewWithTag:6];
    UILabel *l_explodeCounter = (UILabel*)[self.view viewWithTag:7];
    DPExplodeAlert *al = [[DPExplodeAlert alloc] initWithWindowAndTitle:@"DPExplodeAlert"
                                                             andMessage:@"Welcome to DPExplodeAlert!\n\nDo you want explode? \n\nTap to here for explode this Alert!\n"
                                                            andDelegate:(id<DPExplodeAlertDelegate>)self
                                                            andDuration:[l_duration.text floatValue]
                                                      andExplodeCounter:[l_explodeCounter.text intValue]];
    [al show];
}

- (IBAction)durationChanged:(id)sender {
    UILabel *l_duration = (UILabel*)[self.view viewWithTag:6];
    l_duration.text = [NSString stringWithFormat:@"%.1f", [(UISlider*)sender value]];
}

- (IBAction)explodeCounterChanged:(id)sender {
    UILabel *l_explodeCounter = (UILabel*)[self.view viewWithTag:7];
    l_explodeCounter.text = [NSString stringWithFormat:@"%.0f", [(UISlider*)sender value]];
}

#pragma mark - DPExplodeAlert Delegate

-(void)alertDidShow{
    NSLog(@"Alert Did Show");
}

-(void)alertWillExplode{
    NSLog(@"Alert Will Explode");
}

-(void)alertDidExplode{
    NSLog(@"Alert Did Explode");
}

@end
