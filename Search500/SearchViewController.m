//
//  SearchViewController.m
//  Search500
//
//  Created by offline on 06/11/2015.
//  Copyright © 2015 moon. All rights reserved.
//
//#define TARGET_OS_IOS
#import "SingleImageViewController.h"
#import "SearchViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "SearchOperation.h"

@interface SearchViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) IBOutlet UICollectionView *resultsCollectionView;
@property (strong, nonatomic) NSMutableArray *searchResults;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *searchingSpinner;
@property (strong, nonatomic) NSOperationQueue *searchQueue;

@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.searchResults = [NSMutableArray array];
    
    self.searchQueue = [[NSOperationQueue alloc] init];
    
    [self.searchTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.searchTextField resignFirstResponder];
    NSIndexPath *indexPath = [[self.resultsCollectionView indexPathsForSelectedItems] firstObject];
    
    SingleImageViewController *imageViewController = segue.destinationViewController;
    
    imageViewController.image = self.searchResults[indexPath.row];
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.searchResults count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageThumbnailCollectionViewCell *cell = [self.resultsCollectionView dequeueReusableCellWithReuseIdentifier:@"ImageThumbnailCell" forIndexPath:indexPath];
    
    Image *image = self.searchResults[indexPath.row];
    
    NSURL *thumbnailUrl = image.thumbnailUrl;
    [cell.thumbnailImageView setImageWithURL:thumbnailUrl placeholderImage:[UIImage imageNamed: @"default-placeholder"]];
    
    return cell;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchTextField resignFirstResponder];

    [self doSearch:self.searchTextField.text isNewSearch:YES];
    
    return YES;
}

-(void)doSearch:(NSString *)term isNewSearch:(BOOL)isNewSearch
{
    [self.searchingSpinner startAnimating];
    
    static BOOL isLoading = NO;
    static NSInteger pageNumber = 0;

    
    if(isLoading) {
        return;
    }
    
    isLoading = YES;
    
    if(isNewSearch) {
        pageNumber = 1;
    } else {
        ++pageNumber;
    }
    
    [Image searchForImagesWithTerms:term
                    andSuccessBlock:^(AFHTTPRequestOperation *operation, NSDictionary *data){
                        if(isNewSearch) {
                            [self.searchResults removeAllObjects];
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.resultsCollectionView reloadData];
                            }];
                        }
                        
                        for(NSDictionary *imageData in data[@"photos"]) {
                            [self.searchResults addObject: [[Image alloc] initWithDictionary: imageData]];
                        }
                        
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            [self.resultsCollectionView reloadData];
                            [self.searchingSpinner stopAnimating];
                        }];
                        
                        isLoading = NO;
                        
                    }
                    andFailureBlock:^(NSError *error) {
                        --pageNumber;
                        isLoading = NO;
                        [self.searchingSpinner stopAnimating];
                    }
                      andPageNumber:pageNumber];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.searchTextField isFirstResponder]) {
        [self.searchTextField resignFirstResponder];
    }
    
    CGFloat maxScrollingPosition = scrollView.contentSize.height - 2*scrollView.bounds.size.height;
    
    if (scrollView.contentOffset.y > maxScrollingPosition) {
        [self doSearch: self.searchTextField.text isNewSearch:NO];
    }
}

- (IBAction)searchDIdChange:(UITextField *)sender
{
    NSLog(@"Action: %@", sender.text);
    
    SearchOperation *op = [[SearchOperation alloc] init];
    op.searchTerm = sender.text;
    
    op.runSearch = ^(NSString *searchTerm) {
        [self doSearch: searchTerm isNewSearch:YES];
    };
    [self.searchQueue cancelAllOperations];
    //self.searchQueue = [[NSOperationQueue alloc] init];
    [self.searchQueue addOperation:op];
}



@end
