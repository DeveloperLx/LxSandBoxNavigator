//
//  FileModel.h
//

#import <Foundation/Foundation.h>

@interface FileModel : NSObject

@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * path;
@property (nonatomic,assign) NSUInteger depth;
@property (nonatomic,assign) BOOL openContents;
@property (nonatomic,strong) NSArray * contentArray;
@property (nonatomic,readonly) BOOL isDirectory;
@property (nonatomic,readonly) BOOL hasContents;

@end
