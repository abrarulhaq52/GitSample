//
//  ViewController.m
//  Quanfab Test
//
//  Created by Abrar on 17/07/2018.
//  Copyright © 2018 Ilmasoft. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+MaryPopin.h"
#import "PopupView.h"
#import "WebService.h"
#import "Alert.h"
#import "Configuration.h"

@interface ViewController ()
{
    NSMutableArray *filteredData;
    BOOL isFiltered;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self GetDailyAgendaWithChildID];
}

-(void) LoadDelegates
{
    isFiltered = false;
    self.searchBar.delegate = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
}

-(void)GetDailyAgendaWithChildID
{
    [[WebService sharedServices] GetNYTimesApiKey:@"d01029d28b2f49a1adaa58209ff5f426" andCompletionHandler:^(NSDictionary * response) {
        
        if(![[response objectForKey:@"Status"] isEqualToString:@"OK!"])
            if(![[response objectForKey:@"Status"] isEqualToString:@"OK!"])
                [[Alert allAlerts] ShowToastWithMessage:@"There might be issue with your internet connection, or server not responding. Please try again." andTitle:@"Network Problem" andTextAlignment:NSTextAlignmentLeft andBackgroundColor:[UIColor redColor] withIcon:@"AlertIcon"];
        
        if ([[response objectForKey:@"Status"] isEqualToString:@"Error Occurred!"] || [[response objectForKey:@"Code"] isEqualToString:@"0"] || [[response objectForKey:@"Code"] isEqualToString:@"250"] || [[response objectForKey:@"Code"] isEqualToString:@"520"]) {

            [[Alert allAlerts] ShowToastWithMessage:@"There might be issue with your internet connection, or server not responding. Please try again." andTitle:@"Network Problem" andTextAlignment:NSTextAlignmentLeft andBackgroundColor:[UIColor redColor] withIcon:@"AlertIcon"];

            return;

        }
        
        NSLog(@"[response objectForKey:@'Data'] = %@", [response objectForKey:@"Data"]);
        NSLog(@"response.count = %lu", [[response objectForKey:@"Data"] count]);
        
        if ([[response objectForKey:@"Data"] count] != 0) {
            
            self->DataList = [response objectForKey:@"Data"];
            NSLog(@"DataList = %@", self->DataList);

        }
        
        [self LoadDelegates];
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!isFiltered) {
        return DataList.count;
    }
    return filteredData.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    UILabel *labelDate = nil;
    UILabel *labelAuther = nil;
    
    // add tableFooterView at last to show last cell properly.
    tableView.tableFooterView = [[UIView alloc]
                                         initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 100)];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    NSLog(@"screen width = %f",screen_width);
    NSLog(@"screen height = %f",screen_height);
    labelDate = [[UILabel alloc] init];
    labelAuther = [[UILabel alloc] init];
    if (IS_IPAD) {
        if(iPad)
        {
            labelDate.frame = CGRectMake(cell.frame.origin.x, cell.center.y+100, cell.frame.size.width+350, 23);
            labelAuther.frame = CGRectMake(cell.frame.origin.x+20, cell.center.y+100, cell.frame.size.width+350, 23);
        }
        if (iPadPro12) {
            labelDate.frame = CGRectMake(cell.frame.origin.x, cell.center.y+100, cell.frame.size.width+600, 23);
            labelAuther.frame = CGRectMake(cell.frame.origin.x+20, cell.center.y+100, cell.frame.size.width+600, 23);
        }
        if (iPadPro) {
            labelDate.frame = CGRectMake(cell.frame.origin.x, cell.center.y+100, cell.frame.size.width+430, 23);
            labelAuther.frame = CGRectMake(cell.frame.origin.x+20, cell.center.y+100, cell.frame.size.width+430, 23);

        }
    }
    if (IS_IPHONE) {
        labelDate.frame = CGRectMake(cell.frame.origin.x, cell.center.y+100, cell.frame.size.width, 23);
        labelAuther.frame = CGRectMake(cell.frame.origin.x+20, cell.center.y+100, cell.frame.size.width, 23);

        if (IS_IPHONE_5) {
            labelDate.frame = CGRectMake(cell.frame.origin.x, cell.center.y+100, cell.frame.size.width-90, 23);
            labelAuther.frame = CGRectMake(cell.frame.origin.x+20, cell.center.y+100, cell.frame.size.width-90, 23);

        }
        if (IS_IPHONE_6) {
            labelDate.frame = CGRectMake(cell.frame.origin.x, cell.center.y+100, cell.frame.size.width-30, 23);
            labelAuther.frame = CGRectMake(cell.frame.origin.x+20, cell.center.y+100, cell.frame.size.width-90, 23);

        }
    }
    
    
    if (IS_IPAD) {
        if (iPadPro12) {
            cell.textLabel.font = iPadPro12TitleFont;
            cell.detailTextLabel.font = iPadPro12DetailFont;
            labelDate.font = iPadPro12SubDetailFont;
            labelAuther.font = iPadPro12SubDetailFont;
        }
        if (iPadPro) {
            cell.textLabel.font = iPadPro10TitleFont;
            cell.detailTextLabel.font = iPadPro10DetailFont;
            labelDate.font = iPadPro10SubDetailFont;
            labelAuther.font = iPadPro10SubDetailFont;
        }
        if(iPad) {
            cell.textLabel.font = iPadTitleFont;
            cell.detailTextLabel.font = iPadDetailFont;
            labelDate.font = iPadSubDetailFont;
            labelAuther.font = iPadSubDetailFont;
        }
    }
    if (IS_IPHONE) {
        
        cell.textLabel.font = iPhoneTitleFont;
        cell.detailTextLabel.font = iPhoneDetailFont;
        labelDate.font = iPhoneSubDetailFont;
        labelAuther.font = iPhoneSubDetailFont;
        
        if (IS_IPHONE_6) {
            cell.textLabel.font = iPhone6TitleFont;
            cell.detailTextLabel.font = iPhone6DetailFont;
            labelDate.font = iPhone6SubDetailFont;
            labelAuther.font = iPhone6SubDetailFont;
        }
        if (IS_IPHONE_5) {
            cell.textLabel.font = iPhone5TitleFont;
            cell.detailTextLabel.font = iPhone5DetailFont;
            labelDate.font = iPhone5SubDetailFont;
            labelAuther.font = iPhone5SubDetailFont;
        }
    }
    
    
    labelDate.tintColor = [UIColor lightGrayColor];
    labelDate.textColor = [UIColor lightGrayColor];
    labelDate.textAlignment = NSTextAlignmentRight;
    
    labelAuther.tintColor = [UIColor lightGrayColor];
    labelAuther.textColor = [UIColor lightGrayColor];
    labelAuther.textAlignment = NSTextAlignmentLeft;
    
    [labelDate setTag:702];
    [labelAuther setTag:803];
    
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    cell.detailTextLabel.numberOfLines = 1;
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.detailTextLabel.highlightedTextColor = [UIColor lightGrayColor];
    
    list = [self->DataList valueForKey:@"results"][indexPath.row];
    NSLog(@"list = %@", list);
    
    DataToDisplay = [[NSMutableArray alloc] init];
    searchByTitle = [[NSMutableArray alloc] init];
    
    NSString * title = [list valueForKey:@"title"];
    NSLog(@"value %@",title);
    [DataToDisplay addObject:title];
    [searchByTitle addObject:title];
    NSString * detail = [list valueForKey:@"abstract"];
    NSLog(@"detail %@",detail);
    [DataToDisplay addObject:detail];
    NSString * author = [list valueForKey:@"byline"];
    NSLog(@"author %@",author);
    [DataToDisplay addObject:author];
    NSString * date = [list valueForKey:@"published_date"];
    NSLog(@"date %@",date);
    [DataToDisplay addObject:date];
    
    
    if (!isFiltered) {

        
        
        
        NSAttributedString *text = [[NSAttributedString alloc] initWithString:DataToDisplay[0]];
        cell.textLabel.attributedText = text;

        NSMutableParagraphStyle *subtitleParagraphStyle = [NSMutableParagraphStyle new];
        subtitleParagraphStyle.minimumLineHeight = 50;

        NSMutableAttributedString *subText = [[[NSAttributedString alloc] initWithString:DataToDisplay[1]] mutableCopy];
        [subText addAttribute:NSParagraphStyleAttributeName value:subtitleParagraphStyle range:NSMakeRange(0, subText.length)];

        cell.detailTextLabel.attributedText = subText;
        
        NSString * date = DataToDisplay[3];
        labelDate.text = date;
        
        NSString * auther = DataToDisplay[2];

        NSArray *yourWords = [auther componentsSeparatedByCharactersInSet:
                              [NSCharacterSet characterSetWithCharactersInString:@" "]
                              ];
        NSLog(@"auther name seprate = %@",yourWords);
        
        int myStringLength = (int)[auther length];
        NSString *combined = [[yourWords componentsJoinedByString:@" "] substringWithRange:NSMakeRange(0, 10)];
        if (myStringLength >= 5) {
            combined = [[yourWords componentsJoinedByString:@" "] substringWithRange:NSMakeRange(0, 10)];
        }
        else
        {
            combined = [[yourWords componentsJoinedByString:@" "] substringWithRange:NSMakeRange(0, 5)];
        }
        
        NSLog(@"auther name combined = %@",combined);
        
        labelAuther.text = [NSString stringWithFormat:@"%@...",combined];
        
    }
    else {
        // Configure the cell...
        cell.textLabel.text = filteredData[indexPath.row];
    }
    [cell.contentView addSubview:labelDate];
    [cell.contentView addSubview:labelAuther];

    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"index.row = %li",(long)indexPath.row);
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    [[Alert allAlerts] ShowAlertWithMessage:[[self->DataList valueForKey:@"results"][indexPath.row] valueForKey:@"abstract"] andTitle:[[self->DataList valueForKey:@"results"][indexPath.row] valueForKey:@"title"] onViewController:self];
//    
//}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        isFiltered = false;
        [self.searchBar endEditing:YES];
    }
    else {
        isFiltered = true;
        filteredData = [[NSMutableArray alloc]init];
        for (NSString *showList in searchByTitle) {
            NSRange range = [showList rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [filteredData addObject:showList];
            }
        }
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
