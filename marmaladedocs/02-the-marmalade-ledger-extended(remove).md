
 # The Marmalade Ledger Explained

 ## What is the Marmalade Ledger?

What is it and what is it used for. Think of a ledger as your personal bank statement, only in this case its not just for you, it's for everybody participating in the system. It's this big ol' record that keeps track of the things within marmalade that happen. You can look at the ledger as the heart of marmalade, the place where most of the action happens.

In the context of NFTs, the Marmalade Ledger plays a crucial role in managing the lifecycle of these unique digital assets. It provides the underlying infrastructure and framework necessary to create, transfer, and track ownership of NFTs within the Marmalade ecosystem. It acts as a decentralised, transparent, and immutable ledger of ownership, ensuring that every change in ownership, creation, or transfer of an NFT is securely and accurately recorded.

The ledger consists of several components. It defines tables and schemas to organise data related to accounts and tokens. It includes capabilities, which are functions that perform specific actions and enforce certain conditions. By leveraging the capabilities, tables, and schemas defined within the ledger, developers and users can interact with NFTs in a standardised and reliable manner. The ledger enforces policies and guards to ensure compliance with predefined rules and constraints, promoting secure and trustworthy NFT transactions.

## Diving Deeper into the Marmalade Ledger

When delving further into the ledger's workings, we find each function and capability playing a unique role in its operation and management.

### Capabilities

First, we've got the `TRANSFER` and `XTRANSFER` capabilities. You can think of these like your online banking app's transfer feature. `TRANSFER` lets you move a certain amount of a token from a sender to a receiver on the same chain. It's like sending money from your account to a friend's account in the same bank.

On the other hand, `XTRANSFER` is like an international transfer. You're still sending tokens from one person to another, but now it's across different chains - like sending money from your bank account to a friend's account in a different bank or country.

We also have the `SUPPLY`, `TOKEN`, `ACCOUNT_GUARD`, and `RECONCILE` capabilities. They are about updates and accountability. You can think of them like notifications. They're triggered when there's a change in the supply of a token, when a new token is created, when an account's access guard is updated, or when balances need to be reconciled.

Within the ledger there are somewhat more special capabilities these are:

`ADJUST_POLICY` which is a capability that allows a module to change the policies associated with a token, whether that's adding new policies or getting rid of existing ones.

`ROTATE` which is a capability that allows you to change the guard of an account. Think of it like updating your password - you need to prove you're the account owner before you can change the password. In the same way, before you can use `ROTATE`, you need to validate against the existing guard of the account.

The `DEBIT` and `CREDIT` capabilities are similar to the debit and credit functions we will discuss in the next part, but they're capabilities. When a module has the `DEBIT` or `CREDIT` capability, it means it has the authority to use the debit or credit functions.

`UPDATE_SUPPLY` Allows a module to adjust the total amount of a particular token that's in circulation.

The `MINT` and `BURN` capabilities work in a similar way. If a module has the `MINT` capability, it's got the power to create new tokens, like a mint printing new money. On the flip side, a module with the `BURN` capability can remove tokens from circulation, a bit like a government burning old or counterfeit money.

The `LEDGER` capability acts as a security guard for the ledger, and ensures that any policies being executed have the correct permissions to carry out their operation.

### Marketplace related capabilities

There are also capabilities that are specifically related to the marketplace.

Let's start with `SALE`. You can think of this capability as the act of listing an item for sale, say, in an online marketplace. When you list your item, you'd provide details like the item ID, how much you want to sell, when the listing expires (`timeout`), and a unique `sale-id` for the transaction. This `SALE` capability is like your agreement with the marketplace that all these details are correct and you authorise the sale. The capability makes sure the amount is positive (you can't sell negative items, right?), and then leverages two other capabilities: `LEDGER` for permission to execute ledger operations and `OFFER` which is the process of making the token available for purchase.

The `OFFER` capability, in turn, is similar to `SALE` but it's focused on ensuring that the seller is authorised to make an offer of the token. It also uses the `DEBIT` and `CREDIT` capabilities, which are like saying "I have the item to sell (debit from my account)" and "Move this item to the market (credit to the sale account)" respectively.

Now, if you change your mind and decide not to sell the item, that's where the `WITHDRAW` capability comes in. It's like taking your item off the market. It only works if the offer is no longer active (i.e., the sale hasn't happened or the listing hasn't expired), and it performs ledger operations to debit the item from the sale account and credit it back to you.

On the flip side, we have the `BUY` capability. It's like the checkout process when you buy an item online. The buyer provides their details, the item they want to buy, and how much they're buying. The capability checks that the sale is still active, then uses the `LEDGER` capability for permission to perform ledger operations and `SALE_PRIVATE` to mark the transaction as being processed. It also debits the item from the sale account and credits it to the buyer.

### Core functions

The `create-token` and `create-account` functions are like the registration desk. They allow you to make new tokens with their own ID, precision, and policies, or to open new accounts.

`create-token-id`: It's a function that creates a unique identifier for a token.

`mint` and `burn` are how new tokens are made and how they are destroyed. It's like when a government prints new money or pulls old, damaged money out of circulation.

The `offer`, `withdraw`, and `buy` functions are the marketplace of the system. `offer` allows a seller to escrow an amount of a token for sale. `withdraw` lets the seller withdraw this offer, and `buy` lets a buyer complete the purchase.

`transfer` and `transfer-create` are similar to the `TRANSFER` and `XTRANSFER` capabilities we talked about earlier, but they're functions. They allow you to transfer tokens between accounts, and even create a new account if the receiving account doesn't exist.

`get-balance` and `details` are like checking your bank balance and account details. They let you see how much of a token you have in your account, and other details about your account.

`rotate` is a security function, it allows you to change the guard for an account, validating against the existing guard.

`total-supply` and `get-uri` are like checking the stats of a token. They give you the total amount of a token available, and the URI (kind of like a website address pointing to the metadata for the token) for a token.

`adjust-policy`: This function lets you tweak the rules for a specific token. Kind of like changing the house rules for a game, it updates the policy of a token after it's been created.

And there you have it! That's the core of this system where each function and capability plays a specific role in managing and operating the ledger.


### Internal / Helper functions
Next to the core function of the ledger there are also internal / helper functions.
It's not that they aren't important, but rather then the core functions these functions are used by the core functions / ledger.

`precision` and `enforce-unit` detail the max precision and enforce that transactions meet this precision. If a token has a precision of 2, you can't try to transfer 0.001 of it.

`debit` and `credit`. These are pretty straightforward. Imagine you're at a shop and you're buying a cool new t-shirt. The `debit` function is like when the shopkeeper takes money from your account, while `credit` is like when they add money to theirs. But instead of money, we're working with tokens here.

`get-token-info`: It’s a function that provides information about a token.

`TRANSFER-mgr`, It's like a supervisor for these transfers, making sure the amount being transferred is legit and within limits.

`account-guard`: It's a function that returns the access control details for an account. 

`ledger-guard`: Similar to `account-guard`, it gets the guard details for the entire ledger.

`enforce-token-reserved`: This function enforces a reserve policy on a token. 

`truncate`: This function is used to adjust the decimal places of a token's quantity to the appropriate precision.

`enforce-transfer-policy`: It enforces the rules associated with transferring a token.

`credit-account`: It’s a function that increases the balance of an account with a specific token. Like depositing money into your account.

`update-supply`: This function adjusts the total supply of a token. It's like a central bank deciding to print more money.

`key`: It’s a function that returns the key of an account.

`sale-active`: It checks whether a sale offer is still valid. 

`sale-account`: This function gets the account for a particular sale. 

`transfer-crosschain`: It lets you transfer a token from an account on one chain to an account on another. *currently not supported

---
So, after going down the rabbit hole and navigating our way through this web of token transfers, account creations, policy adjustments, and all those other functions, we hope you've got a sense of what the marmalade ledger is all about.

To sum up, the Marmalade Ledger is a sophisticated system that records and manages transactions and operation within the Marmalade platform. It ensures every transaction is accurate, every policy is enforced, and every account is up-to-date. 
We hope you've got a sense of what the marmalade ledger is all about.

Whether you're a code whizz or a crypto newbie, we hope this journey into the workings of this ledger has helped to unravel some of the mysteries behind it. You could be buying a new digital art piece today or selling some tomorrow.
 
**Marmalade makes it possible.**