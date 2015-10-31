//
//  SearchViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/30.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "SearchViewController.h"
#import "RentTabViewCell.h"
#import "SearchView.h"
@interface SearchViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SearchViewController{
    NSArray *data;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setInit{
    [super setInit];
    [self.navigationController setNavigationBarHidden:false];
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"base_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backToMainView)];
    self.navigationItem.leftBarButtonItem = leftBar;
    self.navigationItem.rightBarButtonItem = nil;
    self.title = @"查找更多";
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"SearchView" bundle:nil] forCellWithReuseIdentifier:@"SearchCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"RentTabViewCell" bundle:nil] forCellReuseIdentifier:@"RentCell"];
    data = [NSArray arrayWithObjects:@{@"image":@"main_map_rent",@"title":@"同济大学四平路校区",@"detail":@"上海市四平路1239号"}, @{@"image":@"main_map_rent",@"title":@"希尔顿酒店",@"detail":@"上海市松花江路271号"}, @{@"image":@"main_map_rent",@"title":@"浦东利卡儿酒店",@"detail":@"上海市世纪大道8号"},nil];
    
}
//-(void)setBtnView:(UIButton *)btn Image:(NSString *)image Type:(NSString *)type Content:(NSString *)content{
//}
-(void)backToMainView{
    [self.navigationController popViewControllerAnimated:YES];
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"SearchCell";
    SearchView* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(indexPath.row == 0){
        [cell setDataWithImage:@"search_place" WithType:@"位置" WithContent:@"杨浦区"];
    }else{
        [cell setDataWithImage:@"search_type" WithType:@"类型" WithContent:@"全部"];
    }
    
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.bounds.size.width/2-10, 40);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return data.count;
 }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // indexPath.section,根据分组进行更精确的配置
    return 82.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RentTabViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentCell"];
    if(cell){
        [cell setValueWithImage:[data[indexPath.row] valueForKey:@"image"] WithTitle:[data[indexPath.row] valueForKey:@"title"] WithDetail:[data[indexPath.row] valueForKey:@"detail"]];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 2){
        
    }
}

@end
