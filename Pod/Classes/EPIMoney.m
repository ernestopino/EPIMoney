//
//  EPIMoney.m
//
//  Created by Ernesto Pino on 09/03/15.
//  Copyright (c) 2015 EPINOM | Creative Technology. All rights reserved.
//

#import "EPIMoney.h"

#pragma mark - Default values

#define kGroupingSeparator      @"."
#define kDecimalSeparator       @","
#define kUsesGroupingSeparator  YES
#define kGroupingSize           3
#define kDecimalAccuracy        2
#define kBetweenSeparator       @" "

@interface EPIMoney ()

@property (nonatomic, strong) NSNumberFormatter *numberFormatter;

@end

@implementation EPIMoney

#pragma mark - Class methods

+ (NSNumberFormatter *)currencyFormatter
{
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setLocale:[NSLocale currentLocale]];
    [currencyFormatter setMaximumFractionDigits:kDecimalAccuracy];
    [currencyFormatter setMinimumFractionDigits:kDecimalAccuracy];
    [currencyFormatter setGroupingSeparator:kGroupingSeparator];
    [currencyFormatter setGroupingSize:kGroupingSize];
    [currencyFormatter setDecimalSeparator:kDecimalSeparator];
    [currencyFormatter setAlwaysShowsDecimalSeparator:kUsesGroupingSeparator];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    return currencyFormatter;
}

+ (NSNumberFormatter *)numberFormatter
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:kDecimalAccuracy];
    [numberFormatter setMinimumFractionDigits:kDecimalAccuracy];
    [numberFormatter setDecimalSeparator:kDecimalSeparator];
    
    return numberFormatter;
}

+ (NSNumber *)zeroAmount
{
    // Return number with format
    return [NSNumber numberWithFloat:0.00];
}

+ (NSString *)zeroAmountWithCurrencyCode
{
    // TODO: Pendiente de revisar lo que devuelve [EPIMoney zeroAmount]
    
    // Get zero amount
    NSNumber *zeroAmount = [EPIMoney zeroAmount];
    
    // Create number formatter for extract only the value
    NSNumberFormatter *numberFormatter = [EPIMoney numberFormatter];
    
    // Get amount string
    NSString *zeroAmountString = [numberFormatter stringFromNumber:zeroAmount];
    
    // Return string concatenated with currency code
    NSString *zeroAmountWithCodeString = [NSString stringWithFormat:@"%@%@%@", zeroAmountString, kBetweenSeparator, [[EPIMoney currencyFormatter] currencyCode]];
    return zeroAmountWithCodeString;
}

+ (NSString *)zeroAmountWithCurrencySymbol
{
    // Get zero amount
    NSNumber *zeroAmount = [EPIMoney zeroAmount];
    
    // Return value with symbol
    return [[EPIMoney currencyFormatter] stringFromNumber:zeroAmount];
}

#pragma mark - Public methods

- (instancetype)initWithDecimalNumber:(NSDecimalNumber *)amount
{
    self = [super init];
    if (self)
    {
        // Initialize formatter
        _numberFormatter = [EPIMoney currencyFormatter];
        
        // Default locale
        _currencyLocale = [NSLocale currentLocale];
        
        // Default code
        _currencyCode = [_numberFormatter currencyCode];
        
        // Default symbol
        _currencySymbol = [_numberFormatter currencySymbol];
        
        // Sign of the amount
        _currencySign = (_amount < 0) ? @"-" : @"+";
        
        // Initialize amount
        _amount = amount ? amount : [NSDecimalNumber decimalNumberWithString:@"0.00"];
        
        // Break amount in integer part and decimal part
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        _integerPart = [amount decimalNumberByRoundingAccordingToBehavior:behavior];
        _decimalPart = [amount decimalNumberBySubtracting:_integerPart];
        
        // Default decimal accuracy
        _decimalAccuracy = kDecimalAccuracy;
        
        // Default thousands separator
        _thousandsSeparator = kGroupingSeparator;
        
        // Default decimal separator
        _decimalsSeparator = kDecimalSeparator;
        
        // Default between separator
        _betweenSeparator = kBetweenSeparator;
    }
    
    return self;
}

- (instancetype)initWithStringNumber:(NSString *)amount
{
    // Replacing decimal separator (,) for a dot, according to NSNumber specification.
    amount = [amount stringByReplacingOccurrencesOfString:@"," withString:@"."];
    
    // Return self
    return [self initWithDecimalNumber:[NSDecimalNumber decimalNumberWithString:amount]];
}

- (NSString *)stringValueWithCurrencyCode
{
    // Get zero amount
    NSNumber *amount = [NSNumber numberWithDouble:[self.amount doubleValue]];
    
    // Create number formatter for extract only the value
    NSNumberFormatter *numberFormatter = [EPIMoney numberFormatter];
    
    // Get amount string
    NSString *amountString = [numberFormatter stringFromNumber:amount];
    
    // Return string concatenated with currency code
    return [NSString stringWithFormat:@"%@%@%@", amountString, self.betweenSeparator ? self.betweenSeparator : kBetweenSeparator, [[EPIMoney currencyFormatter] currencyCode]];
}


- (NSString *)stringValueWithCurrencySymbol
{
    // Check if we have amount
    if (self.amount == nil)
        return nil;
    
    // Get zero amount
    NSNumber *amount = [NSNumber numberWithDouble:[self.amount doubleValue]];
    
    // Create number formatter for extract only the value
    NSNumberFormatter *numberFormatter = [EPIMoney numberFormatter];
    
    // Get amount string
    NSString *amountString = [numberFormatter stringFromNumber:amount];
    
    // Return string concatenated with currency code
    return [NSString stringWithFormat:@"%@%@%@", amountString, self.betweenSeparator ? self.betweenSeparator : kBetweenSeparator, [[EPIMoney currencyFormatter] currencySymbol]];
}


- (NSNumber *)absoluteValue
{
    return (self.amount) ? [NSNumber numberWithDouble:fabs([self.amount doubleValue])] : nil;
}

@end
