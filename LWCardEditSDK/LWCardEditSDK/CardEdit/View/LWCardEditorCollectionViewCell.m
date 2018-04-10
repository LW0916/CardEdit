//
//  LWCardEditorCollectionViewCell.m
//  CardEditor
//
//  Created by linwei on 2017/11/1.
//  Copyright © 2017年 linwei. All rights reserved.
//

#import "LWCardEditorCollectionViewCell.h"
//#import "UIImageView+SDWebCache.h"

#define TITLTHEIGHT 25
#define GAP 10
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LWCardEditorCollectionViewCell()
@property(nonatomic,strong)LWCardEditorModel *menumodel;
@end

@implementation LWCardEditorCollectionViewCell

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:10];
        _contentLabel.adjustsFontSizeToFitWidth = YES;
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = UIColorFromRGB(0x333333);
    }
    return _contentLabel;
}
- (UIImageView *)editImageView{
    if (_editImageView == nil) {
        _editImageView = [[UIImageView alloc] init];        
    }
    return _editImageView;
}
- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.userInteractionEnabled = YES;
    }
    return  _iconImageView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self loadSubviews];
    }
    return self;
}
- (void)loadSubviews{
    [self addSubview:self.iconImageView];
    [self addSubview:self.contentLabel];
    [self addSubview:self.editImageView];

}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.contentLabel setFrame:CGRectMake(0, self.frame.size.height - TITLTHEIGHT, self.bounds.size.width ,TITLTHEIGHT)];
    [self.editImageView setFrame:CGRectMake(self.bounds.size.width - 16.5, 1.5, 15, 15)];
    CGFloat iconImageHeight = CGRectGetHeight(self.frame)- TITLTHEIGHT-4;
    [self.iconImageView setFrame:CGRectMake((self.frame.size.width -iconImageHeight)/2 , 2, iconImageHeight, iconImageHeight)];
//    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width / 2;
}
#pragma mark - 是否处于编辑状态

- (void)setInEditState:(BOOL)inEditState
{
    _inEditState = inEditState;
    if (inEditState) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.editImageView.hidden = NO;
    } else {
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.editImageView.hidden = YES;
    }
}

- (void)configCellWithCardEditorModel:(LWCardEditorModel *)model andEditState:(LWCardEditState)editState{
    self.contentLabel.text = model.title;
//    [self.iconImageView  sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:model.placeholderImage];
    [self.iconImageView setImage:model.placeholderImage];
    switch (editState) {
        case LWCardEditStateAdd:
            [self.editImageView setImage:model.addImage];
            break;
        case LWCardEditStateExist:
            [self.editImageView setImage:model.existImage];
            break;
        case LWCardEditStateReduce:
            [self.editImageView setImage:model.reduceImage];
            break;
        default:
            break;
    }
}
@end
