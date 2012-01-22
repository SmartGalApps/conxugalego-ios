//
//  ConjugateViewController.h
//  ConxuGalego
//
//  Created by Xurxo Méndez Pérez on 06/01/12.
//  Copyright (c) 2012 ninguna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parser.h"

@interface ConjugateViewController : UIViewController <ParserDelegate> {
    NSString *verb;
    NSString *verbToConjugate;
    NSArray *verbalTimes;
}

@property (nonatomic, retain) NSString* verb;
@property (nonatomic, retain) NSString* verbToConjugate;
@property (nonatomic, retain) NSArray* verbalTimes;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *defineButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *translateButton;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomToolbar;

- (IBAction)grabURLInBackground:(id)sender;
- (IBAction)define:(id)sender;
- (IBAction)translate:(id)sender;

@end
