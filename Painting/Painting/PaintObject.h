//
//  PaintObject.h
//  Painting
//
//  Created by apple on 13-8-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaintObject : NSObject

@property (nonatomic,retain)NSMutableArray *paintArray;
@property(nonatomic,retain)UIColor *paintColor;
@property(nonatomic,assign)float  value;

@end
