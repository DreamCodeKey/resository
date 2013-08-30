//
//  DarwClass.m
//  Painting
//
//  Created by apple on 13-8-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "DarwClass.h"
#import "PaintObject.h"
#import "ViewController.h"

@interface DarwClass ()
{
    UIColor *_color;
    float  _width;
    
}

@end
@implementation DarwClass
@synthesize obj = _obj;
@synthesize array = _array;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
//从xib文件里新建的view会先,自动调用这个方法
- (id)initWithCoder:(NSCoder *)aDecoder
{
    

    if (self = [super initWithCoder:aDecoder]) {
        _array  = [[NSMutableArray alloc]init];
        //设置_width的默认值
        _width = 6;
    }
    return self;
}

//从xib文件里都会调用此方法/
- (void)awakeFromNib
{
   
}

- (void)drawLine
{
//    NSLog(@"%f",_obj.location.x);
//    _obj = [[ViewController alloc]init];
    
   // [self getLocation];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2次编历 得到我们所有的数据
    for (PaintObject *subArray  in _obj.mainArray) {
        if( subArray  == nil)
        {
            continue;
        }
        //取到第一点的坐标
        NSValue *first = [subArray.paintArray objectAtIndex:0];
        CGPoint fir = [first CGPointValue];
        CGContextMoveToPoint(context, fir.x, fir.y);
        
        for (NSValue * data in subArray.paintArray) {
            
            CGPoint  location = [data CGPointValue];
            CGContextAddLineToPoint(context, location.x, location.y);
            NSLog(@"%f",location.x);
        }
        [subArray.paintColor setStroke];
        CGContextSetLineWidth(context, subArray.value);
        CGContextStrokePath(context);
    }
   

    
}

- (void)getColor:(UIButton *)button
{
    [_color release];
    switch (button.tag) {
        case 1:
            
            _color = [[UIColor  orangeColor] retain];
            break;
        case 2:
            _color = [[UIColor purpleColor]retain];
            break;
        case 3:
            _color = [[UIColor yellowColor]retain];
            break;
        case 4:
            _color = [[UIColor blueColor]retain];
            break;
        case 5:
            _color = [[UIColor grayColor]retain];
        default:
            break;
    }
   
}

- (void)getSize:(float)sliderValue
{  
    _width = sliderValue;
}

//- (void)getLocation
//{
//    //第一种方法吧cgpiont转化成string对象
////    NSString *valu = NSStringFromCGPoint(_obj.location);
//    
//    //第二种方法 把成功point转化成value的对象
//    NSValue *value  =[NSValue valueWithCGPoint:_obj.location];
//    [_array addObject:value];
//   
//}


- (void)addLocation:(CGPoint)point isBegin:(BOOL)flag
{
    //把穿过来的参数进行判断
    if (flag) {
        
        PaintObject *paintObj = [[PaintObject alloc]init];
        paintObj.paintArray = [[NSMutableArray alloc]init];
        paintObj.paintColor = _color;
        paintObj.value = _width;
        [_obj.mainArray addObject:paintObj];
    }
    
    PaintObject *name = [_obj.mainArray lastObject];
    [name.paintArray addObject:[NSValue valueWithCGPoint:point]];
}




- (void)drawRect:(CGRect)rect
{
    [self drawLine];
    

}

- (void)dealloc
{
    [_color release];
    [super dealloc];
}
@end
