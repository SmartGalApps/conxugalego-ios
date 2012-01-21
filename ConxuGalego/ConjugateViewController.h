//
//  ConjugateViewController.h
//  ConxuGalego
//
//  Created by Xurxo Méndez Pérez on 06/01/12.
//  Copyright (c) 2012 ninguna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parser.h"

@interface ConjugateViewController : UITableViewController <ParserDelegate> {
    NSString *verbToConjugate;
    NSArray *verbalTimes;
}

@property (nonatomic, retain) NSString* verbToConjugate;
@property (nonatomic, retain) NSArray* verbalTimes;

- (IBAction)grabURLInBackground:(id)sender;

@end
