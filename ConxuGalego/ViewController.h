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
    NSArray *verbalTimes;
}

@property (nonatomic, retain) NSArray* verbalTimes;

@property (weak, nonatomic) IBOutlet UITextField *verbTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *logoPortada;
@property (weak, nonatomic) IBOutlet UILabel *label;

- (IBAction)searchButton:(id)sender;

@end
