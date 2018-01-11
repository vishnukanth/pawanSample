//
//  ViewController.m
//  TodayWidget
//
//  Created by VishnuKanth on 11/10/17.
//  Copyright © 2017 Libre. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)setButtonPressed:(id)sender
{
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.LibreExtensionSharingDefaults"];
    [sharedDefaults setInteger:[self.textField.text integerValue] forKey:@"MyNumberKey"];    [sharedDefaults synchronize];   // (!!) This is crucial.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
