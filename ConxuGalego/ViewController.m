//
//  ViewController.m
//  ConxuGalego
//
//  Created by Xurxo Méndez Pérez on 06/01/12.
//  Copyright (c) 2012 ninguna. All rights reserved.
//

#import "ViewController.h"
#import "ConjugateViewController.h"
#import "ASIHTTPRequest.h"
#import "Parser.h"
#import "VerbalTime.h"
#import "Helper.h"

@implementation ViewController

@synthesize verbalTimes;
@synthesize responseData;
@synthesize verbTextField;
@synthesize loadingAlert;
@synthesize searchButton;
@synthesize scrollView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
}

- (void)viewDidUnload
{
    [self setVerbTextField:nil];
    [self setSearchButton:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.verbTextField) {
        [theTextField resignFirstResponder];
    }
    [self search];
    return YES;
}
-(void)search {
    if ([self.verbTextField.text rangeOfString:@" "].location != NSNotFound) {
        UIAlertView *info = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"O termo non pode ter espazos en blanco", nil) 
                                                       message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles: nil];
        [info show];
        return;
    }
    if ([self.verbTextField.text length] > 0) {
        [self grabURLInBackground:self];
        [Helper showAlert];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    [self.searchButton setEnabled:newLength > 0];
    
    return (newLength > 16) ? NO : YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"Conjugate"])
	{
        [Helper dismissAlert];
		ConjugateViewController *conjugateViewController = 
        segue.destinationViewController;
        conjugateViewController.verbalTimes = self.verbalTimes;
        conjugateViewController.verb = self.verbTextField.text;
	}
}

- (IBAction)searchButton:(id)sender {
    [self search];
}

- (IBAction)grabURLInBackground:(id)sender
{
    NSURL *url = [Helper getUrl:self.verbTextField.text];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    Parser *parser = [[Parser alloc] init];
    parser.delegate = self;
    [parser parse:responseString];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ParserDelegate

-(void) doOnSuccess:(NSArray *)conjugations
{
    self.verbalTimes = conjugations;
    [self performSegueWithIdentifier:@"Conjugate" sender:self];
}
-(void) doOnNotFound
{
    NSMutableString *message = [[NSMutableString alloc] initWithFormat:NSLocalizedString(@"O termo \'%@\' non ten forma de verbo", nil), self.verbTextField.text];
    UIAlertView *info = [[UIAlertView alloc] 
                         initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles: nil];
    [Helper dismissAlert];
    [info show];
}

#pragma mark - end

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.verbTextField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.verbTextField.frame.origin.y-kbSize.height);
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

@end