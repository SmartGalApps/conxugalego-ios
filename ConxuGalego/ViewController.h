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
