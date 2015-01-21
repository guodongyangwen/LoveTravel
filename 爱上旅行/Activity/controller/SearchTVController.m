//
//  SearchTVController.m
//  爱上旅行
//
//  Created by 闪 on 14-12-29.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "SearchTVController.h"

@interface SearchTVController ()
//cell数据
@property(nonatomic,retain)NSArray *dataArr;  //title数组

@property(nonatomic,retain)NSMutableArray *btnArr;//按钮数组



@property(nonatomic,retain)NSArray *firArr,*secondArr;
@property(nonatomic,retain)UITextField *textF;

@property(nonatomic)BOOL firstCell;
@end

@implementation SearchTVController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.firstCell=YES;
    }
    return self;
}

-(void)dealloc
{
    self.dataArr=nil;
    self.btnArr=nil;
    self.firArr=nil;
    self.secondArr=nil;
    self.textF=nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.firArr=[[NSArray alloc]init];
    self.secondArr=[[NSArray alloc]init];
    _firArr=@[@"四川",@"新疆",@"西藏",@"青海",@"内蒙古"];
    _secondArr=@[@"春节",@"元旦",@"中秋",@"国庆",@"滑翔",@"潜水",@"探险",@"强驴记",@"进阶",@"入门",@"培训",@"摄影",@"速降",@"溯溪",@"徒步"];
    [self.tableView registerClass:[SeatchTableViewCell class] forCellReuseIdentifier:@"search"];
    
    [self layoutNavigationBar];
    
}


#pragma mark --设置导航栏--
-(void)layoutNavigationBar
{

    //给View加个手势 tap的话释放键盘
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardBack:)];
    [self.view addGestureRecognizer:tap];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    UIButton *leftBtn=[UIButton buttonWithType: UIButtonTypeSystem];
    leftBtn.frame=CGRectMake(0, 0, 20, 30);
    [leftBtn addTarget:self action:@selector(backListView) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"icon_navigationbar_back_33x44@2x.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.textF=[[UITextField alloc]initWithFrame:CGRectMake(-10, 0, 200, 30)];
    _textF.backgroundColor=[UIColor whiteColor];
    _textF.placeholder=@"搜索目的地 旅程 活动类型";
    _textF.font=[UIFont fontWithName:nil size:13];
    _textF.layer.cornerRadius=6.0;
    _textF.keyboardType=UIKeyboardTypeWebSearch;
    _textF.delegate=self;
    
    UIImageView *imageV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_actionbar_search_pressed_44x44@2x.png"]];
    imageV.frame=CGRectMake(0, 0, 35, 35);
    _textF.leftView=imageV;
    _textF.leftViewMode=UITextFieldViewModeAlways;
    [imageV release];
    
    UIButton *clearBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [clearBtn addTarget:self action:@selector(clearText:) forControlEvents:UIControlEventTouchUpInside];
    [clearBtn setBackgroundImage:[UIImage imageNamed:@"textFclear.png"] forState:UIControlStateNormal];
    clearBtn.frame=CGRectMake(0, 0, 15, 15);
    _textF.rightView=clearBtn;
    _textF.rightViewMode=UITextFieldViewModeWhileEditing;
    

    UIButton *rightBtn=[UIButton buttonWithType: UIButtonTypeSystem];
    rightBtn.frame=CGRectMake(0, 0, 30, 30);
    [rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(searchHandle:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
  
    self.navigationItem.titleView=_textF;
    
}

-(void)clearText:(UIButton*)btn
{
    self.textF.text=@"";
}
-(void)keyboardBack:(UITapGestureRecognizer*)tap
{
    [self.textF resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self searchHandle:nil];
    return YES;
}
-(void)searchHandle:(UIButton*)btn
{
    if ([_textF.text isEqualToString:@""]) {
        UIAlertView *alertV=[[UIAlertView alloc]initWithTitle:nil message:@"搜索内容为空" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [alertV show];
        [alertV performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:nil afterDelay:1.0f];
        [alertV release];
    }else{
        self.passValue(_textF.text);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}


-(void)backListView
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return 1;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return @"热门目的地";
    }else{
        return @"活动类型";
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 100;
    }else{
        return 200;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     SeatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"search" forIndexPath:indexPath];
    
    
    
    if (indexPath.section==0) {
        cell.dataArr=[_firArr retain];
       
    }else{
        cell.dataArr=_secondArr;
    }
    
    if (self.firstCell==YES) {
        for (UIButton *btn in cell.btnArr) {
           [btn addTarget:self action:@selector(cellSearch:) forControlEvents:UIControlEventTouchUpInside];;
        }
    }
   
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
  return cell;
}

-(void)cellSearch:(UIButton*)btn
{
    self.passValue(btn.titleLabel.text);
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
