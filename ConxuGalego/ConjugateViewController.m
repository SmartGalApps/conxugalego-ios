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
#import "Helper.h"
#import "Reachability.h"

@implementation ConjugateViewController

@synthesize verbalTimes;
@synthesize verbFromIntegration;
@synthesize verbFromMainViewController;

@synthesize tableView;
@synthesize defineButton;
@synthesize translateButton;
@synthesize bottomToolbar;
@synthesize doesNotExistButton;
@synthesize space1;
@synthesize space2;

- (void)viewDidUnload
{
    [self setVerbalTimes:nil];
    [self setVerbFromIntegration:nil];
    [self setVerbFromMainViewController:nil];
    [self setTableView:nil];
    [self setDefineButton:nil];
    [self setTranslateButton:nil];
    [self setBottomToolbar:nil];
    [self setDoesNotExistButton:nil];
    [self setSpace1:nil];
    [self setSpace2:nil];
    [super viewDidUnload];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) setLandscape
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        space1.width = 180;
        space2.width = 150;
    }
    else
    {
        space1.width = 300;
        space2.width = 300;
    }
}

-(void) setPortrait
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        space1.width = 105;
        space2.width = 65;
    }
    else
    {
        space1.width = 300;
        space2.width = 300;
    }
}

/*
 * Hace la petición al servidor. Esto pasa cuando se invoca con la integración
 */
- (IBAction)grabURLInBackground:(id)sender
{
    NSURL *url = [Helper getUrl:self.verbFromIntegration];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [Helper showAlert];
    [request startAsynchronous];
}

-(BOOL) isConnected
{
    Reachability *internetReachable = [Reachability reachabilityForInternetConnection];
    return [internetReachable isReachable];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Imagen de fondo
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondo.png"]];
    self.tableView.backgroundView = backgroundImageView;
    
    NSString * verbToCheck;
    
    // Si viene de la integración, hay que llamar al servidor y ocultar la toolbar de abajo
    if (self.verbFromIntegration != nil) {
        if ([self isConnected])
        {
            verbToCheck = self.verbFromIntegration;
            [self grabURLInBackground:self];
            [self.bottomToolbar setHidden:TRUE];
        }
        else
        {
            UIAlertView *info = [[UIAlertView alloc] 
                                 initWithTitle:nil message:NSLocalizedString(@"Necesitas conexión a internet.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles: nil];
            [info show];
        }
    }
    else
    {
        verbToCheck = self.verbFromMainViewController;
        [self.bottomToolbar setHidden:FALSE];
    }
    // Comprueba si existe en el Volga, y muestra la etiqueta si no
    if ([Helper existsVerb:verbToCheck])
    {
        [self.bottomToolbar setItems:[[NSArray alloc] initWithObjects:self.space1, self.defineButton,self.translateButton, self.space2, nil] animated:TRUE];
    }
    else
    {
        [self.bottomToolbar setItems:[[NSArray alloc] initWithObjects:self.space1, self.defineButton,self.translateButton,self.space2, self.doesNotExistButton, nil] animated:TRUE];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (UIDeviceOrientationIsLandscape(self.interfaceOrientation))
    {
        [self setLandscape];
    }
    else
    {
        [self setPortrait];        
    }
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
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        // Return YES for supported orientations
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    }
    else
    {
        // Return YES for supported orientations
        return YES;
    }
}

/*
 * Botón de integración
 */
- (IBAction)define:(id)sender {
    NSString *urlString = [[NSString alloc] initWithFormat:@"define://%@", self.verbFromMainViewController];
    NSURL *myURL = [NSURL URLWithString:urlString];
    if ([[UIApplication sharedApplication] canOpenURL:myURL])
    {
        [[UIApplication sharedApplication] openURL:myURL];
    }
    else
    {
        NSString *appURLString = [[NSString alloc] initWithFormat:@"http://itunes.com/apps/dicionariogalego"];
        NSURL *appURL = [NSURL URLWithString:appURLString];
        [[UIApplication sharedApplication] openURL:appURL];
    }
}

/*
 * Botón de integración
 */
- (IBAction)translate:(id)sender {
    NSString *urlString = [[NSString alloc] initWithFormat:@"traduce://%@", self.verbFromMainViewController];
    NSURL *myURL = [NSURL URLWithString:urlString];
    if ([[UIApplication sharedApplication] canOpenURL:myURL])
    {
        [[UIApplication sharedApplication] openURL:myURL];
    }
    else
    {
        NSString *appURLString = [[NSString alloc] initWithFormat:@"http://itunes.com/apps/tradutorgalego"];
        NSURL *appURL = [NSURL URLWithString:appURLString];
        [[UIApplication sharedApplication] openURL:appURL];
    }
}

- (IBAction)showDoesNotExist:(id)sender {
    UIAlertView *info = [[UIAlertView alloc] 
                         initWithTitle:nil message:@"O verbo non existe, pero de existir, conxugaríase así" delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles: nil];
    [info show];
}

/*
 * Si la petición tuvo éxito, parsear (viene de integración)
 */
- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    Parser *parser = [[Parser alloc] init];
    parser.delegate = self;
    [parser parse:responseString];
}

/*
 * Si la petición falló, sale
 */
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ParserDelegate

/*
 * El parseo obtuvo conjugaciones. Actualizar tabla
 */
-(void) doOnSuccess:(NSArray *)conjugations
{
    [Helper dismissAlert];
    self.verbalTimes = conjugations;
    [[self tableView] reloadData];
}

/*
 * No se encuentra. Mostrar alert
 */
-(void) doOnNotFound
{
    NSMutableString *message = [[NSMutableString alloc] initWithFormat:NSLocalizedString(@"O termo \'%@\' non ten forma de verbo", nil), self.verbFromIntegration];
    UIAlertView *info = [[UIAlertView alloc] 
                         initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles: nil];
    [Helper dismissAlert];
    [info show];
}

#pragma mark - end


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.verbalTimes count];
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VerbalTimeCell *cell = (VerbalTimeCell *)[theTableView 
                                              dequeueReusableCellWithIdentifier:@"VerbalTimeCell"];

    
    VerbalTime *verbalTime = [self.verbalTimes objectAtIndex:indexPath.row];

    // Nombre del tiempo verbal
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
    
    // Tiempo normal
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
        
        if (UIDeviceOrientationIsLandscape(self.interfaceOrientation))
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                cell.theView.frame = CGRectMake(100, 40, 280, 219);
            }
            else
            {
                cell.theView.frame = CGRectMake(380, 46, 280, 213);
            }
        }
        else
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                cell.theView.frame = CGRectMake(20, 40, 280, 219);
            }
            else
            {
                cell.theView.frame = CGRectMake(244, 46, 280, 213);
            }
        }
    }
    // Imperativos
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
        
        // Imperativo negativo
        if ([verbalTime.name isEqualToString:@"IN"]) {
            cell.firstPersonTime.text = [[NSString alloc] initWithFormat:@"non %@", [verbalTime.times objectAtIndex:0]];
            cell.secondPersonTime.text = [[NSString alloc] initWithFormat:@"non %@", [verbalTime.times objectAtIndex:1]];
            cell.thirdPersonTime.text = [[NSString alloc] initWithFormat:@"non %@", [verbalTime.times objectAtIndex:2]];
            cell.firstPPersonTime.text = [[NSString alloc] initWithFormat:@"non %@", [verbalTime.times objectAtIndex:3]];
            cell.secondPPersonTime.text = [[NSString alloc] initWithFormat:@"non %@", [verbalTime.times objectAtIndex:4]];
        }
        if (UIDeviceOrientationIsLandscape(self.interfaceOrientation))
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                cell.theView.frame = CGRectMake(100, 40, 280, 195);
            }
            else
            {
                cell.theView.frame = CGRectMake(380, 46, 280, 195);
            }
        }
        else
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                cell.theView.frame = CGRectMake(20, 40, 280, 195);
            }
            else
            {
                cell.theView.frame = CGRectMake(244, 46, 280, 195);
            }
        }
    }
    // Formas nominais
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
        if (UIDeviceOrientationIsLandscape(self.interfaceOrientation))
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                cell.theView.frame = CGRectMake(100, 40, 280, 150);
            }
            else
            {
                cell.theView.frame = CGRectMake(380, 46, 280, 150);
            }
        }
        else
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                cell.theView.frame = CGRectMake(20, 40, 280, 150);
            }
            else
            {
                cell.theView.frame = CGRectMake(244, 46, 280, 150);
            }
        }
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



-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if (UIDeviceOrientationIsLandscape(self.interfaceOrientation))
    {
        [self setLandscape];
    }
    else
    {
        [self setPortrait];
    }
    [self.tableView reloadData];
}

@end