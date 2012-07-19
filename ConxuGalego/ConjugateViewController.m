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
//  ConjugateViewController.m
//  ConxuGalego
//
//  Created by Xurxo Méndez Pérez on 06/01/12.
//  Copyright (c) 2012 ninguna. All rights reserved.
//

#import "ConjugateViewController.h"
#import "ASIHTTPRequest.h"
#import "Parser.h"
#import "VerbalTime.h"
#import "VerbalTimeCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ConjugateViewController
@synthesize verbalTimes;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondo.png"]];
    self.tableView.backgroundView = backgroundImageView;
}

- (void)viewDidUnload
{
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.verbalTimes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VerbalTimeCell *cell = (VerbalTimeCell *)[tableView 
                                              dequeueReusableCellWithIdentifier:@"VerbalTimeCell"];
	VerbalTime *verbalTime = [self.verbalTimes objectAtIndex:indexPath.row];
    if ([verbalTime.name isEqualToString:@"PI"]) {
        cell.time.text = @"Presente de Indicativo";
    }
    else if ([verbalTime.name isEqualToString:@"EI"]) {
        cell.time.text = @"Pretérito Perfecto de Indicativo";
    }
    else if ([verbalTime.name isEqualToString:@"II"]) {
        cell.time.text = @"Pretérito Imperfecto de Indicativo";
    }
    else if ([verbalTime.name isEqualToString:@"MI"]) {
        cell.time.text = @"Pret. Pluscuamperfecto de Indicativo";
    }
    else if ([verbalTime.name isEqualToString:@"FI"]) {
        cell.time.text = @"Futuro de Indicativo";
    }
    else if ([verbalTime.name isEqualToString:@"TI"]) {
        cell.time.text = @"Condicional";
    }
    else if ([verbalTime.name isEqualToString:@"PS"]) {
        cell.time.text = @"Presente de Subxuntivo";
    }
    else if ([verbalTime.name isEqualToString:@"IS"]) {
        cell.time.text = @"Imperfecto de Subxuntivo";
    }
    else if ([verbalTime.name isEqualToString:@"FS"]) {
        cell.time.text = @"Futuro de Subxuntivo";
    }
    else if ([verbalTime.name isEqualToString:@"IP"]) {
        cell.time.text = @"Infinitivo Conxugado";
    }
    else if ([verbalTime.name isEqualToString:@"IA"]) {
        cell.time.text = @"Imperativo Afirmativo";
    }
    else if ([verbalTime.name isEqualToString:@"IN"]) {
        cell.time.text = @"Imperativo Negativo";
    }
    else if ([verbalTime.name isEqualToString:@"FN"]) {
        cell.time.text = @"Formas Nominais";
    }
    [cell.time.layer setCornerRadius:10.0f];
    [cell.time.layer setMasksToBounds:YES];
    
    if ([verbalTime.times count] == 6) {
        [cell.firstPersonLabel setHidden:FALSE];
        [cell.secondPersonLabel setHidden:FALSE];
        [cell.thirdPersonLabel setHidden:FALSE];
        [cell.firstPPersonLabel setHidden:FALSE];
        [cell.secondPPersonLabel setHidden:FALSE];
        [cell.thirdPPersonLabel setHidden:FALSE];
        [cell.firstPersonTime setHidden:FALSE];
        [cell.secondPersonTime setHidden:FALSE];
        [cell.thirdPersonTime setHidden:FALSE];
        [cell.firstPPersonTime setHidden:FALSE];
        [cell.secondPPersonTime setHidden:FALSE];
        [cell.thirdPPersonTime setHidden:FALSE];
        cell.firstPersonLabel.text = @"Eu";
        cell.secondPersonLabel.text = @"Ti";
        cell.thirdPersonLabel.text = @"El/ela";
        cell.firstPPersonLabel.text = @"Nós";
        cell.secondPPersonLabel.text = @"Vós";
        cell.thirdPPersonLabel.text = @"Eles";
        cell.firstPersonTime.text = [verbalTime.times objectAtIndex:0];
        cell.secondPersonTime.text = [verbalTime.times objectAtIndex:1];
        cell.thirdPersonTime.text = [verbalTime.times objectAtIndex:2];
        cell.firstPPersonTime.text = [verbalTime.times objectAtIndex:3];
        cell.secondPPersonTime.text = [verbalTime.times objectAtIndex:4];
        cell.thirdPPersonTime.text = [verbalTime.times objectAtIndex:5];
    }
    else if ([verbalTime.times count] == 5) {
        [cell.firstPersonLabel setHidden:FALSE];
        [cell.secondPersonLabel setHidden:FALSE];
        [cell.thirdPersonLabel setHidden:FALSE];
        [cell.firstPPersonLabel setHidden:FALSE];
        [cell.secondPPersonLabel setHidden:FALSE];
        [cell.thirdPPersonLabel setHidden:TRUE];
        [cell.firstPersonTime setHidden:FALSE];
        [cell.secondPersonTime setHidden:FALSE];
        [cell.thirdPersonTime setHidden:FALSE];
        [cell.firstPPersonTime setHidden:FALSE];
        [cell.secondPPersonTime setHidden:FALSE];
        [cell.thirdPPersonTime setHidden:TRUE];
        cell.firstPersonLabel.text = @"Ti";
        cell.secondPersonLabel.text = @"Vostede";
        cell.thirdPersonLabel.text = @"Nós";
        cell.firstPPersonLabel.text = @"Vós";
        cell.secondPPersonLabel.text = @"Vostedes";
        cell.firstPersonTime.text = [verbalTime.times objectAtIndex:0];
        cell.secondPersonTime.text = [verbalTime.times objectAtIndex:1];
        cell.thirdPersonTime.text = [verbalTime.times objectAtIndex:2];
        cell.firstPPersonTime.text = [verbalTime.times objectAtIndex:3];
        cell.secondPPersonTime.text = [verbalTime.times objectAtIndex:4];
        
        if ([verbalTime.name isEqualToString:@"IN"]) {
            cell.firstPersonTime.text = [[NSString alloc] initWithFormat:@"non %@", [verbalTime.times objectAtIndex:0]];
            cell.secondPersonTime.text = [[NSString alloc] initWithFormat:@"non %@", [verbalTime.times objectAtIndex:1]];
            cell.thirdPersonTime.text = [[NSString alloc] initWithFormat:@"non %@", [verbalTime.times objectAtIndex:2]];
            cell.firstPPersonTime.text = [[NSString alloc] initWithFormat:@"non %@", [verbalTime.times objectAtIndex:3]];
            cell.secondPPersonTime.text = [[NSString alloc] initWithFormat:@"non %@", [verbalTime.times objectAtIndex:4]];
        }
    }
    else {
        [cell.firstPersonLabel setHidden:FALSE];
        [cell.secondPersonLabel setHidden:FALSE];
        [cell.thirdPersonLabel setHidden:FALSE];
        [cell.firstPPersonLabel setHidden:TRUE];
        [cell.secondPPersonLabel setHidden:TRUE];
        [cell.thirdPPersonLabel setHidden:TRUE];
        [cell.firstPersonTime setHidden:FALSE];
        [cell.secondPersonTime setHidden:FALSE];
        [cell.thirdPersonTime setHidden:FALSE];
        [cell.firstPPersonTime setHidden:TRUE];
        [cell.secondPPersonTime setHidden:TRUE];
        [cell.thirdPPersonTime setHidden:TRUE];
        cell.firstPersonLabel.text = @"Infinitivo";
        cell.secondPersonLabel.text = @"Xerundio";
        cell.thirdPersonLabel.text = @"Participio";
        
        cell.firstPersonTime.text = [verbalTime.times objectAtIndex:0];
        cell.secondPersonTime.text = [verbalTime.times objectAtIndex:1];
        cell.thirdPersonTime.text = [verbalTime.times objectAtIndex:2];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end