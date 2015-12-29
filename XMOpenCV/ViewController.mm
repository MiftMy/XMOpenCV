//
//  ViewController.m
//  XMOpenCV
//
//  Created by mifit on 15/12/29.
//  Copyright © 2015年 mifit. All rights reserved.
//


#import "ViewController.h"

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
// 图片转换
#import <opencv2/imgcodecs/ios.h>
#endif

@interface ViewController (){
    cv::Mat cvImage; 
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)change:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)change:(id)sender {
    UIImage *image = self.imageView.image;
    // Convert UIImage * to cv::Mat
    UIImageToMat(image, cvImage);
    
    cv::Mat gray;
    // Convert the image to grayscale;
    cv::cvtColor(cvImage, gray, CV_RGBA2GRAY);
    // Apply Gaussian filter to remove small edges
    cv::GaussianBlur(gray, gray, cv::Size(5,5), 1.2,1.2);
    // Calculate edges with Canny
    cv::Mat edges;
    cv::Canny(gray, edges, 0, 60);
    // Fill image with white color
    cvImage.setTo(cv::Scalar::all(255));
    // Change color on edges
    cvImage.setTo(cv::Scalar(0,128,255,255),edges);
    // Convert cv::Mat to UIImage* and show the resulting image
    self.imageView.image = MatToUIImage(cvImage);
}
@end
