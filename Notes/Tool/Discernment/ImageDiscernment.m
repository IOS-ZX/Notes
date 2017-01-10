//
//  ImageDiscernment.m
//  Notes
//
//  Created by rimi on 2017/1/10.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "ImageDiscernment.h"

@implementation ImageDiscernment

- (void)getStringForImage:(UIImage *)image result:(ImageToString)result{
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    NSLog(@"start");
    G8RecognitionOperation *read = [[G8RecognitionOperation alloc]initWithLanguage:@"eng+chi_sim"];
    read.delegate = self;
    read.tesseract.engineMode = G8OCREngineModeTesseractOnly;
    read.tesseract.pageSegmentationMode = G8PageSegmentationModeAutoOnly;
    read.tesseract.image = image;
    read.recognitionCompleteBlock = ^(G8Tesseract* tesseract){
        NSLog(@"text:%@",tesseract.recognizedText);
        if (result) {
            result(tesseract.recognizedText);
        }
    };
    [operationQueue addOperation:read];
}

- (void)progressImageRecognitionForTesseract:(G8Tesseract *)tesseract{
    NSLog(@"progress: %lu", (unsigned long)tesseract.progress);
}

- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    return NO;
}

@end
