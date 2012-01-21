//
//  ViewController.h
//  ConxuGalego
//
//  Created by Xurxo Méndez Pérez on 06/01/12.
//  Copyright (c) 2012 ninguna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parser.h"

@interface ViewController : UIViewController <UITextFieldDelegate, ParserDelegate> {
    NSMutableData* responseData;
    NSArray *verbalTimes;
    UIAlertView *loadingAlert;
}

@property (nonatomic, retain) NSArray* verbalTimes;
@property (nonatomic, retain) NSMutableData* responseData;
@property (weak, nonatomic) IBOutlet UITextField *verbTextField;
@property (nonatomic, retain) UIAlertView *loadingAlert;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)grabURLInBackground:(id)sender;
- (IBAction)searchButton:(id)sender;
-(void)search;
-(void)showAlert;
-(void)dismissAlert;
- (void)registerForKeyboardNotifications;

@end
