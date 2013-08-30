//
//  DarwClass.h
//  Painting
//
//  Created by apple on 13-8-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ViewController.h"
#import "CustomView.h"
@class ViewController;
@interface DarwClass : UIView


@property(nonatomic,retain)ViewController *obj;
@property(nonatomic,retain)CustomView *pushView;

@property (nonatomic,retain)NSMutableArray *array;


- (void)getLocation;
- (void)addLocation:(CGPoint) point isBegin:(BOOL) flag;
- (void)getColor:(UIButton *)button;
- (void)getSize:(float)sliderValue;

@end
