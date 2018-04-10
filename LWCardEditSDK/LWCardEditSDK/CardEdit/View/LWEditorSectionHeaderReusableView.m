//
//  LWEditorSectionHeaderReusableView.m
//  CardEditor
//
//  Created by linwei on 2017/11/1.
//  Copyright © 2017年 linwei. All rights reserved.
//

#import "LWEditorSectionHeaderReusableView.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define GAP 5
@implementation LWEditorSectionHeaderReusableView
- (UILabel *)leftLabel{
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(GAP*3, GAP, 200, 30)];
        _leftLabel.font = [UIFont boldSystemFontOfSize:15];
        _leftLabel.textColor = UIColorFromRGB(0x333333);
        _leftLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _leftLabel;
}
- (UILabel *)rightLabel{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) -GAP*2 - 100 ,GAP, 100, 30)];
        _rightLabel.font = [UIFont systemFontOfSize:12];
        _rightLabel.textColor = UIColorFromRGB(0x999999);
        _rightLabel.adjustsFontSizeToFitWidth = YES;
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        [self loadSubViews];
    }
    return self;
    
}
- (void)loadSubViews{
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
}
@end
