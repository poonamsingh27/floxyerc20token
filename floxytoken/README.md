# Floxy Token Smart Contract

# Overview 

The Floxy Token Smart Contract is an ERC-20 and ERC-2771 standards. It provides a set 
of functionalities for managing a token named "Floxy" (symbol: FLOXY). 
The contract includes features such as token transfers, allowances, minting, 
burning, and account freezing. Additionally, it leverages the Ownable and 
ERC2771Context contracts for ownership management and compatibility with EIP-2771
meta transactions.

# Token Details

* Name: Floxy Token
* Symbol: FLOXY
* Decimals: 18

# Features


# Minting

The contract supports the minting of new tokens, allowing the owner to 
increase the total token supply.

# Burning

Tokens can be burned, reducing the total supply. This feature 
helps manage the token's circulation.

# Transfers

Users can transfer Floxy tokens between addresses, subject to the 
specified conditions and account statuses.

# Allowances

Token holders can set allowances, allowing other addresses (spenders) to transfer a 
specified amount of tokens on their behalf.

# Account Freezing

The contract provides a mechanism for the owner to freeze or unfreeze accounts. When an 
account is frozen, token transfers from or to that account are prohibited.


# Functions

# name()
Returns the name of the Floxy token.

# symbol()
Returns the symbol of the Floxy token.

# decimals()
Returns the number of decimals used for user representation of token amounts.

# totalSupply()
Returns the total supply of Floxy tokens.

# balanceOf(address account)
Returns the token balance of the specified account.

# transfer(address to, uint256 amount)
Transfers a specified amount of tokens to the target address.

# allowance(address owner, address spender)
Returns the remaining allowance that spender has to transfer tokens from the owner.

# approve(address spender, uint256 amount)
Allows spender to spend a specified amount of tokens on behalf of the owner.

# transferFrom(address from, address to, uint256 amount)
Transfers a specified amount of tokens from one address to another, given the allowance.

# increaseAllowance(address spender, uint256 addedValue)
Increases the allowance granted to spender by the caller.

# decreaseAllowance(address spender, uint256 subtractedValue)
Decreases the allowance granted to spender by the caller.

# freezeAccount(address target, bool freeze)
Allows the owner to freeze or unfreeze a specified account, preventing or allowing token transfers.
