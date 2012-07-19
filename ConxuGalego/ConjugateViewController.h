/*
 * This file is part of ConxuGalego.

 * ConxuGalego is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.

 * ConxuGalego is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with ConxuGalego.  If not, see <http://www.gnu.org/licenses/>.
 */
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
    NSString *verbFromMainViewController;
    NSString *verbFromIntegration;
    NSArray *verbalTimes;
}

@property (nonatomic, retain) NSString* verbFromMainViewController;
@property (nonatomic, retain) NSString* verbFromIntegration;
@property (nonatomic, retain) NSArray* verbalTimes;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *defineButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *translateButton;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomToolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doesNotExistButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *space1;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *space2;

- (IBAction)grabURLInBackground:(id)sender;
- (IBAction)define:(id)sender;
- (IBAction)translate:(id)sender;
- (IBAction)showDoesNotExist:(id)sender;

@end
