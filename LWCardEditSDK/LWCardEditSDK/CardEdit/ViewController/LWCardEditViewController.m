//
//  LWCardEditViewController.m
//  LWCardEditSDK
//
//  Created by lwmini on 2018/4/4.
//  Copyright © 2018年 lw. All rights reserved.
//

#import "LWCardEditViewController.h"
#import "NSBundle+LWPath.h"
#import "UIImage+LWBundle.h"
#import "LWCardEditorModel.h"
#import "LWCardEditorView.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width

@interface LWCardEditViewController ()<LWCardEditorViewDelegate>

@property (nonatomic, strong) UIButton *rightNaviBtn;
@property (nonatomic, strong) LWCardEditorView *moreCardEditView;

@end

@implementation LWCardEditViewController
#pragma mark - Get Methods

-(UIButton *)rightNaviBtn{
    if (!_rightNaviBtn) {
        _rightNaviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightNaviBtn addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightNaviBtn setTitle:@"完成" forState:UIControlStateSelected];
        [_rightNaviBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_rightNaviBtn sizeToFit];
        [_rightNaviBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _rightNaviBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _rightNaviBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNaviBtn];
    [self p_setupSubViews];
    [self p_setData];
   // Do any additional setup after loading the view.
}
-(void)p_setupSubViews{
    self.moreCardEditView =  [[LWCardEditorView alloc]initWithFrame:self.view.bounds];
    self.moreCardEditView.delegate = self;
    self.moreCardEditView.editBtn = self.rightNaviBtn;
    self.moreCardEditView.cellSpacing = floor(SCREEN_WIDTH/20) ;
    [self.view addSubview:self.moreCardEditView];
}
- (void)p_setData{
    NSString *path = [NSBundle myPathForResource:@"EditData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *editDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    //我的应用赋值
    NSDictionary *mydict =[editDict objectForKey:@"myApp"];
    NSMutableDictionary *myAppDictionary = [NSMutableDictionary dictionary];
    [myAppDictionary setObject:mydict[@"title"] forKey:LEFTTITLE];
    [myAppDictionary setObject:@"按住拖动调整位置" forKey:RIGHTTITLE];
    NSMutableArray *modelMyArr =[self exchangeModelArrayWith:mydict[@"data"]];
    [myAppDictionary setObject:modelMyArr forKey:DATA];
    //全部应用赋值
    NSMutableArray *allDataMutArray = [[NSMutableArray alloc]init];
    NSArray *allArr = [editDict objectForKey:@"allApp"];
    for (NSDictionary *allDict in allArr) {
        NSMutableDictionary *allAppDictionary = [NSMutableDictionary dictionary];
        [allAppDictionary setObject:allDict[@"title"] forKey:LEFTTITLE];
        [allAppDictionary setObject:@"" forKey:RIGHTTITLE];
        NSMutableArray *modelAllArr = [self exchangeModelArrayWith:allDict[@"data"]];
        [allAppDictionary setObject:modelAllArr forKey:DATA];
        [allDataMutArray addObject:allAppDictionary];
    }
    [self.moreCardEditView reloadData:allDataMutArray andMyDict:myAppDictionary andRowNum:4];

}
- (NSMutableArray *)exchangeModelArrayWith:(NSArray *)array{
    NSMutableArray *modelArr = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        LWCardEditorModel *model = [[LWCardEditorModel alloc]init];
        model.itemId = dict[@"itemId"];
        model.title = dict[@"title"];
        model.placeholderImage = [UIImage imageMyBundleNamed:@"icon_tongyong"];
        model.addImage = [UIImage imageMyBundleNamed:@"icon_cardEdit_add"];
        model.existImage = [UIImage imageMyBundleNamed:@"icon_cardEdit_alreadyAdd"];
        model.reduceImage = [UIImage imageMyBundleNamed:@"icon_cardEdit_subtract"];
        [modelArr addObject:model];
    }
    return modelArr;
}
- (void)rightBarButtonItemAction:(UIButton *)sender {
    __weak typeof(self) tempSelf = self;
    [self.moreCardEditView editBtnClickAction:sender finish:^(id returnValue) {
        NSLog(@"%@",returnValue);
    }];
}

#pragma mark - LWCardEditorViewDelegate item点击回调
- (void)didSelectItemModel:(LWCardEditorModel *)model{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:model.title message:[NSString stringWithFormat:@"id：%@",model.itemId] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alert show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
