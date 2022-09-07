# ERC721のデプロイ
.PHONY: erc721
erc721:
	$(eval Erc721 := $(shell forge create --rpc-url ${RPC_URI} --private-key ${PRIV_KEY} node_modules/@openzeppelin/contracts/token/ERC721/${CONTRACT_ERC721} --constructor-args ${ERC721_TOKEN_NAME} ${ERC721_TOKEN_SYMBOL}))
	$(eval ERC721_TOKEN_ADDRESS := $(shell echo $(word 10,$(Erc721))))
	@echo ERC721_TOKEN_ADDRESS=${ERC721_TOKEN_ADDRESS}
