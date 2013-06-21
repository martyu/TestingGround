//
//  HeartView.m
//  Test
//
//  Created by Marty on 6/21/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "HeartView.h"

// The parametric equations describing the shape of the heart.
#define PARAMETRIC_EQUATION_X(x) powf(sinf(x), 3)
#define PARAMETRIC_EQUATION_Y(x) (13*cos(x) - 5.0*cos(2.0*x) - 2.0*cos(3.0*x) - cos(4.0*x))/15.0

#define RATIO_STARTING_HEART_TOP_OFFSET_TO_VIEWS_HEIGHT 0.084

@interface HeartView ()

// The width of the bounding rect for the heart.
@property(nonatomic)CGFloat scaleX;
@property(nonatomic)CGFloat scaleY;

@end

// Represents the radius of the heart in the positive (yMax; up) and negative (yMin; down) directions from the origin.
struct extremeYValues {
	CGFloat yMax;
	CGFloat yMin;
};

@implementation HeartView

- (void)drawRect:(CGRect)rect
{
	CGPoint center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);

	// The points to draw are stored here while they're being calculated, then they're drawn.
	// This is so we can calulate how much the heart
	NSMutableArray *heartPathPointsArr = [[NSMutableArray alloc] init];

	UIBezierPath *heartPath = [UIBezierPath bezierPath];
	heartPath.lineWidth = 0.0;
	heartPath.lineJoinStyle = kCGLineJoinRound;
	heartPath.lineCapStyle = kCGLineCapRound;

	CGContextRef context = UIGraphicsGetCurrentContext();

	// Center drawing; adjust coordinates for iOS; make up for heart equation not being centered.
	CGContextTranslateCTM(context, center.x, center.y - [self yOffset]);
	CGContextScaleCTM(context, 1.0, -1.0);

	// To keep track of the max and min y-value so we can shift the heart up to center it.
	struct extremeYValues maxMinY = {-MAXFLOAT, MAXFLOAT};

	// The parameter for the parametric equation
	float t = 0.0;

	// Set the starting point of the shape.
	[heartPath moveToPoint:[self pointForT:t]];

	// Draw the lines.
	CGPoint currentPoint;
	for (; t <= 2*M_PI; t += M_PI/self.scaleX) {
		currentPoint = [self pointForT:t];
		if (currentPoint.y > maxMinY.yMax) {
			maxMinY.yMax = currentPoint.y;
		}
		if (currentPoint.y < maxMinY.yMin) {
			maxMinY.yMin = currentPoint.y;
		}
		[heartPath addLineToPoint:currentPoint];
	}

	[heartPath fill];
}

- (CGPoint)pointForT:(float)t
{
	CGFloat x = PARAMETRIC_EQUATION_X(t);
	CGFloat y = PARAMETRIC_EQUATION_Y(t);
	CGPoint point = CGPointMake(x*self.scaleX, y*self.scaleY);
//	NSLog(@"point: %f, %f\n", point.x, point.y);
	return point;
}

- (CGFloat)scaleX
{
	return self.bounds.size.width/2.0;
}

- (CGFloat)scaleY
{
	return self.bounds.size.height/2.0;
}


- (float)yOffset
{
	return self.bounds.size.height * RATIO_STARTING_HEART_TOP_OFFSET_TO_VIEWS_HEIGHT;
}

@end
