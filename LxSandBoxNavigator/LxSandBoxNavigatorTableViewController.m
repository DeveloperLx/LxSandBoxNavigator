//
//  LxSandBoxNavigatorTableViewController.m
//

#import "LxSandBoxNavigatorTableViewController.h"
#import "FileCell.h"
#import "FileModel.h"

static NSString * FileCellIdentifier = @"FileCellIdentifier";

@interface LxSandBoxNavigatorTableViewController ()

@property (nonatomic,strong) NSMutableArray * fileArray;

@end

@implementation LxSandBoxNavigatorTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"SandBox";
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self.tableView registerClass:[FileCell class] forCellReuseIdentifier:FileCellIdentifier];    
}

- (void)setRootPath:(NSString *)rootPath
{
    if (_rootPath != rootPath) {
        
        FileModel * fileModel = [[FileModel alloc]init];
        fileModel.path = rootPath;
        fileModel.depth = 0;
        fileModel.name = fileModel.path.lastPathComponent;
        [self.fileArray addObject:fileModel];
        [self.tableView reloadData];
        
        _rootPath = [rootPath copy];
    }
}

- (NSMutableArray *)fileArray
{
    if (_fileArray == nil) {
        _fileArray = [[NSMutableArray alloc]init];
    }
    return _fileArray;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.fileArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FileCell *cell = [tableView dequeueReusableCellWithIdentifier:FileCellIdentifier forIndexPath:indexPath];
    
    FileModel * fileModel = self.fileArray[indexPath.row];
    
    cell.depth = fileModel.depth;
    cell.nameLabel.text = fileModel.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FileModel * fileModel = self.fileArray[indexPath.row];
    
    if (!(fileModel.isDirectory && fileModel.hasContents)) {
        return;
    }
    
    fileModel.openContents = !fileModel.openContents;
    
    if (fileModel.openContents)  {
        
        NSMutableArray * insertIndexPathArray = [NSMutableArray array];
        NSMutableIndexSet * insertIndexSet = [NSMutableIndexSet indexSet];
        
        for (NSInteger i = 0; i < fileModel.contentArray.count; i++) {
            NSIndexPath * insertIndexPath = [NSIndexPath indexPathForRow:indexPath.row + i + 1 inSection:0];
            [insertIndexPathArray addObject:insertIndexPath];
            [insertIndexSet addIndex:indexPath.row + i + 1];
        }
        
        [self.fileArray insertObjects:fileModel.contentArray atIndexes:insertIndexSet];
        
        [tableView beginUpdates];
        
        [tableView insertRowsAtIndexPaths:insertIndexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [tableView endUpdates];
    }
    else {
        
        NSMutableArray * deleteIndexPathArray = [NSMutableArray array];
        NSMutableIndexSet * deleteIndexSet = [NSMutableIndexSet indexSet];
        
        for (NSInteger i = indexPath.row + 1; i < self.fileArray.count; i++) {
            
            FileModel * nextFileModel = self.fileArray[i];
            
            if (nextFileModel.depth > fileModel.depth) {
                
                [deleteIndexSet addIndex:i];
                
                [deleteIndexPathArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
        }
        
        [self.fileArray removeObjectsAtIndexes:deleteIndexSet];
        
        [tableView beginUpdates];
        
        [tableView deleteRowsAtIndexPaths:deleteIndexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [tableView endUpdates];
    }
}

@end
