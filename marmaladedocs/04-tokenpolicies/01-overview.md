# What are Concrete-Policies

A concrete policy in Marmalade V2 is a pre-built, ready-to-use implementation of commonly used features in token creation. It simplifies the process of adding functionality to NFTs and offers convenience for token creators. With concrete policies, Marmalade aims to provide a rich set of features that can be easily added to tokens without the need for extensive custom development.

When using a concrete policy, token creators can simply activate a policy by setting a boolean value to "true" or "false". The concrete policies available in Marmalade V2 are the Guard Policy, Collection Policy, Fungible Quote Policy, Non-fungible Policy, and Royalty Policy.

The Guard Policy ensures the initiation of a guard with each Marmalade activity. Guards are optional but recommended, as they help prevent unauthorised entities from minting tokens without permission. 

The Collection Policy allows the creation of collections with pre-defined token lists, enabling easier organization and categorisation of NFTs. 

The Fungible Quote Policy facilitates the sale of NFTs with fungible tokens using an escrow account, making it convenient for buyers and sellers to transact.

The Non-fungible Policy sets the token supply to 1 and precision to 0, effectively making the token non-fungible. This is useful when creating unique, one-of-a-kind digital assets. 

Lastly, the Royalty Policy, dependent on the Fungible Quote Policy, allows creators to define an account that receives royalties whenever an NFT using the Fungible Quote Policy is sold. This provides a mechanism for creators to earn ongoing rewards from the sales of their NFTs.

The great thing about concrete policies is that they offer a straightforward and flexible ways to enhance their NFTs with new and exciting capabilities. With concrete policies, Marmalade V2 makes the process of creating and managing NFTs more accessible and efficient, enabling a wider range of individuals and projects to participate in Kadena's  NFT ecosystem.
