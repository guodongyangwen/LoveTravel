//
//  ThemeTVController.m
//  爱上旅行
//
//  Created by 闪 on 15-1-6.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import "ThemeTVController.h"

@interface ThemeTVController ()
@property(nonatomic,retain)NSMutableArray *imageArr;
@end

@implementation ThemeTVController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeThemeHandle:) name:kThemeChangeNotification object:nil];
    }
    return self;
}
-(void)changeThemeHandle:(NSNotification*)notification
{
    NSDictionary *dic=notification.userInfo;
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:[dic valueForKey:@"tbImage"]]];
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:[dic valueForKey:@"naImage"]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setNeedsDisplay];
    [self.tabBarController.tabBar setNeedsDisplay];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"themeCell"];
    [self requestData];
    
}

-(void)requestData
{
    self.themeArr=[[NSArray alloc]init];
    self.imageArr=[[NSMutableArray alloc]init];
    NSString *path=[[NSBundle mainBundle]pathForResource:@"Theme.json" ofType:nil];
    NSData *data=[NSData dataWithContentsOfFile:path];
    self.themeArr =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    for (int i=0; i<5; i++) {
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"tb_bg%d.jpg",i]];
        [_imageArr addObject:image];
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [_themeArr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"themeCell" forIndexPath:indexPath];
    //cell.imageView.image=[UIImage imageNamed:@"TabBar_test.png"];
    cell.imageView.image=[_imageArr objectAtIndex:indexPath.row];
    cell.imageView.frame=CGRectMake(0, 0, 200, 60);
    NSString *string=[[_themeArr objectAtIndex:indexPath.row] valueForKey:@"themeName"];
    cell.textLabel.text=string;
    cell.textLabel.textAlignment=NSTextAlignmentRight;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for(int i=0;i<[_themeArr count];i++){
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryCheckmark;
    
    //发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:kThemeChangeNotification object:self userInfo:[_themeArr objectAtIndex:indexPath.row]];
    [[NSUserDefaults standardUserDefaults]setObject:[_themeArr objectAtIndex:indexPath.row] forKey:@"theme"];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
