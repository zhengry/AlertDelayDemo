//
//  ViewController.m
//  AlertDelayDemo
//
//  Created by zry on 2016/5/11.
//  Copyright © 2016年 zry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 50;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
    header.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = header;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellId"];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//无论设置为default还是其他样式都有延迟，只是为None时延迟更久
        
       //使用普通控件点击弹出alertController时，没有延迟
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(130, 10, 100, 30);
        button.backgroundColor = [UIColor blueColor];
        [button setTitle:@"show alert" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
    }
    cell.textLabel.text = @"这个是title";
    cell.detailTextLabel.text = @"这个是detail title";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//解决延迟方法1
    [self showAlert];
}


-(void)showAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你是个girl还是个boy？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"男孩" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"user selection is a boy");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"女孩" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"user selection is a girl");
    }]];
    
    //解决延迟方法2
//    dispatch_async(dispatch_get_main_queue(), ^{
         [self presentViewController:alertController animated:YES completion:nil];
//    });
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
