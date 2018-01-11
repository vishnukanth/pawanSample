//
//  TodayViewController.m
//  SampleWidget
//
//  Created by VishnuKanth on 11/10/17.
//  Copyright © 2017 Libre. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>
{
    
}

@property(nonatomic,weak)IBOutlet UILabel *numberLbl;

@end

@implementation TodayViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userDefaultsDidChange:)
                                                     name:NSUserDefaultsDidChangeNotification
                                                   object:nil];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Second Commit");
    self.numberLbl.userInteractionEnabled =YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(numberClick)];
    tap.numberOfTapsRequired = 1;
    [self.numberLbl addGestureRecognizer:tap];
    [self updateNumberLabelText];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

-(void)numberClick
{
    NSString *phoneStr = [[NSString alloc] initWithFormat:@"tel:%@",self.numberLbl.text];
    NSURL *phoneURL = [[NSURL alloc] initWithString:phoneStr];
    [self.extensionContext openURL:phoneURL completionHandler:^(BOOL success) {
        NSLog(@"fun=%s after completion. success=%d", __func__, success);
    }];
}

- (void)userDefaultsDidChange:(NSNotification *)notification {
    [self updateNumberLabelText];
}

- (void)updateNumberLabelText {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.LibreExtensionSharingDefaults"];
    NSInteger number = [defaults integerForKey:@"MyNumberKey"];
    self.numberLbl.text = [NSString stringWithFormat:@"%ld", (long)number];
}

@end
