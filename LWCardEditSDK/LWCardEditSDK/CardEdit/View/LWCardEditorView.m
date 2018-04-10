//
//  LWCardEditorView.m
//  CardEditor
//
//  Created by linwei on 2017/11/1.
//  Copyright © 2017年 linwei. All rights reserved.
//

#import "LWCardEditorView.h"
#import "LWCardEditorCollectionViewCell.h"
#import "LWEditorSectionFooterReusableView.h"
#import "LWEditorSectionHeaderReusableView.h"
#import "LWCardManagerLayout.h"

@interface LWCardEditorView ()<UICollectionViewDelegate,UICollectionViewDataSource,LWCardManagerDelegate>{
    NSInteger _itemHeight;
}

@property(nonatomic,strong)UICollectionView *mainCollectionView;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)NSMutableArray *myDataSource;
@property(nonatomic,strong)NSDictionary *mySource;
@property (nonatomic, assign)BOOL inEditState; //是否处于编辑状态
@property (nonatomic, strong) UILabel *messageLabel; //删除完毕时

@end

@implementation LWCardEditorView
//没有应用的提示
- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize:12];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.text = @"您还未添加任何应用\n点击下面的应用可以添加";
    }
    return _messageLabel;
}

- (LWCardManagerLayout *)mainCollectionLayout{
    if (_mainCollectionLayout == nil) {
        _mainCollectionLayout = [[LWCardManagerLayout alloc]init];
        _mainCollectionLayout.delegate = self;
        _mainCollectionLayout.sectionInset = UIEdgeInsetsMake(_cellSpacing, _cellSpacing, _cellSpacing, _cellSpacing);
        _mainCollectionLayout.minimumLineSpacing = _cellSpacing;
        _mainCollectionLayout.minimumInteritemSpacing = _cellSpacing;
        _mainCollectionLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
    }
    return _mainCollectionLayout;
}
- (UICollectionView *)mainCollectionView{
    if (_mainCollectionView == nil) {
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.mainCollectionLayout];
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        _mainCollectionView.bounces = NO;
        _mainCollectionView.showsHorizontalScrollIndicator = NO;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.delegate = self;
        [_mainCollectionView registerClass:[LWCardEditorCollectionViewCell class]
                forCellWithReuseIdentifier:@"SUBVIEW"];
         [_mainCollectionView registerClass:[LWEditorSectionHeaderReusableView  class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER"];
        [_mainCollectionView registerClass:[LWEditorSectionFooterReusableView  class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FOOTER"];

    }
    return _mainCollectionView;
}
- (NSDictionary *)mySource{
    if (_mySource == nil) {
        _mySource = [[NSDictionary alloc]init];
    }
    return _mySource;
}
- (NSMutableArray *)myDataSource{
    if (_myDataSource == nil) {
        _myDataSource = [[NSMutableArray alloc]init];
    }
    return _myDataSource;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.cellSpacing = 20;
        [self loadSubviews];
    }
    return self;
}
- (void)setCellSpacing:(CGFloat)cellSpacing{
    if (_cellSpacing == cellSpacing) {
        return;
    }
    _cellSpacing = cellSpacing;
    _mainCollectionLayout.sectionInset = UIEdgeInsetsMake(_cellSpacing, _cellSpacing, _cellSpacing, _cellSpacing);
    _mainCollectionLayout.minimumLineSpacing = _cellSpacing;
    _mainCollectionLayout.minimumInteritemSpacing = _cellSpacing;
}
- (void)loadSubviews{
    [self addSubview:self.mainCollectionView];
}
- (void)reloadData:(NSArray *)allDataArray andMyDict:(NSDictionary *)myDict  andRowNum:(NSInteger)rowNum{
    NSInteger itemHeight = (self.mainCollectionView.bounds.size.width -_cellSpacing*(rowNum +1) )/rowNum;
    _itemHeight = itemHeight;
    self.mainCollectionLayout.itemSize = CGSizeMake(itemHeight, itemHeight);
    self.mySource = myDict;
    self.myDataSource = myDict[DATA];
    self.dataSource = allDataArray;
    [self.mainCollectionView reloadData];
}
#pragma mark -UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1+self.dataSource.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.myDataSource.count;
    } else {
        NSMutableDictionary *array =self.dataSource[section-1];
        return [array[DATA] count];
    }
}
//返回头headerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat headerWidth = self.mainCollectionView.frame.size.width;
    if (self.myDataSource.count == 0) {
        if (section == 0) {
            self.messageLabel.frame = CGRectMake(0, 40, headerWidth, _itemHeight);
            //显示没有更多的提示
            [self.mainCollectionView  addSubview:self.messageLabel];
            return CGSizeMake(headerWidth, 40.0 + _itemHeight);
        } else {
            return CGSizeMake(headerWidth, 40.0);
        }
    } else {
        [self.messageLabel removeFromSuperview];
        return CGSizeMake(headerWidth, 40.0);
    }

}

//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section != 0) {
        if (self.dataSource.count == section) {
            return CGSizeZero;
        }
    }
    return CGSizeMake(self.mainCollectionView.frame.size.width, 10);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    LWCardEditorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SUBVIEW" forIndexPath:indexPath];
    LWCardEditorModel *model;
    if (indexPath.section == 0) {
        model = self.myDataSource[indexPath.row];
    }else{
       model = [self.dataSource[indexPath.section-1] objectForKey:DATA] [indexPath.row];
    }
    cell.inEditState = self.inEditState;
    LWCardEditState editState = [self returnEditState:model indexPath:indexPath];
    [cell configCellWithCardEditorModel :model andEditState:editState];
    return cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]) {
        LWEditorSectionHeaderReusableView *_reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            _reuseView.leftLabel.text = self.mySource[LEFTTITLE] ? self.mySource[LEFTTITLE]:@"";
            _reuseView.rightLabel.text  = self.mySource[RIGHTTITLE] ? self.mySource[RIGHTTITLE]:@"";
        }else{
             _reuseView.leftLabel.text =[self.dataSource[indexPath.section - 1] objectForKey:LEFTTITLE];
            _reuseView.rightLabel.text = [self.dataSource[indexPath.section - 1] objectForKey:RIGHTTITLE];
        }
        return _reuseView;
    }
    if ([kind isEqualToString: UICollectionElementKindSectionFooter]) {
        LWEditorSectionFooterReusableView *_reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FOOTER" forIndexPath:indexPath];
        
        return _reuseView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
    if (!self.inEditState) {
        LWCardEditorModel *model;
        if (indexPath.section == 0) {
            model = self.myDataSource[indexPath.row];
        }else{
            model = [self.dataSource[indexPath.section-1] objectForKey:DATA] [indexPath.row];
        }
        if(self.delegate &&[self.delegate respondsToSelector:@selector(didSelectItemModel:)]){
            [self.delegate didSelectItemModel:model];
        }
        
        return;
    }
    if (indexPath.section == 0 && indexPath != nil) { //点击移除
        [self.mainCollectionView performBatchUpdates:^{
            [self.mainCollectionView deleteItemsAtIndexPaths:@[indexPath]];
            [self.myDataSource removeObjectAtIndex:indexPath.row]; //删除
        } completion:^(BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mainCollectionView reloadData];
            });
        }];
    } else if (indexPath != nil) {
        LWCardEditorModel *model =[self.dataSource[indexPath.section - 1] objectForKey:DATA][indexPath.row];
        LWCardEditState editState = [self returnEditState:model indexPath:indexPath];
        if (editState == LWCardEditStateExist) {
            return;
        }
        //点击添加
        //在第一组最后增加一个
        [self.myDataSource addObject:model];
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.myDataSource.count - 1 inSection:0];
        [self.mainCollectionView performBatchUpdates:^{
            [self.mainCollectionView insertItemsAtIndexPaths:@[newIndexPath]];
        } completion:^(BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mainCollectionView reloadData];
            });
        }];
    }
}
//判断item编辑状态
- (LWCardEditState )returnEditState:(LWCardEditorModel *)model indexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return LWCardEditStateReduce;
    }
    for (LWCardEditorModel *object in self.myDataSource) {
        if ([object.itemId isEqualToString:model.itemId]) {
            return LWCardEditStateExist;
        }
    }
    return LWCardEditStateAdd;
}
//编辑按钮点击事件
- (void)editBtnClickAction:(UIButton *)button finish:(void (^)(id returnValue))finishBlock{
    self.editBtn = button;
    if (!self.inEditState) { //点击了管理
        self.inEditState = YES;
    } else { //点击了完成
        self.inEditState = NO;
        //此处可以调用网络请求，把排序完之后的传给服务端
        finishBlock(self.myDataSource);
        NSLog(@"点击了完成按钮");
    }
    [self.mainCollectionLayout setInEditState:self.inEditState];
}
#pragma mark - LWCardManagerDelegate
//处于编辑状态
- (void)didChangeEditState:(BOOL)inEditState{
    self.inEditState = inEditState;
    self.editBtn.selected = inEditState;
    [self.mainCollectionView reloadData];
}

//改变数据源中model的位置
- (void)moveItemAtIndexPath:(NSIndexPath *)formPath toIndexPath:(NSIndexPath *)toPath{
    LWCardEditorModel *model = self.myDataSource[formPath.row];
    //先把移动的这个model移除
    [self.myDataSource removeObject:model];
    //再把这个移动的model插入到相应的位置
    [self.myDataSource insertObject:model atIndex:toPath.row];
}

@end
