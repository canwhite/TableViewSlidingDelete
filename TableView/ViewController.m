//
//  ViewController.m
//  TableView
//
//  Created by zack on 2017/7/18.
//  Copyright © 2017年 zack. All rights reserved.
//

#import "ViewController.h"


@interface TextTableViewCell : UITableViewCell


@property(nonatomic,strong) UILabel *descriptionLabel;


@end



@implementation TextTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 300, 30)];
        self.descriptionLabel.textColor = [UIColor blackColor];
        self.descriptionLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.descriptionLabel];
    }
    return self;
}
@end





@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray *dataArray;




@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    self.dataArray = [NSMutableArray arrayWithArray:@[@"123",@"123",@"123",@"123",@"123",@"123",@"123"]];
    [self.view addSubview:self.tableView];

    
    
}


-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor grayColor];
        [_tableView registerClass:[TextTableViewCell class] forCellReuseIdentifier:@"cell1"];
        _tableView.separatorStyle = NO;

    }
    return  _tableView;


}


#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //
    cell.descriptionLabel.text = self.dataArray[indexPath.row];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 130;


}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %ld row", (long)indexPath.row);
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//编辑处理和驳回
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    UITableViewRowAction *layTopRowAction1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"处理" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//
//        [self.dataArray removeObjectAtIndex:indexPath.row];
//        // Delete the row from the data source.
//        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//
//    }];
    UITableViewRowAction *layTopRowAction2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"驳回" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        //正常情况下在这里直接进行数据请求就可以了
        [self.dataArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }];
    
    
    layTopRowAction2.backgroundColor = [UIColor redColor];
    NSArray *arr = @[layTopRowAction2];
    
    return arr;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
