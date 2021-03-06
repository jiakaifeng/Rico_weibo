//
//  HWTitleMenuViewController.m
//  贾凯峰微博项目
//
//  Created by apple on 14-10-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWTitleMenuViewController.h"

@interface HWTitleMenuViewController ()

@end

@implementation HWTitleMenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"好友";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"密友";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"特别关注";
    }else if (indexPath.row == 3) {
        cell.textLabel.text = @"名人";
    }else if (indexPath.row == 4) {
        cell.textLabel.text = @"全部";
    }

    return cell;
}
@end
