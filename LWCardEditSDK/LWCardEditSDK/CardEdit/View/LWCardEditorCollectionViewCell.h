//
//  LWCardEditorCollectionViewCell.h
//  CardEditor
//
//  Created by linwei on 2017/11/1.
//  Copyright © 2017年 linwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWCardEditorModel.h"
typedef enum
{
    LWCardEditStateAdd,
    LWCardEditStateExist,
    LWCardEditStateReduce
} LWCardEditState;

@interface LWCardEditorCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *editImageView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, assign) BOOL inEditState; //是否处于编辑状态
- (void)configCellWithCardEditorModel:(LWCardEditorModel *)model andEditState:(LWCardEditState)editState;
@end
