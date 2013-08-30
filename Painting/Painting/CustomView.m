//
//  CustomView.m
//  Painting
//
//  Created by apple on 13-8-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "CustomView.h"
#import "ViewController.h"

@interface CustomView ()

@end

@implementation CustomView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
  //  
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(200,0, 100, 100)];
    button.backgroundColor = [UIColor orangeColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
  
    
    self.navigationItem.rightBarButtonItem = item;
    
    self.navigationController.view.backgroundColor = [UIColor orangeColor];
    
    [item release];
    //简单的仿射变换
    UIButton *buttonTest = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonTest.frame = CGRectMake(100, 0, 120, 50);
    
    [buttonTest addTarget:self action:@selector(transform) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonTest];
    
    UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(100, 150, 200, 220)];
   
    myview.backgroundColor = [UIColor orangeColor];
    myview.tag = 1001;
    [self.view addSubview:myview];
    
   

}

//简单的仿射变化

- (void)transform
{
    //通过tag值取到子视图
     UIView *myview = [self.view viewWithTag:1001];
    UIImageView *image = [[UIImageView alloc]init];
 //   image.contentMode

    CGAffineTransform transform = myview.transform;
    //放大的仿射变化
 //   myview.transform = CGAffineTransformScale(transform, 1, 2);
  
    //旋转的仿射变化
    myview.transform = CGAffineTransformRotate(transform, M_PI_4);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)oranege:(id)sender {
    
    if (_delegete && [_delegete respondsToSelector:@selector(sendTheButton:)])
        [_delegete sendTheButton:(UIButton *)sender];
   // UIResponder
}
    


- (IBAction)purple:(id)sender {
   
    if (_delegete && [_delegete respondsToSelector:@selector(sendTheButton:)])
        [_delegete sendTheButton:(UIButton *)sender];
}
- (void)dealloc {
    [_customToolBar release];
    [super dealloc];
}
@end
