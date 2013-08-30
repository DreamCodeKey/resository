//
//  ViewController.m
//  Painting
//
//  Created by apple on 13-8-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ViewController.h"

//#import "CustomView.h"
#import <QuartzCore/QuartzCore.h>
#import "DarwClass.h"


static ViewController *instance = nil;

@interface ViewController ()
{
    DarwClass *_darw;
    NSMutableArray *_mainArray;
    
}

@end

@implementation ViewController
@synthesize mainArray = _mainArray;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    _darw = [[DarwClass alloc]initWithFrame:[[UIScreen mainScreen]applicationFrame]];
//    [self.view addSubview:_darw];
    _mainArray = [[NSMutableArray alloc]init];
    
    //属性传参  设置参数对象
    DarwClass *darw = (DarwClass *)self.view;
    darw.obj = self;
  
    //初始化尽量放到值初始化一次的里面
    self.point = [[CustomView alloc]init];
    //设置代理
    self.point.delegete = self;
 
    
    self.view.backgroundColor = [UIColor grayColor];
    self.toolView.hidden = YES;

    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(jump:)];
    //[_darw addGestureRecognizer:panGesture];
    [self.view addGestureRecognizer:panGesture];
   
   
    
    self.navigationController.navigationBar.hidden = NO;
  
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_bg_normal.png"] forBarMetrics:UIBarMetricsDefault];
    //设置画板的名字
    self.navigationItem.title =  @"君君的画板";
    //设置右键的功能
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(Push)];
    self.navigationItem.rightBarButtonItem = item;

    [panGesture release];
    
    
}

//协议的实现
- (void)sendTheButton:(UIView *)sender
{
    if (sender.tag < 100) {
        [self orangePaint:sender];
    }
    if (sender.tag == 100) {
        [self sizeChange:sender];
    }
}

- (void)didReceiveMemoryWarnings
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

- (void)dealloc {
    
    [self.point release];
    [_toolImage release];
    [_toolView release];
    [super dealloc];
}

- (void)jump:(UIGestureRecognizer *)pan
{
    DarwClass *darw = (DarwClass *)self.view;
    //定义如果是开始的状态就改变flag值
    self.location = [pan locationInView:self.view];
    BOOL flag = NO;
    if (pan.state == UIGestureRecognizerStateBegan) {
        flag = YES;
    }
    //然后进行传参
    [darw addLocation:self.location isBegin:flag];
    
    //每次都需要调用setNeedDisplay;
    [self.view setNeedsDisplay];
   
    
}


//push 视图
- (void)Push
{
  
    //将视图push进取
    //pushView.delegete = self;
    [self.navigationController pushViewController:self.point animated:YES];
}

//保存图片

- (UIImage *)createImageFromView
{
    CGSize  point =CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - 60);
    UIGraphicsBeginImageContextWithOptions(point, YES, 1);
    //将当前的视图渲染到上下文
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //获得当前的上下文就是自己上面画的上下文
    CGContextRef conntext = UIGraphicsGetCurrentContext();
    //制作水印
    NSString *str = @"君君出品,必属精品";
    [str drawAtPoint:CGPointMake(20, 320) withFont:[UIFont systemFontOfSize:12]];
    
    
    
    //绘制图标
    UIImage *image = [UIImage imageNamed:@"up.jpg"];
    //绘制到某个矩形
   // [image drawInRect:CGRectMake(220, 300, 320, 480)];
    [image drawAsPatternInRect:CGRectMake(220, 300, 320, 480)];
    //讲图片会知到某个点
  //  [image drawAtPoint:CGPointMake(220, 330)];
    
    
    
    
    //从图像绘制上下文
    UIImage *contentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //把保存的图片放到沙盒里面
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSLog(@"%@",path);
    NSString *routePath = [NSString stringWithFormat:@"%@/view.png",path];
    NSLog(@"%@",routePath);
    [UIImagePNGRepresentation(contentImage) writeToFile:routePath atomically:YES];
    if ([UIImagePNGRepresentation(contentImage) writeToFile:routePath atomically:YES] == YES) {
        NSLog(@"successfully");
    }
    return contentImage;
}


//设置图片
- (void)orangePaint:(id)sender {
    DarwClass *darw = (DarwClass *)self.view;
  
    UIButton *but = (UIButton *)sender;
    [darw getColor:but];
  
    
}

//清楚的按钮

- (IBAction)clearScreen:(id)sender {
    [self.mainArray removeAllObjects];
    
    [self.view setNeedsDisplay];
}



//清楚颜色
- (IBAction)clearColor:(id)sender {
    DarwClass *darw = (DarwClass *)self.view;
    UIButton *but = (UIButton *)sender;
    [darw getColor:but];
}

- (IBAction)sizePaint:(id)sender {
    [self.mainArray removeLastObject];
    [self.view setNeedsDisplay];
    
}

//slider的设置
- (void)sizeChange:(id)sender {
    DarwClass *darw = (DarwClass *)self.view;
    UISlider *slider = (UISlider *)sender;
    slider.minimumValue = 6;
    slider.maximumValue = 20;
    [darw getSize:slider.value];
}

- (IBAction)resave:(id)sender {
    [self createImageFromView];
}

- (IBAction)rotate:(id)sender {
    self.navigationController.navigationBarHidden = YES;
    self.toolView .hidden = YES;
    
}

- (IBAction)hiddenButton:(id)sender {
    self.navigationController.navigationBarHidden = NO;
    self.toolView.hidden = NO;
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    DarwClass *darw = (DarwClass *)self.view;
//    [_mainArray addObject:darw.array];
//    return YES;
//}




@end
