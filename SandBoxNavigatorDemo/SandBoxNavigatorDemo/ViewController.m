//
//  ViewController.m
//

#import "ViewController.h"
#import "LxSandBoxNavigatorTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    LxSandBoxNavigatorTableViewController * sbntvc = [[LxSandBoxNavigatorTableViewController alloc]initWithNibName:@"LxSandBoxNavigatorTableViewController" bundle:nil];
    sbntvc.rootPath = NSHomeDirectory();
    
    UINavigationController * sbntnc = [[UINavigationController alloc]initWithRootViewController:sbntvc];
    [self presentViewController:sbntnc animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
