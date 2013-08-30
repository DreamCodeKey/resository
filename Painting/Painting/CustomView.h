//
//  CustomView.h
//  Painting
//
//  Created by apple on 13-8-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ViewController.h"
@protocol  ColorDelegete<NSObject>
@optional
- (void)sendTheButton:(UIView *)sender;

@end


@interface CustomView : UIViewController

@property(nonatomic,assign)id <ColorDelegete> delegete;
@property (retain, nonatomic) IBOutlet UIToolbar *customToolBar;

- (IBAction)oranege:(id)sender;
- (IBAction)purple:(id)sender;

@end
