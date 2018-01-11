//
//  ViewController.m
//  TestSearchViewController
//
//  Created by Mac on 2018/1/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "ListTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) UISearchController* searchController;

@end

@implementation ViewController
{
    NSArray* exampleArray;
    NSMutableArray* searchContentArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.tableHeaderView = self.searchController.searchBar;
    exampleArray = @[@"1",@"11",@"12",@"123",@"4",@"5",@"678",@"9"];
    searchContentArray = [NSMutableArray new];
}
-(UISearchController*)searchController{
    if (!_searchController) {
        // searchController 設定
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.delegate = self;
        self.definesPresentationContext = true;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchBar.frame = CGRectMake(_searchController.searchBar.frame.origin.x, _searchController.searchBar.frame.origin.y, _searchController.searchBar.frame.size.width, 44.0);
        //_searchController.searchBar.barTintColor = [UIColor colorWithRed:41.0/255.0 green:152.0/255.0 blue:131.0/255.0 alpha:0.5];
        //_searchController.searchBar.tintColor = [UIColor whiteColor];
    }
    return _searchController;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_searchController.isActive && ![_searchController.searchBar.text isEqualToString:@""]){
        return searchContentArray.count;
    }else{
        return exampleArray.count;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (_searchController.isActive && ![_searchController.searchBar.text isEqualToString:@""]){
        cell.titleLabel.text = searchContentArray[indexPath.row];
    }else{
        cell.titleLabel.text = exampleArray[indexPath.row];
    }
    return cell;
}
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    [searchContentArray removeAllObjects];
    NSString* searchString = searchController.searchBar.text;
    for (int i = 0; i < exampleArray.count; i++) {
        
        NSString* titleString = exampleArray[i];
        if ([titleString rangeOfString:searchString].location != NSNotFound) {
            [searchContentArray addObject:titleString];
        }
    }
    [self.tableView reloadData];
}

@end
