//
//  ViewController.h
//  Painting
//
//  Created by apple on 13-8-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"



@interface ViewController : UIViewController<ColorDelegete>


@property(nonatomic,assign)CGPoint location;
@property(nonatomic,retain) NSMutableArray *mainArray;

@property (retain, nonatomic) IBOutlet UIImageView *toolImage;
@property (retain, nonatomic) IBOutlet UIView *toolView;
@property(nonatomic,retain)CustomView * point;

- (IBAction)orangePaint:(id)sender;
- (IBAction)clearScreen:(id)sender;

- (IBAction)purplePaint:(id)sender;
- (IBAction)clearColor:(id)sender;

- (IBAction)sizePaint:(id)sender;
- (IBAction)sizeChange:(id)sender;

- (IBAction)resave:(id)sender;
- (IBAction)rotate:(id)sender;
- (IBAction)hiddenButton:(id)sender;



@end
