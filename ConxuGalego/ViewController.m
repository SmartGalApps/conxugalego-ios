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

@synthesize verbTextField;
@synthesize searchButton;
@synthesize scrollView;
@synthesize logoPortada;
@synthesize label;
@synthesize verbalTimes;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
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
    [self setVerbalTimes:nil];
    [self setLogoPortada:nil];
    [self setLabel:nil];
    [super viewDidUnload];
}

-(void) setLandscape
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        logoPortada.frame = CGRectMake(165, 54, 150, 150);
        label.frame = CGRectMake(20, 206, 234, 21);
        verbTextField.frame = CGRectMake(20, 228, 320, 31);
        searchButton.frame = CGRectMake(348, 225, 112, 37);
    }
    else
    {
        logoPortada.frame = CGRectMake(185, 330, 300, 300);
        label.frame = CGRectMake(536, 444, 300, 21);
        verbTextField.frame = CGRectMake(536, 481, 220, 31);
        searchButton.frame = CGRectMake(771, 478, 75, 37);
    }
}

-(void) setPortrait
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        logoPortada.frame = CGRectMake(85, 67, 150, 150);
        label.frame = CGRectMake(20, 221, 280, 21);
        verbTextField.frame = CGRectMake(20, 244, 206, 31);
        searchButton.frame = CGRectMake(234, 241, 75, 37);
    }
    else
    {
        logoPortada.frame = CGRectMake(234, 20, 300, 300);
        label.frame = CGRectMake(224, 405, 300, 21);
        verbTextField.frame = CGRectMake(224, 442, 220, 31);
        searchButton.frame = CGRectMake(459, 439, 75, 37);
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
 * Realiza la petición al servidor
 */
- (IBAction)grabURLInBackground:(id)sender
{
    [Helper showAlert];
    NSURL *url = [Helper getUrl:self.verbTextField.text];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}

/*
 * Realiza la búsqueda. Si el campo está vacío no hace nada. Si tiene espacios en blanco muestra un alertView
 */
-(void)search {
    if ([self.verbTextField.text rangeOfString:@" "].location != NSNotFound) {
        UIAlertView *info = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"O termo non pode ter espazos en blanco", nil) 
                                                       message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles: nil];
        [info show];
        return;
    }
    if ([self.verbTextField.text length] > 0) {
        [self grabURLInBackground:self];
    }
}

/*
 * Si la longitud de lo introducido es 0, desactiva el botón.
 * También es aquí donde se comprueba la longitud máxima para permitir seguir escribiendo o no
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    [self.searchButton setEnabled:newLength > 0];
    
    return (newLength > 16) ? NO : YES;
}

/*
 * Para ir a la pantalla del conjugador
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"Conjugate"])
	{
        [Helper dismissAlert];
		ConjugateViewController *conjugateViewController = 
        segue.destinationViewController;
        conjugateViewController.verbalTimes = self.verbalTimes;
        conjugateViewController.verbFromMainViewController = self.verbTextField.text;
	}
}

/*
 * Acción del botón de buscar
 */
- (IBAction)searchButton:(id)sender {
    [self search];
}

/*
 * Método delegate cuando hubo éxito (en la petición, falta parsear)
 */
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [Helper dismissAlert];
    // Use when fetching text data
    NSString *responseString = [request responseString];
    Parser *parser = [[Parser alloc] init];
    parser.delegate = self;
    [parser parse:responseString];
}

/*
 * Si la conexión falla, sale
 */
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [Helper dismissAlert];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ParserDelegate

/*
 * Se obtuvo una conjugación con éxito
 */
-(void) doOnSuccess:(NSArray *)conjugations
{
    self.verbalTimes = conjugations;
    [self performSegueWithIdentifier:@"Conjugate" sender:self];
}

/*
 * No tiene forma de verbo (esto no implica que exista o que no)
 */
-(void) doOnNotFound
{
    NSMutableString *message = [[NSMutableString alloc] initWithFormat:NSLocalizedString(@"O termo \'%@\' non ten forma de verbo", nil), self.verbTextField.text];
    UIAlertView *info = [[UIAlertView alloc] 
                         initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles: nil];
    [info show];
}

#pragma mark - end

/*
 * Estos métodos son para manejar el teclado virtual: ocultarlo tras buscar, hacer scroll cuando sale, etc.
 */
// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGFloat height;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        height = kbSize.width > kbSize.height ? kbSize.height : kbSize.width - 40;
    }
    else
    {
        height = kbSize.width > kbSize.height ? kbSize.height : kbSize.width + 100;
    }
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= height;
    if (!CGRectContainsPoint(aRect, self.verbTextField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.verbTextField.frame.origin.y-height);
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

/*
 * Para activar el ENTER del teclado virtual como botón de búsqueda
 */
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.verbTextField) {
        [theTextField resignFirstResponder];
    }
    [self search];
    return YES;
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        [self setPortrait];
    }
    else
    {
        [self setLandscape];
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
}

@end