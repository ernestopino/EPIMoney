//
//  EPIMoney.h
//
//  Created by Ernesto Pino on 09/03/15.
//  Copyright (c) 2015 EPINOM | Creative Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPIMoney : NSObject

#pragma mark - Properties

/**
 *  Currency locale (es_ES, en_US, en_GB, etc.)
 */
@property (nonatomic, strong, readonly) NSLocale *currencyLocale;

/**
 *  Currency code (EUR, DOL, GBP, CNY, etc.)
 *
 *  ISO-4217
 *  http://es.wikipedia.org/wiki/ISO_4217)
 *  http://www.iso.org/iso/home/standards/currency_codes.htm
 */
@property (nonatomic, strong, readonly) NSString *currencyCode;

/**
 *  Currency symbol (€, $, £, ¥, etc.)
 */
@property (nonatomic, strong, readonly) NSString *currencySymbol;

/**
 *  Sign for this value, positive or negative (-/+), only the sign symbol (-1200,00€ -> - / 950,75€ -> +)
 */
@property (nonatomic, strong, readonly) NSString *currencySign;

/**
 *  Amount in decimal number format (-1200.00, 950.75)
 */
@property (nonatomic, strong) NSDecimalNumber *amount;

/**
 *  Integer part of the amount (-1200.00, 950.00)
 */
@property (nonatomic, assign, readonly) NSDecimalNumber *integerPart;

/**
 *  Decimal part of the amoun (0.00, 0.75)
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *decimalPart;

/**
 *  Number of digits after the decimal separator
 */
@property (nonatomic, assign, readonly) NSInteger decimalAccuracy;

/**
 *  Thousands separator symbol
 */
@property (nonatomic, strong, readonly) NSString *thousandsSeparator;

/**
 *  Decimals separator symbol
 */
@property (nonatomic, strong, readonly) NSString *decimalsSeparator;

/**
 *  Separator between amount value and symbol/code string
 */
@property (nonatomic, strong, readonly) NSString *betweenSeparator;

#pragma mark - Class methods

+ (NSNumberFormatter *)currencyFormatter;
+ (NSNumberFormatter *)numberFormatter;
+ (NSNumber *)zeroAmount;
+ (NSString *)zeroAmountWithCurrencyCode;
+ (NSString *)zeroAmountWithCurrencySymbol;

#pragma mark - Public methods

- (instancetype)initWithDecimalNumber:(NSDecimalNumber *)amount;
- (instancetype)initWithStringNumber:(NSString *)amount;
- (NSString *)stringValueWithCurrencyCode;
- (NSString *)stringValueWithCurrencySymbol;
- (NSNumber *)absoluteValue;

@end
