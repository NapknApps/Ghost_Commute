//
//  ViewController.m
//  Napkn
//
//  Created by Zach Whelchel on 9/28/15.
//  Copyright © 2015 Napkn. All rights reserved.
//

#import "ViewController.h"
#import "FirebaseHelper.h"
#import "DefaultsHelper.h"
#import "AccountViewController.h"

@interface ViewController () <AccountViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self hideAllInitialElements];
    
    if (![DefaultsHelper introShown]) {
        [self performSegueWithIdentifier:@"Intro" sender:self];
    }
    else if (![FirebaseHelper userIsLoggedIn]) {
        [self performSegueWithIdentifier:@"Account" sender:self];
    }
    else {
        [self showAllInitialElements];
    }
}

- (void)hideAllInitialElements
{
    
}

- (void)showAllInitialElements
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Account"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        AccountViewController *accountViewController = (AccountViewController *)navigationController.viewControllers.firstObject;
        accountViewController.delegate = self;
    }
}

- (void)accountViewControllerDidLogin:(AccountViewController *)accountViewController
{
    NSLog(@"Did log in");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
