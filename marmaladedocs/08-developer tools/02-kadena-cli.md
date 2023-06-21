# Kadena CLI

*WIP: combined cli from all current cli's*

The Kadena Command Line Interface, or as we like to call it, KadenaCLI, is like a faithful sidekick, always ready to assist you in your creative journey within the kadena universe. From developing applications, troubleshooting issues, managing keys and transactions, to directly handling Marmalade's operations, KadenaCLI is the toolbox to assists you.

In essence, the KadenaCLI is not just an addition to Marmalade, but a catalyst that simplifies your interaction with the platform, making your job easier.
It does so by providing an array of functionalities that cater to diverse needs:

1.  **Key Generation & Transaction Management**: KadenaCLI simplifies key generation and assists in constructing transactions across multiple chains using transaction templates. It also allows you to derive transactions from personalized templates stored in a public GitHub repository, a feature tailored for convenience. *(from kda-tool github (andy made a js version of this))*
    
2.  **Transaction Signing**: The interface supports transaction signing using both ED25519 key pairs and Chainweaver-compatible HD keys. It integrates with the Kadena wallet signing API and allows you to sign transactions using your local Chainweaver keys simply by entering your password. *(from kda-tool github (andy made a js version of this))*
    
3.  **Testing & Feedback**: KadenaCLI provides functionalities to test, send, and poll results on the blockchain for multiple transactions. It also supports basic operations for interacting with nodes, thus providing valuable insights for the developers. *(from kda-tool github (andy made a js version of this))*
    
4.  **TypeScript Type Generation**: For those working with Pact Smart Contracts, KadenaCLI can create TypeScript types, thereby enhancing productivity and operational ease. *(from pactjs-cli by albert)*
    
5.  **Project Boilerplate Creation**: KadenaCLI supports the creation of new boilerplate projects in React, Vue, and Angular, assisting developers in initiating projects in their preferred tech stack. *(from create-kadena-app by jermaine)*
    
6.  **Marmalade**: Within Marmalade, KadenaCLI aids in creating, minting  and managing Marmalade NFT's/collections. Furthermore, it simplifies the process of adding policies to collections and listing on marketplaces. *(extend with future features)*
    