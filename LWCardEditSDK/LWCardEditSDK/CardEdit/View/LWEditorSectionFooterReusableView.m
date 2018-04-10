//
//  LWEditorSectionFooterReusableView.m
//  CardEditor
//
//  Created by linwei on 2017/11/1.
//  Copyright © 2017年 linwei. All rights reserved.
//

#import "LWEditorSectionFooterReusableView.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation LWEditorSectionFooterReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = UIColorFromRGB(0xf5f5f5);
    }
    return self;
}
@end
