#import "AdyenDropIn.h"


@implementation AdyenDropIn

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(pay:(NSString *)publicKey paymentMethods:(NSDictionary *)numberArgument callback:(RCTResponseSenderBlock)callback)
{
  // TODO: Implement some actually useful functionality
  //callback(@[[NSString stringWithFormat: @"numberArgument: %@ stringArgument: %@", numberArgument, stringArgument]]);
  let paymentMethods = try JSONDecoder().decode(PaymentMethods.self, from: paymentMethodsResponse)
  let configuration = DropInComponent.PaymentMethodsConfiguration()
  configuration.card.publicKey = publicKey

  let dropInComponent = DropInComponent(paymentMethods: paymentMethods,
  paymentMethodsConfiguration: configuration)
  dropInComponent.delegate = self
  dropInComponent.environment = .test
  // When you're ready to go live, change this to .live
  // or to other environment values described in https://adyen.github.io/adyen-ios/Docs/Structs/Environment.html
  dropInComponent.payment = Payment(amount: Payment.Amount(value: 1000,
                                                      currencyCode: "EUR"))
  // Optional. In this example, the Pay button will display 10 EUR.
  present(dropInComponent.viewController, animated: true)
}

@end
