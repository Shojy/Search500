//
//  SingleImageViewController.m
//  Search500
//
//  Created by offline on 06/11/2015.
//  Copyright © 2015 moon. All rights reserved.
//

#import "SingleImageViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

@interface SingleImageViewController ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SingleImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.image.title;
    self.titleLabel.text = self.image.title;
    self.authorLabel.text = self.image.author;
    [self.imageView setImageWithURL:self.image.thumbnailUrl placeholderImage:[UIImage imageNamed:@"default-placeholder"]];
    [self.image getDetailsWithSuccessBlock:^(AFHTTPRequestOperation *operation, NSDictionary *data){
        
        self.image.imageUrl = [NSURL URLWithString:data[@"photo"][@"image_url"]];
        [self.imageView setImageWithURL:self.image.imageUrl];
        NSLog(@"%@", self.image.imageUrl);
        
    }
                           andFailureBlock:nil];
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
