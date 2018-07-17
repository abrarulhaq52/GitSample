//
//  ViewController.h
//  Quanfab Test
//
//  Created by Abrar on 17/07/2018.
//  Copyright © 2018 Ilmasoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate>
{
    NSArray * list;
    NSArray * DataList;
    IBOutlet UIView * MainView;
    NSMutableArray * ValueList, * DataToDisplay, *searchByTitle;    
}
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

