//
//  FileModel.m
//

#import "FileModel.h"

@implementation FileModel

- (void)dealloc
{
    self.name = nil;
    self.path = nil;
    self.contentArray = nil;
}

- (NSArray *)contentArray
{
    if (self.openContents == NO) {
        return @[];
    }
    else if (_contentArray == nil) {
    
        NSError * error = nil;
        
        NSArray * contentFileNameArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:&error];
        
        NSMutableArray * mutableContentArray = [NSMutableArray array];
        
        for (NSString * contentFileName in contentFileNameArray) {
            FileModel * fileModel = [[FileModel alloc]init];
            fileModel.depth = self.depth + 1;
            fileModel.name = contentFileName;
            fileModel.path = [self.path stringByAppendingPathComponent:contentFileName];
            [mutableContentArray addObject:fileModel];
        }
        
        _contentArray = [[NSArray alloc]initWithArray:mutableContentArray];
        return _contentArray;
    }
    else {
        return _contentArray;
    }
}

- (BOOL)isDirectory
{
    BOOL isDirectory = NO;
    BOOL fileExists = [[NSFileManager defaultManager]fileExistsAtPath:self.path isDirectory:&isDirectory];
    return fileExists && isDirectory;
}

- (BOOL)hasContents
{
    NSError * error = nil;
    NSArray * contentArray = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:self.path error:&error];
    return contentArray.count > 0;
}

@end
